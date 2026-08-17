[CmdletBinding()]
param(
    [string]$ProjectRoot,
    [string]$KeyArtPath = 'art_refs/characters/luna/concept/Luna_KeyArt_REVIEW_v001.png',
    [string]$TurnaroundPath = 'art_refs/characters/luna/turnaround/Luna_Turnaround_REVIEW_v001.png',
    [string]$ExpressionPath = 'art_refs/characters/luna/expressions/Luna_ExpressionSheet_REVIEW_v001.png',
    [string]$EquipmentPath = 'art_refs/characters/luna/equipment/Luna_EquipmentSheet_REVIEW_v001.png',
    [switch]$ProportionOnly,
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Add-Type -AssemblyName System.Drawing

if ([string]::IsNullOrWhiteSpace($ProjectRoot)) {
    $ProjectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
}
else {
    $ProjectRoot = [System.IO.Path]::GetFullPath($ProjectRoot)
}

function Resolve-ProjectPath {
    param([Parameter(Mandatory = $true)][string]$Path)

    $candidate = if ([System.IO.Path]::IsPathRooted($Path)) {
        $Path
    }
    else {
        Join-Path $ProjectRoot $Path
    }

    $resolved = Resolve-Path -LiteralPath $candidate -ErrorAction Stop
    return $resolved.Path
}

function Get-ReviewColor {
    param([Parameter(Mandatory = $true)][string]$Hex)
    return [System.Drawing.ColorTranslator]::FromHtml($Hex)
}

function New-ReviewFont {
    param(
        [Parameter(Mandatory = $true)][float]$Size,
        [System.Drawing.FontStyle]$Style = [System.Drawing.FontStyle]::Regular
    )

    try {
        return [System.Drawing.Font]::new('Segoe UI', $Size, $Style, [System.Drawing.GraphicsUnit]::Pixel)
    }
    catch {
        return [System.Drawing.Font]::new(
            [System.Drawing.FontFamily]::GenericSansSerif,
            $Size,
            $Style,
            [System.Drawing.GraphicsUnit]::Pixel)
    }
}

function Initialize-Graphics {
    param([Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics)

    $Graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $Graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $Graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $Graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
}

function Save-ReviewPng {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Image]$Image,
        [Parameter(Mandatory = $true)][string]$Path
    )

    $directory = Split-Path -Parent $Path
    if (-not [System.IO.Directory]::Exists($directory)) {
        [System.IO.Directory]::CreateDirectory($directory) | Out-Null
    }

    if ([System.IO.File]::Exists($Path) -and -not $Force) {
        throw "Output already exists: $Path. Re-run with -Force to replace deterministic REVIEW evidence."
    }

    $Image.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
}

