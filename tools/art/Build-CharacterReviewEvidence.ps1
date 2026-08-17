[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$SourcePath,

    [string]$OutputDirectory,
    [string]$AssetPrefix = 'Luna',
    [string]$OutputVersion = 'v001',
    [string]$CandidateAPath,
    [string]$CandidateBPath,
    [string]$CandidateCPath,
    [string]$CandidateACrown = '480,109',
    [string]$CandidateAChin = '480,300',
    [string]$CandidateASole = '321,1444',
    [string]$CandidateBCrown = '403,92',
    [string]$CandidateBChin = '385,287',
    [string]$CandidateBSole = '660,1763',
    [string]$CandidateCCrown = '500,99',
    [string]$CandidateCChin = '489,300',
    [string]$CandidateCSole = '270,1635',

    # Image-space review landmarks. Sensor ears are excluded; the visible hood dome
    # following the skull is used as the crown because the anatomical crown is hidden.
    [string]$LeftCrown = '492,57',
    [string]$LeftChin = '479,190',
    [string]$LeftSole = '329,984',
    [string]$RightCrown = '1080,349',
    [string]$RightChin = '1092,494',
    [string]$RightSole = '990,949',

    [string]$FaceCrop = '400,40,200,200',
    [string]$LeftSilhouetteCrop = '205,15,560,971',
    [string]$RightSilhouetteCrop = '835,295,475,656',

    [double]$LeftTargetMin = 6.9,
    [double]$LeftTargetMax = 7.1,
    [double]$RightTargetMin = 5.3,
    [double]$RightTargetMax = 5.4,

    [int]$BrightThreshold = 125,
    [int]$NeutralFloor = 42,
    [int]$NeutralRange = 15,
    [int]$CyanFloor = 65,
    [int]$MorphologyRadius = 2,
    [int]$MinimumComponentArea = 10,
    [int]$MaximumHoleArea = 800,

    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Add-Type -AssemblyName System.Drawing

# The helper keeps per-pixel work out of the PowerShell pipeline while staying
# dependency-free and System.Drawing-based. It classifies the source's dark-blue
# backdrop, closes small breaks, removes isolated specks, and fills only bounded
# small holes while preserving large negative spaces between limbs and equipment.
if (-not ('ReCamp.ArtReview.SilhouetteMask' -as [type])) {
    Add-Type -ReferencedAssemblies 'System.Drawing' -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;

namespace ReCamp.ArtReview
{
    public static class SilhouetteMask
    {
        public static Bitmap Build(
            Bitmap source,
            Rectangle crop,
            int brightThreshold,
            int neutralFloor,
            int neutralRange,
            int cyanFloor,
            int morphologyRadius,
            int minimumComponentArea,
            int maximumHoleArea)
        {
            if (source == null) throw new ArgumentNullException("source");
            if (crop.Width <= 0 || crop.Height <= 0)
                throw new ArgumentOutOfRangeException("crop");
            if (crop.Left < 0 || crop.Top < 0 ||
                crop.Right > source.Width || crop.Bottom > source.Height)
                throw new ArgumentException("Silhouette crop is outside the source image.", "crop");

            using (Bitmap input = source.Clone(crop, PixelFormat.Format24bppRgb))
            {
                int width = input.Width;
                int height = input.Height;
                bool[] mask = Classify(
                    input,
                    brightThreshold,
                    neutralFloor,
                    neutralRange,
                    cyanFloor);

                if (morphologyRadius > 0)
                {
                    mask = Erode(
                        Dilate(mask, width, height, morphologyRadius),
                        width,
                        height,
                        morphologyRadius);
                }

                if (minimumComponentArea > 1)
                    RemoveSmallComponents(mask, width, height, minimumComponentArea);
                if (maximumHoleArea > 0)
                    FillSmallHoles(mask, width, height, maximumHoleArea);

                return Render(mask, width, height);
            }
        }

        private static bool[] Classify(
            Bitmap input,
            int brightThreshold,
            int neutralFloor,
            int neutralRange,
            int cyanFloor)
        {
            int width = input.Width;
            int height = input.Height;
            bool[] result = new bool[width * height];
            Rectangle rect = new Rectangle(0, 0, width, height);
            BitmapData data = input.LockBits(rect, ImageLockMode.ReadOnly, PixelFormat.Format24bppRgb);

            try
            {
                int stride = data.Stride;
                byte[] bytes = new byte[Math.Abs(stride) * height];
                Marshal.Copy(data.Scan0, bytes, 0, bytes.Length);

                for (int y = 0; y < height; y++)
                {
                    int row = y * stride;
                    for (int x = 0; x < width; x++)
                    {
                        int i = row + x * 3;
                        int b = bytes[i];
                        int g = bytes[i + 1];
                        int r = bytes[i + 2];
                        int max = Math.Max(r, Math.Max(g, b));
                        int min = Math.Min(r, Math.Min(g, b));

                        bool bright = max >= brightThreshold;
                        bool neutral =
                            max >= neutralFloor &&
                            (max - min) <= neutralRange;
                        bool warm =
                            r >= neutralFloor &&
                            r >= g + 2 &&
                            r >= b - 8;
                        bool cyan =
                            g >= cyanFloor &&
                            b >= cyanFloor + 10 &&
                            g >= r + 18;

                        result[y * width + x] = bright || neutral || warm || cyan;
                    }
                }
            }
            finally
            {
                input.UnlockBits(data);
            }

            return result;
        }

        private static bool[] Dilate(bool[] input, int width, int height, int radius)
        {
            bool[] output = new bool[input.Length];
            for (int y = 0; y < height; y++)
            {
                int y0 = Math.Max(0, y - radius);
                int y1 = Math.Min(height - 1, y + radius);
                for (int x = 0; x < width; x++)
                {
                    int x0 = Math.Max(0, x - radius);
                    int x1 = Math.Min(width - 1, x + radius);
                    bool value = false;
                    for (int yy = y0; yy <= y1 && !value; yy++)
                    {
                        int row = yy * width;
                        for (int xx = x0; xx <= x1; xx++)
                        {
                            if (input[row + xx])
                            {
                                value = true;
                                break;
                            }
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
                        if (yy < 0 || yy >= height)
                        {
                            value = false;
                            break;
                        }

                        int row = yy * width;
                        for (int xx = x - radius; xx <= x + radius; xx++)
                        {
                            if (xx < 0 || xx >= width || !input[row + xx])
                            {
                                value = false;
                                break;
                            }
                        }
                    }
                    output[y * width + x] = value;
                }
            }
            return output;
        }

        private static void RemoveSmallComponents(
            bool[] mask,
            int width,
            int height,
            int minimumArea)
        {
            bool[] visited = new bool[mask.Length];
            int[] queue = new int[mask.Length];
            int[] neighborsX = { -1, 0, 1, -1, 1, -1, 0, 1 };
            int[] neighborsY = { -1, -1, -1, 0, 0, 1, 1, 1 };

            for (int start = 0; start < mask.Length; start++)
            {
                if (!mask[start] || visited[start])
                    continue;

                int head = 0;
                int tail = 0;
                queue[tail++] = start;
                visited[start] = true;

                while (head < tail)
                {
                    int index = queue[head++];
                    int x = index % width;
                    int y = index / width;

                    for (int n = 0; n < 8; n++)
                    {
                        int nx = x + neighborsX[n];
                        int ny = y + neighborsY[n];
                        if (nx < 0 || nx >= width || ny < 0 || ny >= height)
                            continue;

                        int neighbor = ny * width + nx;
                        if (mask[neighbor] && !visited[neighbor])
                        {
                            visited[neighbor] = true;
                            queue[tail++] = neighbor;
                        }
                    }
                }

                if (tail < minimumArea)
                {
                    for (int i = 0; i < tail; i++)
                        mask[queue[i]] = false;
                }
            }
        }

        private static void FillSmallHoles(
            bool[] mask,
            int width,
            int height,
            int maximumArea)
        {
            bool[] visited = new bool[mask.Length];
            int[] queue = new int[mask.Length];
            int[] neighborsX = { -1, 0, 1, 0 };
            int[] neighborsY = { 0, -1, 0, 1 };

            for (int start = 0; start < mask.Length; start++)
            {
                if (mask[start] || visited[start])
                    continue;

                int head = 0;
                int tail = 0;
                bool touchesBorder = false;
                queue[tail++] = start;
                visited[start] = true;

                while (head < tail)
                {
                    int index = queue[head++];
                    int x = index % width;
                    int y = index / width;
                    if (x == 0 || x == width - 1 || y == 0 || y == height - 1)
                        touchesBorder = true;

                    for (int n = 0; n < 4; n++)
                    {
                        int nx = x + neighborsX[n];
                        int ny = y + neighborsY[n];
                        if (nx < 0 || nx >= width || ny < 0 || ny >= height)
                            continue;

                        int neighbor = ny * width + nx;
                        if (!mask[neighbor] && !visited[neighbor])
                        {
                            visited[neighbor] = true;
                            queue[tail++] = neighbor;
                        }
                    }
                }

                if (!touchesBorder && tail <= maximumArea)
                {
                    for (int i = 0; i < tail; i++)
                        mask[queue[i]] = true;
                }
            }
        }

        private static Bitmap Render(bool[] mask, int width, int height)
        {
            Bitmap output = new Bitmap(width, height, PixelFormat.Format32bppArgb);
            Rectangle rect = new Rectangle(0, 0, width, height);
            BitmapData data = output.LockBits(rect, ImageLockMode.WriteOnly, PixelFormat.Format32bppArgb);

            try
            {
                int stride = data.Stride;
                byte[] bytes = new byte[Math.Abs(stride) * height];
                for (int y = 0; y < height; y++)
                {
                    int row = y * stride;
                    for (int x = 0; x < width; x++)
                    {
                        if (!mask[y * width + x])
                            continue;

                        int i = row + x * 4;
                        bytes[i] = 0;
                        bytes[i + 1] = 0;
                        bytes[i + 2] = 0;
                        bytes[i + 3] = 255;
                    }
                }
                Marshal.Copy(bytes, 0, data.Scan0, bytes.Length);
            }
            finally
            {
                output.UnlockBits(data);
            }

            return output;
        }
    }
}
'@
}

function ConvertTo-Point {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Value,
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    $parts = $Value.Split(',')
    if ($parts.Count -ne 2) {
        throw "$Name must use x,y format. Received: '$Value'."
    }

    $x = 0
    $y = 0
    if (-not [int]::TryParse($parts[0].Trim(), [ref]$x) -or
        -not [int]::TryParse($parts[1].Trim(), [ref]$y)) {
        throw "$Name must contain integer coordinates. Received: '$Value'."
    }

    return [System.Drawing.Point]::new($x, $y)
}

function ConvertTo-Rectangle {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Value,
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    $parts = $Value.Split(',')
    if ($parts.Count -ne 4) {
        throw "$Name must use x,y,width,height format. Received: '$Value'."
    }

    $values = New-Object int[] 4
    for ($i = 0; $i -lt 4; $i++) {
        $parsed = 0
        if (-not [int]::TryParse($parts[$i].Trim(), [ref]$parsed)) {
            throw "$Name must contain integer values. Received: '$Value'."
        }
        $values[$i] = $parsed
    }

    if ($values[2] -le 0 -or $values[3] -le 0) {
        throw "$Name width and height must be positive. Received: '$Value'."
    }

    return [System.Drawing.Rectangle]::new(
        $values[0],
        $values[1],
        $values[2],
        $values[3])
}

function Assert-PointInImage {
    param(
        [System.Drawing.Point]$Point,
        [System.Drawing.Image]$Image,
        [string]$Name
    )

    if ($Point.X -lt 0 -or $Point.X -ge $Image.Width -or
        $Point.Y -lt 0 -or $Point.Y -ge $Image.Height) {
        throw "$Name ($($Point.X),$($Point.Y)) is outside the $($Image.Width)x$($Image.Height) source."
    }
}

function Assert-RectangleInImage {
    param(
        [System.Drawing.Rectangle]$Rectangle,
        [System.Drawing.Image]$Image,
        [string]$Name
    )

    if ($Rectangle.Left -lt 0 -or $Rectangle.Top -lt 0 -or
        $Rectangle.Right -gt $Image.Width -or
        $Rectangle.Bottom -gt $Image.Height) {
        throw "$Name ($($Rectangle.X),$($Rectangle.Y),$($Rectangle.Width),$($Rectangle.Height)) is outside the $($Image.Width)x$($Image.Height) source."
    }
}

function Get-Measurement {
    param(
        [string]$Label,
        [System.Drawing.Point]$Crown,
        [System.Drawing.Point]$Chin,
        [System.Drawing.Point]$Sole,
        [double]$TargetMin,
        [double]$TargetMax
    )

    $headPixels = [Math]::Abs([double]($Chin.Y - $Crown.Y))
    $staturePixels = [double]($Sole.Y - $Crown.Y)

    if ($headPixels -le 0.0) {
        throw "$Label crown-to-chin distance must be positive."
    }
    if ($staturePixels -le 0.0) {
        throw "$Label sole must be below crown."
    }

    $headCount = $staturePixels / $headPixels
    [pscustomobject]@{
        Label = $Label
        Crown = $Crown
        Chin = $Chin
        Sole = $Sole
        HeadPixels = $headPixels
        StaturePixels = $staturePixels
        HeadCount = $headCount
        TargetMin = $TargetMin
        TargetMax = $TargetMax
        InTarget = ($headCount -ge $TargetMin -and $headCount -le $TargetMax)
        TargetDelta = if ($headCount -lt $TargetMin) {
            $headCount - $TargetMin
        }
        elseif ($headCount -gt $TargetMax) {
            $headCount - $TargetMax
        }
        else {
            0.0
        }
    }
}

function New-ReviewFont {
    param(
        [float]$Size,
        [System.Drawing.FontStyle]$Style = [System.Drawing.FontStyle]::Regular
    )

    try {
        return [System.Drawing.Font]::new(
            'Segoe UI',
            $Size,
            $Style,
            [System.Drawing.GraphicsUnit]::Pixel)
    }
    catch {
        return [System.Drawing.Font]::new(
            [System.Drawing.FontFamily]::GenericSansSerif,
            $Size,
            $Style,
            [System.Drawing.GraphicsUnit]::Pixel)
    }
}

function Get-ReviewColor {
    param([string]$Html)
    return [System.Drawing.ColorTranslator]::FromHtml($Html)
}

function Save-ReviewPng {
    param(
        [System.Drawing.Image]$Image,
        [string]$Path,
        [switch]$Overwrite
    )

    if ((Test-Path -LiteralPath $Path) -and -not $Overwrite) {
        throw "Output already exists: $Path. Use -Force to overwrite generated evidence."
    }

    $Image.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
}

function Add-MeasurementGuide {
    param(
        [System.Drawing.Graphics]$Graphics,
        [pscustomobject]$Measurement,
        [int]$OffsetX,
        [int]$OffsetY,
        [int]$GuideX,
        [int]$LineLeft,
        [int]$LineRight,
        [System.Drawing.Color]$Accent
    )

    $accentPen = [System.Drawing.Pen]::new($Accent, 4.0)
    $levelPen = [System.Drawing.Pen]::new(
        [System.Drawing.Color]::FromArgb(170, $Accent),
        1.5)
    $levelPen.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash
    $crownPen = [System.Drawing.Pen]::new((Get-ReviewColor '#F8FAFC'), 2.0)
    $chinPen = [System.Drawing.Pen]::new((Get-ReviewColor '#FBBF24'), 2.0)
    $solePen = [System.Drawing.Pen]::new((Get-ReviewColor '#FB7185'), 2.0)
    $pointBrush = [System.Drawing.SolidBrush]::new($Accent)
    $labelBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#F8FAFC'))
    $smallFont = New-ReviewFont 18 ([System.Drawing.FontStyle]::Bold)

    try {
        $crownX = $OffsetX + $Measurement.Crown.X
        $crownY = $OffsetY + $Measurement.Crown.Y
        $chinX = $OffsetX + $Measurement.Chin.X
        $chinY = $OffsetY + $Measurement.Chin.Y
        $soleX = $OffsetX + $Measurement.Sole.X
        $soleY = $OffsetY + $Measurement.Sole.Y
        $guideCanvasX = $OffsetX + $GuideX

        $Graphics.DrawLine($accentPen, $guideCanvasX, $crownY, $guideCanvasX, $chinY)
        $Graphics.FillEllipse($pointBrush, $crownX - 6, $crownY - 6, 12, 12)
        $Graphics.FillEllipse($pointBrush, $chinX - 6, $chinY - 6, 12, 12)
        $Graphics.FillEllipse($pointBrush, $soleX - 6, $soleY - 6, 12, 12)

        $Graphics.DrawLine(
            $crownPen,
            $OffsetX + $LineLeft,
            $crownY,
            $OffsetX + $LineRight,
            $crownY)
        $Graphics.DrawLine(
            $chinPen,
            $OffsetX + $LineLeft,
            $chinY,
            $OffsetX + $LineRight,
            $chinY)
        $Graphics.DrawLine(
            $solePen,
            $OffsetX + $LineLeft,
            $soleY,
            $OffsetX + $LineRight,
            $soleY)

        $Graphics.DrawString('CROWN', $smallFont, $labelBrush, $OffsetX + $LineLeft + 4, $crownY - 24)
        $Graphics.DrawString('CHIN', $smallFont, $labelBrush, $OffsetX + $LineLeft + 4, $chinY + 4)
        $Graphics.DrawString('SOLE', $smallFont, $labelBrush, $OffsetX + $LineLeft + 4, $soleY - 26)

        $level = 0
        while ($true) {
            $levelY = $crownY + [float]($level * $Measurement.HeadPixels)
            if ($levelY -gt $soleY + 0.5) {
                break
            }

            $Graphics.DrawLine(
                $levelPen,
                $guideCanvasX,
                $levelY,
                $OffsetX + $LineRight,
                $levelY)
            $Graphics.DrawString(
                ("{0}H" -f $level),
                $smallFont,
                $labelBrush,
                $guideCanvasX - 42,
                $levelY - 12)
            $level++
        }

        $Graphics.DrawLine($levelPen, $guideCanvasX, $crownY, $guideCanvasX, $soleY)
    }
    finally {
        $accentPen.Dispose()
        $levelPen.Dispose()
        $crownPen.Dispose()
        $chinPen.Dispose()
        $solePen.Dispose()
        $pointBrush.Dispose()
        $labelBrush.Dispose()
        $smallFont.Dispose()
    }
}

function Add-MeasurementCard {
    param(
        [System.Drawing.Graphics]$Graphics,
        [pscustomobject]$Measurement,
        [System.Drawing.RectangleF]$Bounds,
        [System.Drawing.Color]$Accent
    )

    $panelBrush = [System.Drawing.SolidBrush]::new(
        [System.Drawing.Color]::FromArgb(238, 17, 26, 43))
    $borderPen = [System.Drawing.Pen]::new(
        [System.Drawing.Color]::FromArgb(150, $Accent),
        2.0)
    $titleBrush = [System.Drawing.SolidBrush]::new($Accent)
    $textBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#E2E8F0'))
    $mutedBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#94A3B8'))
    $statusColor = if ($Measurement.InTarget) {
        Get-ReviewColor '#34D399'
    }
    else {
        Get-ReviewColor '#FB7185'
    }
    $statusBrush = [System.Drawing.SolidBrush]::new($statusColor)
    $titleFont = New-ReviewFont 30 ([System.Drawing.FontStyle]::Bold)
    $valueFont = New-ReviewFont 24 ([System.Drawing.FontStyle]::Bold)
    $bodyFont = New-ReviewFont 19
    $smallFont = New-ReviewFont 16

    try {
        $Graphics.FillRectangle($panelBrush, $Bounds)
        $Graphics.DrawRectangle(
            $borderPen,
            $Bounds.X,
            $Bounds.Y,
            $Bounds.Width,
            $Bounds.Height)

        $x = $Bounds.X + 24
        $y = $Bounds.Y + 20
        $Graphics.DrawString($Measurement.Label, $titleFont, $titleBrush, $x, $y)
        $y += 48

        $Graphics.DrawString(
            ("Crown  ({0}, {1})" -f $Measurement.Crown.X, $Measurement.Crown.Y),
            $bodyFont,
            $textBrush,
            $x,
            $y)
        $y += 29
        $Graphics.DrawString(
            ("Chin    ({0}, {1})" -f $Measurement.Chin.X, $Measurement.Chin.Y),
            $bodyFont,
            $textBrush,
            $x,
            $y)
        $y += 29
        $Graphics.DrawString(
            ("Sole    ({0}, {1})" -f $Measurement.Sole.X, $Measurement.Sole.Y),
            $bodyFont,
            $textBrush,
            $x,
            $y)
        $y += 38

        $Graphics.DrawString(
            ("Head unit   {0:N1} px" -f $Measurement.HeadPixels),
            $bodyFont,
            $textBrush,
            $x,
            $y)
        $y += 29
        $Graphics.DrawString(
            ("Crown-to-sole vertical span   {0:N0} px" -f $Measurement.StaturePixels),
            $bodyFont,
            $textBrush,
            $x,
            $y)
        $y += 42

        $Graphics.DrawString(
            ("MEASURED   {0:N2} H" -f $Measurement.HeadCount),
            $valueFont,
            $statusBrush,
            $x,
            $y)
        $y += 38
        $Graphics.DrawString(
            ("TARGET   {0:N1}-{1:N1} H" -f $Measurement.TargetMin, $Measurement.TargetMax),
            $bodyFont,
            $textBrush,
            $x,
            $y)
        $y += 34

        $status = if ($Measurement.InTarget) {
            'WITHIN TARGET'
        }
        else {
            'OUTSIDE TARGET'
        }
        $Graphics.DrawString($status, $valueFont, $statusBrush, $x, $y)
        $y += 48

        $Graphics.DrawString(
            'Image-space estimate; not model approval.',
            $smallFont,
            $mutedBrush,
            $x,
            $y)
    }
    finally {
        $panelBrush.Dispose()
        $borderPen.Dispose()
        $titleBrush.Dispose()
        $textBrush.Dispose()
        $mutedBrush.Dispose()
        $statusBrush.Dispose()
        $titleFont.Dispose()
        $valueFont.Dispose()
        $bodyFont.Dispose()
        $smallFont.Dispose()
    }
}

function New-ProportionEvidence {
    param(
        [System.Drawing.Bitmap]$Source,
        [pscustomobject]$LeftMeasurement,
        [pscustomobject]$RightMeasurement
    )

    $canvas = [System.Drawing.Bitmap]::new(
        2200,
        1250,
        [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($canvas)

    try {
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.Clear((Get-ReviewColor '#07111F'))

        $titleFont = New-ReviewFont 38 ([System.Drawing.FontStyle]::Bold)
        $subtitleFont = New-ReviewFont 19
        $titleBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#F8FAFC'))
        $subtitleBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#94A3B8'))
        $imageBorderPen = [System.Drawing.Pen]::new((Get-ReviewColor '#334155'), 2.0)

        try {
            $graphics.DrawString(
                "$AssetPrefix - Proportion Gate Evidence / REVIEW",
                $titleFont,
                $titleBrush,
                40,
                28)
            $graphics.DrawString(
                'Head unit = vertical Y span from visible crown to chin; stature = vertical crown Y to lowest non-reflection sole Y. Sensor ears excluded.',
                $subtitleFont,
                $subtitleBrush,
                42,
                80)

            $imageX = 40
            $imageY = 120
            $graphics.DrawImageUnscaled($Source, $imageX, $imageY)
            $graphics.DrawRectangle(
                $imageBorderPen,
                $imageX,
                $imageY,
                $Source.Width,
                $Source.Height)

            Add-MeasurementGuide `
                -Graphics $graphics `
                -Measurement $LeftMeasurement `
                -OffsetX $imageX `
                -OffsetY $imageY `
                -GuideX 170 `
                -LineLeft 170 `
                -LineRight 760 `
                -Accent (Get-ReviewColor '#22D3EE')

            Add-MeasurementGuide `
                -Graphics $graphics `
                -Measurement $RightMeasurement `
                -OffsetX $imageX `
                -OffsetY $imageY `
                -GuideX 815 `
                -LineLeft 815 `
                -LineRight 1320 `
                -Accent (Get-ReviewColor '#A78BFA')

            Add-MeasurementCard `
                -Graphics $graphics `
                -Measurement $LeftMeasurement `
                -Bounds ([System.Drawing.RectangleF]::new(1610, 120, 550, 470)) `
                -Accent (Get-ReviewColor '#22D3EE')

            Add-MeasurementCard `
                -Graphics $graphics `
                -Measurement $RightMeasurement `
                -Bounds ([System.Drawing.RectangleF]::new(1610, 610, 550, 470)) `
                -Accent (Get-ReviewColor '#A78BFA')

            $noteBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#CBD5E1'))
            $noteFont = New-ReviewFont 17
            try {
                $graphics.DrawString(
                    'Crown convention: visible hood dome over the hidden skull;',
                    $noteFont,
                    $noteBrush,
                    1612,
                    1100)
                $graphics.DrawString(
                    'decorative sensor ears are excluded for both figures.',
                    $noteFont,
                    $noteBrush,
                    1612,
                    1130)
                $graphics.DrawString(
                    'Pose, head tilt, and perspective remain image-space limits.',
                    $noteFont,
                    $noteBrush,
                    1612,
                    1160)
                $graphics.DrawString(
                    'No value was corrected toward the target.',
                    $noteFont,
                    $noteBrush,
                    1612,
                    1190)
                $graphics.DrawString(
                    "Source: $([System.IO.Path]::GetFileName($SourcePath))",
                    $noteFont,
                    $noteBrush,
                    1612,
                    1220)
            }
            finally {
                $noteBrush.Dispose()
                $noteFont.Dispose()
            }
        }
        finally {
            $titleFont.Dispose()
            $subtitleFont.Dispose()
            $titleBrush.Dispose()
            $subtitleBrush.Dispose()
            $imageBorderPen.Dispose()
        }
    }
    finally {
        $graphics.Dispose()
    }

    return $canvas
}

function New-Face128Evidence {
    param(
        [System.Drawing.Bitmap]$Source,
        [System.Drawing.Rectangle]$Crop
    )

    $output = [System.Drawing.Bitmap]::new(
        128,
        128,
        [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($output)
    $attributes = [System.Drawing.Imaging.ImageAttributes]::new()

    try {
        $graphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
        $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $attributes.SetWrapMode([System.Drawing.Drawing2D.WrapMode]::TileFlipXY)

        $graphics.DrawImage(
            $Source,
            [System.Drawing.Rectangle]::new(0, 0, 128, 128),
            $Crop.X,
            $Crop.Y,
            $Crop.Width,
            $Crop.Height,
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
        [System.Drawing.Bitmap]$Source,
        [System.Drawing.Rectangle]$LeftCrop,
        [System.Drawing.Rectangle]$RightCrop,
        [pscustomobject]$LeftMeasurement,
        [pscustomobject]$RightMeasurement
    )

    $leftMask = [ReCamp.ArtReview.SilhouetteMask]::Build(
        $Source,
        $LeftCrop,
        $BrightThreshold,
        $NeutralFloor,
        $NeutralRange,
        $CyanFloor,
        $MorphologyRadius,
        $MinimumComponentArea,
        $MaximumHoleArea)
    $rightMask = [ReCamp.ArtReview.SilhouetteMask]::Build(
        $Source,
        $RightCrop,
        $BrightThreshold,
        $NeutralFloor,
        $NeutralRange,
        $CyanFloor,
        $MorphologyRadius,
        $MinimumComponentArea,
        $MaximumHoleArea)

    $canvas = [System.Drawing.Bitmap]::new(
        1600,
        1000,
        [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($canvas)

    try {
        $graphics.Clear((Get-ReviewColor '#F8FAFC'))
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

        $titleFont = New-ReviewFont 38 ([System.Drawing.FontStyle]::Bold)
        $labelFont = New-ReviewFont 26 ([System.Drawing.FontStyle]::Bold)
        $bodyFont = New-ReviewFont 18
        $titleBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#0F172A'))
        $mutedBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#475569'))
        $panelBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#FFFFFF'))
        $borderPen = [System.Drawing.Pen]::new((Get-ReviewColor '#CBD5E1'), 2.0)
        $guidePen = [System.Drawing.Pen]::new((Get-ReviewColor '#94A3B8'), 1.5)
        $guidePen.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash

        try {
            $graphics.DrawString(
                "$AssetPrefix - Height-normalized Silhouette Comparison / REVIEW",
                $titleFont,
                $titleBrush,
                40,
                24)
            $graphics.DrawString(
                'Black/white equipment-inclusive masks. Each figure is normalized by its measured crown-to-sole span; source pixel scale is not compared.',
                $bodyFont,
                $mutedBrush,
                42,
                78)

            $leftPanel = [System.Drawing.RectangleF]::new(40, 125, 740, 800)
            $rightPanel = [System.Drawing.RectangleF]::new(820, 125, 740, 800)
            $graphics.FillRectangle($panelBrush, $leftPanel)
            $graphics.FillRectangle($panelBrush, $rightPanel)
            $graphics.DrawRectangle(
                $borderPen,
                $leftPanel.X,
                $leftPanel.Y,
                $leftPanel.Width,
                $leftPanel.Height)
            $graphics.DrawRectangle(
                $borderPen,
                $rightPanel.X,
                $rightPanel.Y,
                $rightPanel.Width,
                $rightPanel.Height)

            $targetHeight = 660.0
            $crownY = 215.0
            $soleY = $crownY + $targetHeight
            $graphics.DrawLine($guidePen, 58, $crownY, 762, $crownY)
            $graphics.DrawLine($guidePen, 58, $soleY, 762, $soleY)
            $graphics.DrawLine($guidePen, 838, $crownY, 1542, $crownY)
            $graphics.DrawLine($guidePen, 838, $soleY, 1542, $soleY)

            $leftScale = $targetHeight / $LeftMeasurement.StaturePixels
            $rightScale = $targetHeight / $RightMeasurement.StaturePixels

            $leftWidth = [float]($LeftCrop.Width * $leftScale)
            $leftHeight = [float]($LeftCrop.Height * $leftScale)
            $leftX = [float](410.0 - $leftWidth / 2.0)
            $leftY = [float](
                $crownY -
                (($LeftMeasurement.Crown.Y - $LeftCrop.Y) * $leftScale))

            $rightWidth = [float]($RightCrop.Width * $rightScale)
            $rightHeight = [float]($RightCrop.Height * $rightScale)
            $rightX = [float](1190.0 - $rightWidth / 2.0)
            $rightY = [float](
                $crownY -
                (($RightMeasurement.Crown.Y - $RightCrop.Y) * $rightScale))

            $graphics.DrawImage(
                $leftMask,
                [System.Drawing.RectangleF]::new($leftX, $leftY, $leftWidth, $leftHeight))
            $graphics.DrawImage(
                $rightMask,
                [System.Drawing.RectangleF]::new($rightX, $rightY, $rightWidth, $rightHeight))

            $graphics.DrawString(
                ("LEFT / 2D   {0:N2} H" -f $LeftMeasurement.HeadCount),
                $labelFont,
                $titleBrush,
                70,
                142)
            $graphics.DrawString(
                ("RIGHT / 3D   {0:N2} H" -f $RightMeasurement.HeadCount),
                $labelFont,
                $titleBrush,
                850,
                142)
            $graphics.DrawString('CROWN', $bodyFont, $mutedBrush, 62, $crownY - 24)
            $graphics.DrawString('SOLE', $bodyFont, $mutedBrush, 62, $soleY - 24)
            $graphics.DrawString('CROWN', $bodyFont, $mutedBrush, 842, $crownY - 24)
            $graphics.DrawString('SOLE', $bodyFont, $mutedBrush, 842, $soleY - 24)

            $graphics.DrawString(
                "Segmentation: bright>=$BrightThreshold; neutral>=$NeutralFloor within range $NeutralRange; cyan>=$CyanFloor; close radius=$MorphologyRadius; min component=$MinimumComponentArea px; fill holes<=$MaximumHoleArea px.",
                $bodyFont,
                $mutedBrush,
                42,
                948)
        }
        finally {
            $titleFont.Dispose()
            $labelFont.Dispose()
            $bodyFont.Dispose()
            $titleBrush.Dispose()
            $mutedBrush.Dispose()
            $panelBrush.Dispose()
            $borderPen.Dispose()
            $guidePen.Dispose()
        }
    }
    finally {
        $graphics.Dispose()
        $leftMask.Dispose()
        $rightMask.Dispose()
    }

    return $canvas
}

function New-CandidateComparisonEvidence {
    param(
        [System.Drawing.Bitmap]$CandidateA,
        [System.Drawing.Bitmap]$CandidateB,
        [System.Drawing.Bitmap]$CandidateC
    )

    $canvas = [System.Drawing.Bitmap]::new(
        2280,
        1240,
        [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($canvas)

    try {
        $graphics.Clear((Get-ReviewColor '#07111F'))
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

        $labelFont = New-ReviewFont 42 ([System.Drawing.FontStyle]::Bold)
        $labelBrush = [System.Drawing.SolidBrush]::new((Get-ReviewColor '#F8FAFC'))
        $separatorPen = [System.Drawing.Pen]::new((Get-ReviewColor '#334155'), 2.0)
        $stringFormat = [System.Drawing.StringFormat]::new()

        try {
            $stringFormat.Alignment = [System.Drawing.StringAlignment]::Center
            $stringFormat.LineAlignment = [System.Drawing.StringAlignment]::Center
            $panelWidth = 760.0
            $imageTop = 110.0
            $imageHeight = 1100.0
            $labels = @('A Playful', 'B Chic', 'C Focused')
            $images = @($CandidateA, $CandidateB, $CandidateC)

            for ($i = 0; $i -lt 3; $i++) {
                $panelX = $i * $panelWidth
                $graphics.DrawString(
                    $labels[$i],
                    $labelFont,
                    $labelBrush,
                    [System.Drawing.RectangleF]::new($panelX, 18, $panelWidth, 72),
                    $stringFormat)

                $image = $images[$i]
                $imageWidth = [float]($image.Width * ($imageHeight / $image.Height))
                $imageX = [float]($panelX + ($panelWidth - $imageWidth) / 2.0)
                $graphics.DrawImage(
                    $image,
                    [System.Drawing.RectangleF]::new(
                        $imageX,
                        $imageTop,
                        $imageWidth,
                        [float]$imageHeight))

                if ($i -lt 2) {
                    $separatorX = [float](($i + 1) * $panelWidth)
                    $graphics.DrawLine($separatorPen, $separatorX, 18, $separatorX, 1220)
                }
            }
        }
        finally {
            $labelFont.Dispose()
            $labelBrush.Dispose()
            $separatorPen.Dispose()
            $stringFormat.Dispose()
        }
    }
    finally {
        $graphics.Dispose()
    }

    return $canvas
}

$resolvedSourcePath = (Resolve-Path -LiteralPath $SourcePath).Path
if ([string]::IsNullOrWhiteSpace($OutputDirectory)) {
    $OutputDirectory = [System.IO.Path]::GetDirectoryName($resolvedSourcePath)
}

$resolvedOutputDirectory = [System.IO.Path]::GetFullPath($OutputDirectory)
[System.IO.Directory]::CreateDirectory($resolvedOutputDirectory) | Out-Null

$leftCrownPoint = ConvertTo-Point -Value $LeftCrown -Name 'LeftCrown'
$leftChinPoint = ConvertTo-Point -Value $LeftChin -Name 'LeftChin'
$leftSolePoint = ConvertTo-Point -Value $LeftSole -Name 'LeftSole'
$rightCrownPoint = ConvertTo-Point -Value $RightCrown -Name 'RightCrown'
$rightChinPoint = ConvertTo-Point -Value $RightChin -Name 'RightChin'
$rightSolePoint = ConvertTo-Point -Value $RightSole -Name 'RightSole'
$faceCropRectangle = ConvertTo-Rectangle -Value $FaceCrop -Name 'FaceCrop'
$leftSilhouetteRectangle = ConvertTo-Rectangle -Value $LeftSilhouetteCrop -Name 'LeftSilhouetteCrop'
$rightSilhouetteRectangle = ConvertTo-Rectangle -Value $RightSilhouetteCrop -Name 'RightSilhouetteCrop'

$sourceBitmap = [System.Drawing.Bitmap]::FromFile($resolvedSourcePath)
try {
    Assert-PointInImage -Point $leftCrownPoint -Image $sourceBitmap -Name 'LeftCrown'
    Assert-PointInImage -Point $leftChinPoint -Image $sourceBitmap -Name 'LeftChin'
    Assert-PointInImage -Point $leftSolePoint -Image $sourceBitmap -Name 'LeftSole'
    Assert-PointInImage -Point $rightCrownPoint -Image $sourceBitmap -Name 'RightCrown'
    Assert-PointInImage -Point $rightChinPoint -Image $sourceBitmap -Name 'RightChin'
    Assert-PointInImage -Point $rightSolePoint -Image $sourceBitmap -Name 'RightSole'
    Assert-RectangleInImage -Rectangle $faceCropRectangle -Image $sourceBitmap -Name 'FaceCrop'
    Assert-RectangleInImage -Rectangle $leftSilhouetteRectangle -Image $sourceBitmap -Name 'LeftSilhouetteCrop'
    Assert-RectangleInImage -Rectangle $rightSilhouetteRectangle -Image $sourceBitmap -Name 'RightSilhouetteCrop'

    $leftMeasurement = Get-Measurement `
        -Label 'LEFT / 2D' `
        -Crown $leftCrownPoint `
        -Chin $leftChinPoint `
        -Sole $leftSolePoint `
        -TargetMin $LeftTargetMin `
        -TargetMax $LeftTargetMax
    $rightMeasurement = Get-Measurement `
        -Label 'RIGHT / 3D' `
        -Crown $rightCrownPoint `
        -Chin $rightChinPoint `
        -Sole $rightSolePoint `
        -TargetMin $RightTargetMin `
        -TargetMax $RightTargetMax

    $proportionPath = Join-Path `
        $resolvedOutputDirectory `
        "${AssetPrefix}_ProportionGateEvidence_REVIEW_${OutputVersion}.png"
    $facePath = Join-Path `
        $resolvedOutputDirectory `
        "${AssetPrefix}_Face128_REVIEW_${OutputVersion}.png"
    $silhouettePath = Join-Path `
        $resolvedOutputDirectory `
        "${AssetPrefix}_SilhouetteTest_REVIEW_${OutputVersion}.png"
    $candidateComparisonPath = $null
    $candidateAMeasurement = $null
    $candidateBMeasurement = $null
    $candidateCMeasurement = $null

    $proportionImage = New-ProportionEvidence `
        -Source $sourceBitmap `
        -LeftMeasurement $leftMeasurement `
        -RightMeasurement $rightMeasurement
    try {
        Save-ReviewPng -Image $proportionImage -Path $proportionPath -Overwrite:$Force
    }
    finally {
        $proportionImage.Dispose()
    }

    $faceImage = New-Face128Evidence -Source $sourceBitmap -Crop $faceCropRectangle
    try {
        Save-ReviewPng -Image $faceImage -Path $facePath -Overwrite:$Force
    }
    finally {
        $faceImage.Dispose()
    }

    $silhouetteImage = New-SilhouetteEvidence `
        -Source $sourceBitmap `
        -LeftCrop $leftSilhouetteRectangle `
        -RightCrop $rightSilhouetteRectangle `
        -LeftMeasurement $leftMeasurement `
        -RightMeasurement $rightMeasurement
    try {
        Save-ReviewPng -Image $silhouetteImage -Path $silhouettePath -Overwrite:$Force
    }
    finally {
        $silhouetteImage.Dispose()
    }

    $candidatePaths = @($CandidateAPath, $CandidateBPath, $CandidateCPath)
    $providedCandidateCount = @(
        $candidatePaths |
            Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    ).Count
    if ($providedCandidateCount -ne 0 -and $providedCandidateCount -ne 3) {
        throw 'Candidate comparison requires CandidateAPath, CandidateBPath, and CandidateCPath together.'
    }

    if ($providedCandidateCount -eq 3) {
        $resolvedCandidatePaths = @(
            $candidatePaths |
                ForEach-Object { (Resolve-Path -LiteralPath $_).Path }
        )
        $candidateA = [System.Drawing.Bitmap]::FromFile($resolvedCandidatePaths[0])
        $candidateB = [System.Drawing.Bitmap]::FromFile($resolvedCandidatePaths[1])
        $candidateC = [System.Drawing.Bitmap]::FromFile($resolvedCandidatePaths[2])
        try {
            $candidateACrownPoint = ConvertTo-Point -Value $CandidateACrown -Name 'CandidateACrown'
            $candidateAChinPoint = ConvertTo-Point -Value $CandidateAChin -Name 'CandidateAChin'
            $candidateASolePoint = ConvertTo-Point -Value $CandidateASole -Name 'CandidateASole'
            $candidateBCrownPoint = ConvertTo-Point -Value $CandidateBCrown -Name 'CandidateBCrown'
            $candidateBChinPoint = ConvertTo-Point -Value $CandidateBChin -Name 'CandidateBChin'
            $candidateBSolePoint = ConvertTo-Point -Value $CandidateBSole -Name 'CandidateBSole'
            $candidateCCrownPoint = ConvertTo-Point -Value $CandidateCCrown -Name 'CandidateCCrown'
            $candidateCChinPoint = ConvertTo-Point -Value $CandidateCChin -Name 'CandidateCChin'
            $candidateCSolePoint = ConvertTo-Point -Value $CandidateCSole -Name 'CandidateCSole'

            Assert-PointInImage -Point $candidateACrownPoint -Image $candidateA -Name 'CandidateACrown'
            Assert-PointInImage -Point $candidateAChinPoint -Image $candidateA -Name 'CandidateAChin'
            Assert-PointInImage -Point $candidateASolePoint -Image $candidateA -Name 'CandidateASole'
            Assert-PointInImage -Point $candidateBCrownPoint -Image $candidateB -Name 'CandidateBCrown'
            Assert-PointInImage -Point $candidateBChinPoint -Image $candidateB -Name 'CandidateBChin'
            Assert-PointInImage -Point $candidateBSolePoint -Image $candidateB -Name 'CandidateBSole'
            Assert-PointInImage -Point $candidateCCrownPoint -Image $candidateC -Name 'CandidateCCrown'
            Assert-PointInImage -Point $candidateCChinPoint -Image $candidateC -Name 'CandidateCChin'
            Assert-PointInImage -Point $candidateCSolePoint -Image $candidateC -Name 'CandidateCSole'

            $candidateAMeasurement = Get-Measurement `
                -Label 'A / PLAYFUL' `
                -Crown $candidateACrownPoint `
                -Chin $candidateAChinPoint `
                -Sole $candidateASolePoint `
                -TargetMin $LeftTargetMin `
                -TargetMax $LeftTargetMax
            $candidateBMeasurement = Get-Measurement `
                -Label 'B / CHIC' `
                -Crown $candidateBCrownPoint `
                -Chin $candidateBChinPoint `
                -Sole $candidateBSolePoint `
                -TargetMin $LeftTargetMin `
                -TargetMax $LeftTargetMax
            $candidateCMeasurement = Get-Measurement `
                -Label 'C / FOCUSED' `
                -Crown $candidateCCrownPoint `
                -Chin $candidateCChinPoint `
                -Sole $candidateCSolePoint `
                -TargetMin $LeftTargetMin `
                -TargetMax $LeftTargetMax

            $candidateComparisonPath = Join-Path `
                $resolvedOutputDirectory `
                "${AssetPrefix}_FullBodyCandidates_REVIEW_${OutputVersion}.png"
            $candidateComparisonImage = New-CandidateComparisonEvidence `
                -CandidateA $candidateA `
                -CandidateB $candidateB `
                -CandidateC $candidateC
            try {
                Save-ReviewPng `
                    -Image $candidateComparisonImage `
                    -Path $candidateComparisonPath `
                    -Overwrite:$Force
            }
            finally {
                $candidateComparisonImage.Dispose()
            }
        }
        finally {
            $candidateA.Dispose()
            $candidateB.Dispose()
            $candidateC.Dispose()
        }
    }

    [pscustomobject]@{
        Source = $resolvedSourcePath
        SourceSize = "$($sourceBitmap.Width)x$($sourceBitmap.Height)"
        LeftHeadUnitPixels = [Math]::Round($leftMeasurement.HeadPixels, 2)
        LeftHeadCount = [Math]::Round($leftMeasurement.HeadCount, 3)
        LeftWithinTarget = $leftMeasurement.InTarget
        RightHeadUnitPixels = [Math]::Round($rightMeasurement.HeadPixels, 2)
        RightHeadCount = [Math]::Round($rightMeasurement.HeadCount, 3)
        RightWithinTarget = $rightMeasurement.InTarget
        FaceCrop = $FaceCrop
        ProportionEvidence = $proportionPath
        Face128Evidence = $facePath
        SilhouetteEvidence = $silhouettePath
        CandidateComparisonEvidence = $candidateComparisonPath
        CandidateMeasurementRule = if ($null -eq $candidateAMeasurement) {
            $null
        }
        else {
            '(soleY-crownY)/(chinY-crownY)'
        }
        CandidateALandmarks = if ($null -eq $candidateAMeasurement) {
            $null
        }
        else {
            "crown=$CandidateACrown; chin=$CandidateAChin; sole=$CandidateASole"
        }
        CandidateAHeadCount = if ($null -eq $candidateAMeasurement) {
            $null
        }
        else {
            [Math]::Round($candidateAMeasurement.HeadCount, 3)
        }
        CandidateAWithinTarget = if ($null -eq $candidateAMeasurement) {
            $null
        }
        else {
            $candidateAMeasurement.InTarget
        }
        CandidateATargetDelta = if ($null -eq $candidateAMeasurement) {
            $null
        }
        else {
            [Math]::Round($candidateAMeasurement.TargetDelta, 3)
        }
        CandidateBLandmarks = if ($null -eq $candidateBMeasurement) {
            $null
        }
        else {
            "crown=$CandidateBCrown; chin=$CandidateBChin; sole=$CandidateBSole"
        }
        CandidateBHeadCount = if ($null -eq $candidateBMeasurement) {
            $null
        }
        else {
            [Math]::Round($candidateBMeasurement.HeadCount, 3)
        }
        CandidateBWithinTarget = if ($null -eq $candidateBMeasurement) {
            $null
        }
        else {
            $candidateBMeasurement.InTarget
        }
        CandidateBTargetDelta = if ($null -eq $candidateBMeasurement) {
            $null
        }
        else {
            [Math]::Round($candidateBMeasurement.TargetDelta, 3)
        }
        CandidateCLandmarks = if ($null -eq $candidateCMeasurement) {
            $null
        }
        else {
            "crown=$CandidateCCrown; chin=$CandidateCChin; sole=$CandidateCSole"
        }
        CandidateCHeadCount = if ($null -eq $candidateCMeasurement) {
            $null
        }
        else {
            [Math]::Round($candidateCMeasurement.HeadCount, 3)
        }
        CandidateCWithinTarget = if ($null -eq $candidateCMeasurement) {
            $null
        }
        else {
            $candidateCMeasurement.InTarget
        }
        CandidateCTargetDelta = if ($null -eq $candidateCMeasurement) {
            $null
        }
        else {
            [Math]::Round($candidateCMeasurement.TargetDelta, 3)
        }
    }
}
finally {
    $sourceBitmap.Dispose()
}