# Per-pixel mask work stays in a compiled System.Drawing helper so the tool remains
# dependency-free and fast in Windows PowerShell. Both source types are converted
# to opaque, filled silhouettes after small-noise removal and edge-aware hole fill.
if (-not ('ReCamp.SelectedDesign.SilhouetteBuilder' -as [type])) {
    Add-Type -ReferencedAssemblies 'System.Drawing' -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;

namespace ReCamp.SelectedDesign
{
    public static class SilhouetteBuilder
    {
        public static Bitmap FromDarkBackdrop(Bitmap source, Rectangle crop)
        {
            using (Bitmap input = source.Clone(crop, PixelFormat.Format24bppRgb))
            {
                int width = input.Width;
                int height = input.Height;
                byte[] pixels = Read24(input);
                int stride = GetStride(input);
                bool[] mask = new bool[width * height];

                for (int y = 0; y < height; y++)
                {
                    int row = y * stride;
                    for (int x = 0; x < width; x++)
                    {
                        int p = row + x * 3;
                        int b = pixels[p];
                        int g = pixels[p + 1];
                        int r = pixels[p + 2];
                        int max = Math.Max(r, Math.Max(g, b));
                        int min = Math.Min(r, Math.Min(g, b));

                        bool bright = max >= 125;
                        bool warm = r >= 42 && r >= g + 2 && r >= b - 8;
                        bool cyan = g >= 65 && b >= 75 && g >= r + 18;
                        bool neutral = max >= 42 && (max - min) <= 15;
                        mask[y * width + x] = bright || warm || cyan || neutral;
                    }
                }

                mask = Close(mask, width, height, 2);
                RemoveSmallComponents(mask, width, height, 8);
                FillBoundedHoles(mask, width, height);
                return Render(mask, width, height);
            }
        }

        public static Bitmap FromLightBackdrop(Bitmap source, Rectangle crop)
        {
            using (Bitmap input = source.Clone(crop, PixelFormat.Format24bppRgb))
            {
                int width = input.Width;
                int height = input.Height;
                byte[] pixels = Read24(input);
                int stride = GetStride(input);
                bool[] mask = new bool[width * height];

                for (int y = 0; y < height; y++)
                {
                    int sampleWidth = Math.Min(10, Math.Max(1, width / 8));
                    long br = 0, bg = 0, bb = 0;
                    int samples = 0;
                    int row = y * stride;

                    for (int x = 0; x < sampleWidth; x++)
                    {
                        int left = row + x * 3;
                        int right = row + (width - 1 - x) * 3;
                        bb += pixels[left]; bg += pixels[left + 1]; br += pixels[left + 2];
                        bb += pixels[right]; bg += pixels[right + 1]; br += pixels[right + 2];
                        samples += 2;
                    }

                    int baseR = (int)(br / samples);
                    int baseG = (int)(bg / samples);
                    int baseB = (int)(bb / samples);

                    for (int x = 0; x < width; x++)
                    {
                        int p = row + x * 3;
                        int b = pixels[p];
                        int g = pixels[p + 1];
                        int r = pixels[p + 2];
                        int dr = r - baseR;
                        int dg = g - baseG;
                        int db = b - baseB;
                        int distanceSquared = dr * dr + dg * dg + db * db;
                        bool darker = (baseR + baseG + baseB) - (r + g + b) >= 21;
                        mask[y * width + x] = distanceSquared >= 420 || darker;
                    }
                }

                mask = Close(mask, width, height, 2);
                RemoveSmallComponents(mask, width, height, 16);
                FillBoundedHoles(mask, width, height);
                return Render(mask, width, height);
            }
        }

        private static int GetStride(Bitmap bitmap)
        {
            Rectangle rect = new Rectangle(0, 0, bitmap.Width, bitmap.Height);
            BitmapData data = bitmap.LockBits(rect, ImageLockMode.ReadOnly, PixelFormat.Format24bppRgb);
            try { return Math.Abs(data.Stride); }
            finally { bitmap.UnlockBits(data); }
        }

        private static byte[] Read24(Bitmap bitmap)
        {
            Rectangle rect = new Rectangle(0, 0, bitmap.Width, bitmap.Height);
            BitmapData data = bitmap.LockBits(rect, ImageLockMode.ReadOnly, PixelFormat.Format24bppRgb);
            try
            {
                byte[] bytes = new byte[Math.Abs(data.Stride) * bitmap.Height];
                Marshal.Copy(data.Scan0, bytes, 0, bytes.Length);
                return bytes;
            }
            finally { bitmap.UnlockBits(data); }
        }

        private static bool[] Close(bool[] input, int width, int height, int radius)
        {
            return Erode(Dilate(input, width, height, radius), width, height, radius);
        }

        private static bool[] Dilate(bool[] input, int width, int height, int radius)
        {
            bool[] output = new bool[input.Length];
            for (int y = 0; y < height; y++)
            {
                for (int x = 0; x < width; x++)
                {
                    bool value = false;
                    for (int yy = Math.Max(0, y - radius); yy <= Math.Min(height - 1, y + radius) && !value; yy++)
                    {
                        int row = yy * width;
                        for (int xx = Math.Max(0, x - radius); xx <= Math.Min(width - 1, x + radius); xx++)
                        {
                            if (input[row + xx]) { value = true; break; }
                        }
                    }
                    output[y * width + x] = value;
                }
            }
            return output;
        }

        private static bool[] Erode(bool[] input, int width, int height, int radius)
        {
            bool[] output = new bool[input.Length];
            for (int y = 0; y < height; y++)
            {
                for (int x = 0; x < width; x++)
                {
                    bool value = true;
                    for (int yy = y - radius; yy <= y + radius && value; yy++)
                    {
                        if (yy < 0 || yy >= height) { value = false; break; }
                        int row = yy * width;
                        for (int xx = x - radius; xx <= x + radius; xx++)
                        {
                            if (xx < 0 || xx >= width || !input[row + xx]) { value = false; break; }
                        }
                    }
                    output[y * width + x] = value;
                }
            }
            return output;
        }

        private static void RemoveSmallComponents(bool[] mask, int width, int height, int minimumArea)
        {
            bool[] visited = new bool[mask.Length];
            int[] queue = new int[mask.Length];
            int[] dx = { -1, 0, 1, -1, 1, -1, 0, 1 };
            int[] dy = { -1, -1, -1, 0, 0, 1, 1, 1 };

            for (int start = 0; start < mask.Length; start++)
            {
                if (!mask[start] || visited[start]) continue;
                int head = 0, tail = 0;
                queue[tail++] = start;
                visited[start] = true;

                while (head < tail)
                {
                    int index = queue[head++];
                    int x = index % width;
                    int y = index / width;
                    for (int n = 0; n < 8; n++)
                    {
                        int nx = x + dx[n], ny = y + dy[n];
                        if (nx < 0 || ny < 0 || nx >= width || ny >= height) continue;
                        int next = ny * width + nx;
                        if (mask[next] && !visited[next])
                        {
                            visited[next] = true;
                            queue[tail++] = next;
                        }
                    }
                }

                if (tail < minimumArea)
                    for (int i = 0; i < tail; i++) mask[queue[i]] = false;
            }
        }

        private static void FillBoundedHoles(bool[] mask, int width, int height)
        {
            bool[] outside = new bool[mask.Length];
            int[] queue = new int[mask.Length];
            int head = 0, tail = 0;

            Action<int> seed = delegate(int index)
            {
                if (!mask[index] && !outside[index])
                {
                    outside[index] = true;
                    queue[tail++] = index;
                }
            };

            for (int x = 0; x < width; x++) { seed(x); seed((height - 1) * width + x); }
            for (int y = 0; y < height; y++) { seed(y * width); seed(y * width + width - 1); }

            int[] dx = { -1, 1, 0, 0 };
            int[] dy = { 0, 0, -1, 1 };
            while (head < tail)
            {
                int index = queue[head++];
                int x = index % width;
                int y = index / width;
                for (int n = 0; n < 4; n++)
                {
                    int nx = x + dx[n], ny = y + dy[n];
                    if (nx < 0 || ny < 0 || nx >= width || ny >= height) continue;
                    int next = ny * width + nx;
                    if (!mask[next] && !outside[next])
                    {
                        outside[next] = true;
                        queue[tail++] = next;
                    }
                }
            }

            for (int i = 0; i < mask.Length; i++)
                if (!mask[i] && !outside[i]) mask[i] = true;
        }

        private static Bitmap Render(bool[] mask, int width, int height)
        {
            Bitmap output = new Bitmap(width, height, PixelFormat.Format32bppArgb);
            Rectangle rect = new Rectangle(0, 0, width, height);
            BitmapData data = output.LockBits(rect, ImageLockMode.WriteOnly, PixelFormat.Format32bppArgb);
            try
            {
                byte[] bytes = new byte[Math.Abs(data.Stride) * height];
                for (int y = 0; y < height; y++)
                {
                    int row = y * data.Stride;
                    for (int x = 0; x < width; x++)
                    {
                        if (!mask[y * width + x]) continue;
                        int p = row + x * 4;
                        bytes[p] = 45;
                        bytes[p + 1] = 31;
                        bytes[p + 2] = 23;
                        bytes[p + 3] = 255;
                    }
                }
                Marshal.Copy(bytes, 0, data.Scan0, bytes.Length);
            }
            finally { output.UnlockBits(data); }
            return output;
        }
    }
}
'@
}

function New-Face128Evidence {
    param([Parameter(Mandatory = $true)][System.Drawing.Bitmap]$ExpressionSheet)

    # Friendly top-row, second-panel smile. The fixed square excludes neighboring
    # panels and keeps eyes, mouth, chin, hood rim, and hair accents readable.
    $crop = [System.Drawing.Rectangle]::new(500, 72, 300, 300)
    $output = [System.Drawing.Bitmap]::new(128, 128, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($output)
    $attributes = [System.Drawing.Imaging.ImageAttributes]::new()
    try {
        Initialize-Graphics -Graphics $graphics
        $graphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
        $attributes.SetWrapMode([System.Drawing.Drawing2D.WrapMode]::TileFlipXY)
        $graphics.DrawImage(
            $ExpressionSheet,
            [System.Drawing.Rectangle]::new(0, 0, 128, 128),
            $crop.X,
            $crop.Y,
            $crop.Width,
            $crop.Height,
            [System.Drawing.GraphicsUnit]::Pixel,
            $attributes)
    }
    finally {
        $attributes.Dispose()
        $graphics.Dispose()
    }
    return $output
}

function New-SilhouetteEvidence {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Bitmap]$KeyArt,
        [Parameter(Mandatory = $true)][System.Drawing.Bitmap]$Turnaround
    )

    $keyCrop = [System.Drawing.Rectangle]::new(0, 40, 866, 1695)
    $frontCrop = [System.Drawing.Rectangle]::new(170, 10, 360, 920)
    $keyMask = [ReCamp.SelectedDesign.SilhouetteBuilder]::FromDarkBackdrop($KeyArt, $keyCrop)
    $frontMask = [ReCamp.SelectedDesign.SilhouetteBuilder]::FromLightBackdrop($Turnaround, $frontCrop)

    $canvas = [System.Drawing.Bitmap]::new(1600, 960, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($canvas)
    $titleFont = New-ReviewFont 38 ([System.Drawing.FontStyle]::Bold)
    $subtitleFont = New-ReviewFont 21
    $labelFont = New-ReviewFont 25 ([System.Drawing.FontStyle]::Bold)
    $bodyFont = New-ReviewFont 18
    $backgroundBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#E9EEF4'))
    $panelBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $titleBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#0F172A'))
    $mutedBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#475569'))
    $cyanBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#0E7490'))
    $borderPen = [System.Drawing.Pen]::new((Get-ReviewColor '#CBD5E1'), 2.0)
    $guidePen = [System.Drawing.Pen]::new((Get-ReviewColor '#64748B'), 2.0)
    $guidePen.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash

    try {
        Initialize-Graphics -Graphics $graphics
        $graphics.FillRectangle($backgroundBrush, 0, 0, $canvas.Width, $canvas.Height)
        $graphics.DrawString('Luna - Height-normalized Silhouette Review', $titleFont, $titleBrush, 48, 24)
        $graphics.DrawString(
            'Same crown-to-sole height | KeyArt equipment load vs turnaround front readability',
            $subtitleFont,
            $mutedBrush,
            50,
            76)

        $leftPanel = [System.Drawing.Rectangle]::new(40, 120, 740, 790)
        $rightPanel = [System.Drawing.Rectangle]::new(820, 120, 740, 790)
        $graphics.FillRectangle($panelBrush, $leftPanel)
        $graphics.FillRectangle($panelBrush, $rightPanel)
        $graphics.DrawRectangle($borderPen, $leftPanel)
        $graphics.DrawRectangle($borderPen, $rightPanel)

        $targetCrownY = 205.0
        $targetSoleY = 805.0
        $normalizedHeight = $targetSoleY - $targetCrownY
        $keyScale = $normalizedHeight / (1698.0 - 116.0)
        $frontScale = $normalizedHeight / (910.0 - 53.0)

        $keyWidth = $keyMask.Width * $keyScale
        $keyHeight = $keyMask.Height * $keyScale
        $keyX = 410.0 - ($keyWidth / 2.0)
        $keyY = $targetCrownY - ((116.0 - $keyCrop.Y) * $keyScale)
        $frontWidth = $frontMask.Width * $frontScale
        $frontHeight = $frontMask.Height * $frontScale
        $frontX = 1190.0 - ($frontWidth / 2.0)
        $frontY = $targetCrownY - ((53.0 - $frontCrop.Y) * $frontScale)

        $graphics.DrawImage($keyMask, [System.Drawing.RectangleF]::new($keyX, $keyY, $keyWidth, $keyHeight))
        $graphics.DrawImage($frontMask, [System.Drawing.RectangleF]::new($frontX, $frontY, $frontWidth, $frontHeight))

        foreach ($x in @(58, 838)) {
            $graphics.DrawLine($guidePen, $x, $targetCrownY, $x + 704, $targetCrownY)
            $graphics.DrawLine($guidePen, $x, $targetSoleY, $x + 704, $targetSoleY)
        }

        $graphics.DrawString('CROWN', $bodyFont, $mutedBrush, 62, $targetCrownY - 25)
        $graphics.DrawString('SOLE', $bodyFont, $mutedBrush, 62, $targetSoleY - 25)
        $graphics.DrawString('CROWN', $bodyFont, $mutedBrush, 842, $targetCrownY - 25)
        $graphics.DrawString('SOLE', $bodyFont, $mutedBrush, 842, $targetSoleY - 25)

        $graphics.DrawString('A | KEY ART / EQUIPMENT INCLUDED', $labelFont, $titleBrush, 154, 842)
        $graphics.DrawString('Backpack + cable tail + paired daggers', $bodyFont, $cyanBrush, 220, 881)
        $graphics.DrawString('B | TURNAROUND FRONT / GEAR MINIMAL', $labelFont, $titleBrush, 900, 842)
        $graphics.DrawString('Costume silhouette + wrist emitter; weapons removed', $bodyFont, $cyanBrush, 918, 881)

        $graphics.DrawString(
            'REVIEW / Human approval Pending / APPROVED: NOT GRANTED',
            $bodyFont,
            $mutedBrush,
            1040,
            929)
    }
    finally {
        $guidePen.Dispose(); $borderPen.Dispose()
        $cyanBrush.Dispose(); $mutedBrush.Dispose(); $titleBrush.Dispose(); $panelBrush.Dispose(); $backgroundBrush.Dispose()
        $bodyFont.Dispose(); $labelFont.Dispose(); $subtitleFont.Dispose(); $titleFont.Dispose()
        $graphics.Dispose(); $keyMask.Dispose(); $frontMask.Dispose()
    }

    return $canvas
}

function New-MaterialPaletteEvidence {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Bitmap]$EquipmentSheet
    )

    # EquipmentSheet is intentionally opened and dimension-checked by the caller.
    # The swatches below are the exact implementation handoff values.
    $swatches = @(
        [pscustomobject]@{ Name = 'HairSilver'; Hex = '#C8D2D4'; Role = 'Hair base / soft specular' },
        [pscustomobject]@{ Name = 'HairMint'; Hex = '#79D8CE'; Role = 'Hair tips / gradient accent' },
        [pscustomobject]@{ Name = 'ShellCream'; Hex = '#E9E3DA'; Role = 'Jacket shell / hood' },
        [pscustomobject]@{ Name = 'InnerCharcoal'; Hex = '#20242D'; Role = 'Inner suit / shorts' },
        [pscustomobject]@{ Name = 'EquipmentGraphite'; Hex = '#303844'; Role = 'Backpack / blades' },
        [pscustomobject]@{ Name = 'EmissionCyan'; Hex = '#35E7FF'; Role = 'Sensors / edge emission' },
        [pscustomobject]@{ Name = 'AccentHotPink'; Hex = '#FF4F7B'; Role = 'Warning marks / micro accent' },
        [pscustomobject]@{ Name = 'SkinWarm'; Hex = '#F2C7B5'; Role = 'Skin base / warm midtone' },
        [pscustomobject]@{ Name = 'BackdropNavy'; Hex = '#07111F'; Role = 'Review backdrop / contrast' }
    )

    $canvas = [System.Drawing.Bitmap]::new(1600, 1050, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($canvas)
    $titleFont = New-ReviewFont 40 ([System.Drawing.FontStyle]::Bold)
    $subtitleFont = New-ReviewFont 21
    $nameFont = New-ReviewFont 25 ([System.Drawing.FontStyle]::Bold)
    $hexFont = New-ReviewFont 22 ([System.Drawing.FontStyle]::Bold)
    $roleFont = New-ReviewFont 17
    $smallFont = New-ReviewFont 15 ([System.Drawing.FontStyle]::Bold)
    $backgroundBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#F4F7FA'))
    $cardBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $titleBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#0F172A'))
    $mutedBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#475569'))
    $borderPen = [System.Drawing.Pen]::new((Get-ReviewColor '#CBD5E1'), 2.0)

    try {
        Initialize-Graphics -Graphics $graphics
        $graphics.FillRectangle($backgroundBrush, 0, 0, $canvas.Width, $canvas.Height)
        $graphics.DrawString('Luna - Material Palette / REVIEW', $titleFont, $titleBrush, 52, 28)
        $graphics.DrawString(
            'Exact sRGB handoff swatches derived from selected KeyArt, turnaround, expressions, and equipment sheet',
            $subtitleFont,
            $mutedBrush,
            54,
            82)

        for ($i = 0; $i -lt $swatches.Count; $i++) {
            $column = $i % 3
            $row = [Math]::Floor($i / 3)
            $cardX = 50 + ($column * 510)
            $cardY = 135 + ($row * 222)
            $card = [System.Drawing.Rectangle]::new($cardX, $cardY, 480, 198)
            $swatchRect = [System.Drawing.Rectangle]::new($cardX + 18, $cardY + 20, 142, 126)
            $color = Get-ReviewColor $swatches[$i].Hex
            $swatchBrush = [System.Drawing.SolidBrush]::new($color)
            try {
                $graphics.FillRectangle($cardBrush, $card)
                $graphics.DrawRectangle($borderPen, $card)
                $graphics.FillRectangle($swatchBrush, $swatchRect)
                $graphics.DrawRectangle($borderPen, $swatchRect)
                $graphics.DrawString($swatches[$i].Name, $nameFont, $titleBrush, $cardX + 180, $cardY + 22)
                $graphics.DrawString($swatches[$i].Hex, $hexFont, $mutedBrush, $cardX + 180, $cardY + 62)
                $graphics.DrawString('Material slot', $smallFont, $mutedBrush, $cardX + 180, $cardY + 106)
                $graphics.DrawString($swatches[$i].Role, $roleFont, $titleBrush, $cardX + 180, $cardY + 132)
            }
            finally { $swatchBrush.Dispose() }
        }

        $graphics.DrawString('Grayscale readability check', $nameFont, $titleBrush, 54, 815)
        $graphics.DrawString(
            'Relative luminance only; identity must not depend on hue alone.',
            $roleFont,
            $mutedBrush,
            425,
            822)

        for ($i = 0; $i -lt $swatches.Count; $i++) {
            $sourceColor = Get-ReviewColor $swatches[$i].Hex
            $gray = [int][Math]::Round(
                (0.2126 * $sourceColor.R) + (0.7152 * $sourceColor.G) + (0.0722 * $sourceColor.B))
            $grayBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb($gray, $gray, $gray))
            $miniX = 54 + ($i * 169)
            try {
                $graphics.FillRectangle($grayBrush, $miniX, 866, 151, 62)
                $graphics.DrawRectangle($borderPen, $miniX, 866, 151, 62)
                $graphics.DrawString(($i + 1).ToString('00'), $smallFont, $titleBrush, $miniX + 61, 938)
            }
            finally { $grayBrush.Dispose() }
        }

        $graphics.DrawString(
            'REVIEW / Human approval Pending / APPROVED: NOT GRANTED',
            $roleFont,
            $mutedBrush,
            1060,
            1008)
    }
    finally {
        $borderPen.Dispose(); $mutedBrush.Dispose(); $titleBrush.Dispose(); $cardBrush.Dispose(); $backgroundBrush.Dispose()
        $smallFont.Dispose(); $roleFont.Dispose(); $hexFont.Dispose(); $nameFont.Dispose(); $subtitleFont.Dispose(); $titleFont.Dispose()
        $graphics.Dispose()
    }

    return $canvas
}

function New-ProportionEvidence {
    param([Parameter(Mandatory = $true)][System.Drawing.Bitmap]$KeyArt)

    $crown = [System.Drawing.Point]::new(409, 116)
    $chin = [System.Drawing.Point]::new(419, 339)
    $sole = [System.Drawing.Point]::new(611, 1698)
    $headPixels = [double]($chin.Y - $crown.Y)
    $bodyPixels = [double]($sole.Y - $crown.Y)
    $headUnits = $bodyPixels / $headPixels
    $targetMin = 6.9
    $targetMax = 7.1
    $status = if ($headUnits -ge $targetMin -and $headUnits -le $targetMax) { 'PASS' } else { 'FAIL' }

    $canvas = [System.Drawing.Bitmap]::new(1600, 2000, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($canvas)
    $titleFont = New-ReviewFont 42 ([System.Drawing.FontStyle]::Bold)
    $subtitleFont = New-ReviewFont 22
    $cardTitleFont = New-ReviewFont 30 ([System.Drawing.FontStyle]::Bold)
    $valueFont = New-ReviewFont 64 ([System.Drawing.FontStyle]::Bold)
    $bodyFont = New-ReviewFont 21
    $smallFont = New-ReviewFont 17
    $backgroundBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#07111F'))
    $titleBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#F8FAFC'))
    $mutedBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#94A3B8'))
    $cyanBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#35E7FF'))
    $passBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#5EE6A8'))
    $cardBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(238, 17, 26, 43))
    $borderPen = [System.Drawing.Pen]::new((Get-ReviewColor '#334155'), 2.0)
    $headPen = [System.Drawing.Pen]::new((Get-ReviewColor '#35E7FF'), 2.5)
    $headPen.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash
    $solePen = [System.Drawing.Pen]::new((Get-ReviewColor '#FF4F7B'), 3.5)
    $pointPen = [System.Drawing.Pen]::new((Get-ReviewColor '#F8FAFC'), 3.0)

    try {
        Initialize-Graphics -Graphics $graphics
        $graphics.FillRectangle($backgroundBrush, 0, 0, $canvas.Width, $canvas.Height)
        $graphics.DrawString('Luna - 2D Proportion Gate Evidence / REVIEW', $titleFont, $titleBrush, 52, 28)
        $graphics.DrawString(
            'Selected KeyArt | visible hood-dome crown, sensor ears excluded from anatomical head unit',
            $subtitleFont,
            $mutedBrush,
            54,
            88)

        $imageX = 58.0
        $imageY = 150.0
        $imageWidth = 820.0
        $scale = $imageWidth / $KeyArt.Width
        $imageHeight = $KeyArt.Height * $scale
        $graphics.DrawImage($KeyArt, [System.Drawing.RectangleF]::new($imageX, $imageY, $imageWidth, $imageHeight))
        $graphics.DrawRectangle($borderPen, [int]$imageX, [int]$imageY, [int]$imageWidth, [int]$imageHeight)

        $guideLeft = $imageX + 18
        $guideRight = $imageX + $imageWidth - 18
        for ($unit = 0; $unit -le 7; $unit++) {
            $sourceY = $crown.Y + ($unit * $headPixels)
            $canvasY = $imageY + ($sourceY * $scale)
            $graphics.DrawLine($headPen, $guideLeft, $canvasY, $guideRight, $canvasY)
            $label = if ($unit -eq 0) { '0H CROWN' } elseif ($unit -eq 1) { '1H CHIN' } else { "${unit}H" }
            $graphics.DrawString($label, $smallFont, $titleBrush, $guideLeft + 8, $canvasY + 4)
        }

        $soleY = $imageY + ($sole.Y * $scale)
        $graphics.DrawLine($solePen, $guideLeft, $soleY, $guideRight, $soleY)
        $graphics.DrawString('SOLE / 7.09H', $smallFont, $titleBrush, $guideLeft + 8, $soleY - 28)

        foreach ($point in @($crown, $chin, $sole)) {
            $px = $imageX + ($point.X * $scale)
            $py = $imageY + ($point.Y * $scale)
            $graphics.DrawEllipse($pointPen, $px - 7, $py - 7, 14, 14)
        }

        $card = [System.Drawing.Rectangle]::new(930, 170, 620, 700)
        $graphics.FillRectangle($cardBrush, $card)
        $graphics.DrawRectangle($borderPen, $card)
        $graphics.DrawString('HEAD-UNIT RESULT', $cardTitleFont, $cyanBrush, 978, 220)
        $graphics.DrawString(('{0:F2} H' -f $headUnits), $valueFont, $titleBrush, 978, 285)
        $graphics.DrawString($status, $valueFont, $passBrush, 978, 375)
        $graphics.DrawString('Target band', $bodyFont, $mutedBrush, 980, 490)
        $graphics.DrawString('6.90 - 7.10 H', $cardTitleFont, $titleBrush, 980, 525)
        $graphics.DrawString('Head unit', $bodyFont, $mutedBrush, 980, 605)
        $graphics.DrawString('chinY - crownY = 339 - 116 = 223 px', $bodyFont, $titleBrush, 980, 640)
        $graphics.DrawString('Body span', $bodyFont, $mutedBrush, 980, 705)
        $graphics.DrawString('soleY - crownY = 1698 - 116 = 1582 px', $bodyFont, $titleBrush, 980, 740)
        $graphics.DrawString('1582 / 223 = 7.094...', $cardTitleFont, $cyanBrush, 980, 800)

        $methodCard = [System.Drawing.Rectangle]::new(930, 920, 620, 470)
        $graphics.FillRectangle($cardBrush, $methodCard)
        $graphics.DrawRectangle($borderPen, $methodCard)
        $graphics.DrawString('LANDMARK METHOD', $cardTitleFont, $cyanBrush, 978, 965)
        $graphics.DrawString('Crown  (409, 116)', $bodyFont, $titleBrush, 980, 1030)
        $graphics.DrawString('Chin   (419, 339)', $bodyFont, $titleBrush, 980, 1075)
        $graphics.DrawString('Sole   (611, 1698)', $bodyFont, $titleBrush, 980, 1120)
        $graphics.DrawString('Sensor ears are equipment and do not extend the', $bodyFont, $mutedBrush, 980, 1195)
        $graphics.DrawString('anatomical crown. Pose is not perspective-corrected;', $bodyFont, $mutedBrush, 980, 1232)
        $graphics.DrawString('this is a deterministic image-space gate.', $bodyFont, $mutedBrush, 980, 1269)
        $graphics.DrawString('Evidence status: REVIEW', $bodyFont, $titleBrush, 980, 1330)

        $approvalCard = [System.Drawing.Rectangle]::new(930, 1440, 620, 350)
        $graphics.FillRectangle($cardBrush, $approvalCard)
        $graphics.DrawRectangle($borderPen, $approvalCard)
        $graphics.DrawString('APPROVAL STATE', $cardTitleFont, $cyanBrush, 978, 1485)
        $graphics.DrawString('Human approval', $bodyFont, $mutedBrush, 980, 1560)
        $graphics.DrawString('Pending', $cardTitleFont, $titleBrush, 980, 1598)
        $graphics.DrawString('APPROVED', $bodyFont, $mutedBrush, 980, 1670)
        $graphics.DrawString('NOT GRANTED', $cardTitleFont, $titleBrush, 980, 1708)

        $graphics.DrawString(
            'Generated deterministically by tools/art/Build-LunaSelectedDesignEvidence.ps1',
            $smallFont,
            $mutedBrush,
            935,
            1910)
    }
    finally {
        $pointPen.Dispose(); $solePen.Dispose(); $headPen.Dispose(); $borderPen.Dispose()
        $cardBrush.Dispose(); $passBrush.Dispose(); $cyanBrush.Dispose(); $mutedBrush.Dispose(); $titleBrush.Dispose(); $backgroundBrush.Dispose()
        $smallFont.Dispose(); $bodyFont.Dispose(); $valueFont.Dispose(); $cardTitleFont.Dispose(); $subtitleFont.Dispose(); $titleFont.Dispose()
        $graphics.Dispose()
    }

    return [pscustomobject]@{ Image = $canvas; HeadUnits = $headUnits; Status = $status }
}

$resolvedKeyArt = Resolve-ProjectPath $KeyArtPath
$resolvedTurnaround = Resolve-ProjectPath $TurnaroundPath
$resolvedExpressions = Resolve-ProjectPath $ExpressionPath
$resolvedEquipment = Resolve-ProjectPath $EquipmentPath

$keyArt = [System.Drawing.Bitmap]::FromFile($resolvedKeyArt)
$turnaround = [System.Drawing.Bitmap]::FromFile($resolvedTurnaround)
$expressions = [System.Drawing.Bitmap]::FromFile($resolvedExpressions)
$equipment = [System.Drawing.Bitmap]::FromFile($resolvedEquipment)

try {
    $expected = @(
        [pscustomobject]@{ Name = 'KeyArt'; Image = $keyArt; Width = 866; Height = 1817 },
        [pscustomobject]@{ Name = 'Turnaround'; Image = $turnaround; Width = 1672; Height = 941 },
        [pscustomobject]@{ Name = 'Expressions'; Image = $expressions; Width = 1717; Height = 916 },
        [pscustomobject]@{ Name = 'Equipment'; Image = $equipment; Width = 1536; Height = 1024 }
    )

    foreach ($item in $expected) {
        if ($item.Image.Width -ne $item.Width -or $item.Image.Height -ne $item.Height) {
            throw "$($item.Name) dimensions changed: expected $($item.Width)x$($item.Height), got $($item.Image.Width)x$($item.Image.Height). Review fixed landmarks before rebuilding evidence."
        }
    }

    $conceptDirectory = Join-Path $ProjectRoot 'art_refs/characters/luna/concept'
    $facePath = Join-Path $conceptDirectory 'Luna_Face128_REVIEW_v002.png'
    $silhouettePath = Join-Path $conceptDirectory 'Luna_SilhouetteTest_REVIEW_v002.png'
    $palettePath = Join-Path $conceptDirectory 'Luna_MaterialPalette_REVIEW_v001.png'
    $proportionPath = Join-Path $conceptDirectory 'Luna_ProportionGateEvidence_REVIEW_v002.png'

    if (-not $ProportionOnly) {
        $face = New-Face128Evidence -ExpressionSheet $expressions
        try { Save-ReviewPng -Image $face -Path $facePath }
        finally { $face.Dispose() }

        $silhouette = New-SilhouetteEvidence -KeyArt $keyArt -Turnaround $turnaround
        try { Save-ReviewPng -Image $silhouette -Path $silhouettePath }
        finally { $silhouette.Dispose() }

        $palette = New-MaterialPaletteEvidence -EquipmentSheet $equipment
        try { Save-ReviewPng -Image $palette -Path $palettePath }
        finally { $palette.Dispose() }
    }

    $proportion = New-ProportionEvidence -KeyArt $keyArt
    try { Save-ReviewPng -Image $proportion.Image -Path $proportionPath }
    finally { $proportion.Image.Dispose() }

    [pscustomobject]@{
        Face128 = $facePath
        Silhouette = $silhouettePath
        MaterialPalette = $palettePath
        Proportion = $proportionPath
        HeadUnits = [Math]::Round($proportion.HeadUnits, 2)
        Gate = $proportion.Status
        Status = 'REVIEW'
        HumanApproval = 'Pending'
        Approved = 'NOT GRANTED'
    }
}
finally {
    $equipment.Dispose()
    $expressions.Dispose()
    $turnaround.Dispose()
    $keyArt.Dispose()
}
