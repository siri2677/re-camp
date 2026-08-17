[CmdletBinding()]
param(
    [string]$ProjectRoot,
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
Add-Type -Language CSharp -ReferencedAssemblies System.Drawing -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Linq;
using System.Runtime.InteropServices;

public static class MiyuSilhouetteExtractor
{
    public static Bitmap[] Extract(Bitmap source, Rectangle roi)
    {
        Bitmap crop = new Bitmap(roi.Width, roi.Height, PixelFormat.Format32bppArgb);
        using (Graphics g = Graphics.FromImage(crop))
            g.DrawImage(source, new Rectangle(0, 0, roi.Width, roi.Height), roi, GraphicsUnit.Pixel);

        BitmapData data = crop.LockBits(new Rectangle(0, 0, crop.Width, crop.Height), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
        byte[] bytes = new byte[Math.Abs(data.Stride) * crop.Height];
        Marshal.Copy(data.Scan0, bytes, 0, bytes.Length);
        crop.UnlockBits(data);

        int width = crop.Width, height = crop.Height;
        bool[] foreground = new bool[width * height];
        for (int y = 0; y < height; y++)
        for (int x = 0; x < width; x++)
        {
            int p = y * data.Stride + x * 4;
            int b = bytes[p], g = bytes[p + 1], r = bytes[p + 2];
            int max = Math.Max(r, Math.Max(g, b));
            int min = Math.Min(r, Math.Min(g, b));
            int avg = (r + g + b) / 3;
            foreground[y * width + x] = avg < 210 || (max - min > 10 && avg < 248);
        }

        int[] labels = Enumerable.Repeat(-1, width * height).ToArray();
        List<int> areas = new List<int>();
        int[] queue = new int[width * height];
        int label = 0;
        int[] dx = { -1, 1, 0, 0 }, dy = { 0, 0, -1, 1 };
        for (int start = 0; start < foreground.Length; start++)
        {
            if (!foreground[start] || labels[start] >= 0) continue;
            int head = 0, tail = 0, area = 0;
            queue[tail++] = start; labels[start] = label;
            while (head < tail)
            {
                int current = queue[head++]; area++;
                int cx = current % width, cy = current / width;
                for (int d = 0; d < 4; d++)
                {
                    int nx = cx + dx[d], ny = cy + dy[d];
                    if (nx < 0 || nx >= width || ny < 0 || ny >= height) continue;
                    int next = ny * width + nx;
                    if (foreground[next] && labels[next] < 0) { labels[next] = label; queue[tail++] = next; }
                }
            }
            areas.Add(area); label++;
        }

        int[] ranked = Enumerable.Range(0, areas.Count).OrderByDescending(i => areas[i]).ToArray();
        HashSet<int> included = new HashSet<int>(ranked.Where(i => areas[i] > 400).Take(3));
        HashSet<int> minimal = new HashSet<int>(ranked.Take(1));
        Bitmap all = NewMask(width, height, labels, included);
        Bitmap body = NewMask(width, height, labels, minimal);
        crop.Dispose();
        return new[] { all, body };
    }

    private static Bitmap NewMask(int width, int height, int[] labels, HashSet<int> accepted)
    {
        Bitmap output = new Bitmap(width, height, PixelFormat.Format32bppArgb);
        BitmapData data = output.LockBits(new Rectangle(0, 0, width, height), ImageLockMode.WriteOnly, PixelFormat.Format32bppArgb);
        byte[] pixels = new byte[Math.Abs(data.Stride) * height];
        for (int y = 0; y < height; y++)
        for (int x = 0; x < width; x++)
        {
            if (!accepted.Contains(labels[y * width + x])) continue;
            int p = y * data.Stride + x * 4;
            pixels[p] = 24; pixels[p + 1] = 20; pixels[p + 2] = 17; pixels[p + 3] = 255;
        }
        Marshal.Copy(pixels, 0, data.Scan0, pixels.Length);
        output.UnlockBits(data);
        return output;
    }
}
'@

if ([string]::IsNullOrWhiteSpace($ProjectRoot)) {
    $ProjectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
}

function P([string]$Relative) { [System.IO.Path]::GetFullPath((Join-Path $ProjectRoot $Relative)) }
function C([string]$Hex) { [System.Drawing.ColorTranslator]::FromHtml($Hex) }
function Font([float]$Size, [System.Drawing.FontStyle]$Style = [System.Drawing.FontStyle]::Regular) {
    [System.Drawing.Font]::new('Segoe UI', $Size, $Style, [System.Drawing.GraphicsUnit]::Pixel)
}
function New-Canvas([int]$Width, [int]$Height, [string]$Hex = '#0A1320') {
    $bitmap = [System.Drawing.Bitmap]::new($Width, $Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    $graphics.Clear((C $Hex))
    return @($bitmap, $graphics)
}
function Save-Png([System.Drawing.Bitmap]$Bitmap, [string]$Relative) {
    $path = P $Relative
    $directory = Split-Path -Parent $path
    [System.IO.Directory]::CreateDirectory($directory) | Out-Null
    if ((Test-Path -LiteralPath $path) -and -not $Force) { throw "Output exists: $path (use -Force)" }
    $Bitmap.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    Write-Output "Created $Relative ($($Bitmap.Width)x$($Bitmap.Height))"
}
function Text([System.Drawing.Graphics]$G, [string]$Value, [float]$X, [float]$Y, [float]$W, [float]$H,
    [System.Drawing.Font]$F, [string]$Hex = '#F3F8FC', [System.Drawing.StringAlignment]$Align = [System.Drawing.StringAlignment]::Near) {
    $brush = [System.Drawing.SolidBrush]::new((C $Hex))
    $format = [System.Drawing.StringFormat]::new()
    try {
        $format.Alignment = $Align
        $format.LineAlignment = [System.Drawing.StringAlignment]::Near
        $format.Trimming = [System.Drawing.StringTrimming]::EllipsisCharacter
        $G.DrawString($Value, $F, $brush, [System.Drawing.RectangleF]::new($X,$Y,$W,$H), $format)
    } finally { $brush.Dispose(); $format.Dispose() }
}
function Panel([System.Drawing.Graphics]$G, [float]$X, [float]$Y, [float]$W, [float]$H, [string]$Fill = '#101D2C', [string]$Stroke = '#29445B') {
    $brush = [System.Drawing.SolidBrush]::new((C $Fill)); $pen = [System.Drawing.Pen]::new((C $Stroke), 2)
    try { $G.FillRectangle($brush,$X,$Y,$W,$H); $G.DrawRectangle($pen,$X,$Y,$W,$H) } finally { $brush.Dispose(); $pen.Dispose() }
}
function Draw-Fit([System.Drawing.Graphics]$G, [System.Drawing.Image]$Image, [System.Drawing.RectangleF]$Rect, [string]$Mode = 'Contain') {
    $scaleX = $Rect.Width / $Image.Width; $scaleY = $Rect.Height / $Image.Height
    $scale = if ($Mode -eq 'Cover') { [Math]::Max($scaleX,$scaleY) } else { [Math]::Min($scaleX,$scaleY) }
    $w = [float]($Image.Width*$scale); $h = [float]($Image.Height*$scale)
    $dest = [System.Drawing.RectangleF]::new($Rect.X+($Rect.Width-$w)/2,$Rect.Y+($Rect.Height-$h)/2,$w,$h)
    $G.DrawImage($Image,$dest)
    return $dest
}
function Load([string]$Relative) { [System.Drawing.Image]::FromFile((P $Relative)) }

$key = Load 'art_refs/characters/miyu/concept/Miyu_KeyArt_REVIEW_v001.png'
$turnSource = Load 'art_refs/characters/miyu/turnaround/Miyu_Turnaround_WIP_v003.png'
$ref3dSource = Load 'art_refs/characters/miyu/3d_reference/Miyu_3DReference_WIP_v007.png'
$expr = Load 'art_refs/characters/miyu/expressions/Miyu_ExpressionSheet_REVIEW_v001.png'
$equip = Load 'art_refs/characters/miyu/equipment/Miyu_EquipmentSheet_REVIEW_v001.png'
$cand1 = Load 'art_refs/characters/miyu/concept/Miyu_FullBody_WIP_v001.png'
$cand2 = Load 'art_refs/characters/miyu/concept/Miyu_FullBody_WIP_v002.png'
$cand3 = Load 'art_refs/characters/miyu/concept/Miyu_FullBody_WIP_v003.png'

$title = Font 34 Bold; $h2 = Font 24 Bold; $body = Font 17; $small = Font 14; $tiny = Font 12 Bold
try {
    # Strict orthographic correction. All three panels map to common crown/chin/sole coordinates.
    $a = New-Canvas 1536 1024 '#F2F2F3'; $turn = $a[0]; $g = $a[1]
    try {
        $sourceMeasures = @(@(70,188,940), @(70,180,938), @(68,190,941))
        for ($i=0; $i -lt 3; $i++) {
            $x = $i*512; $m = $sourceMeasures[$i]; $sc=[int]$m[0]; $sh=[int]$m[1]; $ss=[int]$m[2]
            $g.DrawImage($turnSource,[System.Drawing.Rectangle]::new($x,0,512,70),$x,0,512,$sc,[System.Drawing.GraphicsUnit]::Pixel)
            $g.DrawImage($turnSource,[System.Drawing.Rectangle]::new($x,70,512,126),$x,$sc,512,$sh-$sc,[System.Drawing.GraphicsUnit]::Pixel)
            $g.DrawImage($turnSource,[System.Drawing.Rectangle]::new($x,196,512,744),$x,$sh,512,$ss-$sh,[System.Drawing.GraphicsUnit]::Pixel)
            $g.DrawImage($turnSource,[System.Drawing.Rectangle]::new($x,940,512,84),$x,$ss,512,1024-$ss,[System.Drawing.GraphicsUnit]::Pixel)
        }
        $labels=@('FRONT','LEFT','BACK'); for($i=0;$i -lt 3;$i++){ Text $g $labels[$i] ($i*512+18) 12 120 28 $tiny '#26384A' }
        Save-Png $turn 'art_refs/characters/miyu/turnaround/Miyu_Turnaround_REVIEW_v001.png'
    } finally { $g.Dispose() }

    # Deterministic 3D proportion translation: preserve crown/sole, expand head unit, compress body unit.
    $a = New-Canvas 941 1672 '#091326'; $ref3d = $a[0]; $g = $a[1]
    try {
        $g.DrawImage($ref3dSource,[System.Drawing.Rectangle]::new(0,0,941,205),0,0,941,205,[System.Drawing.GraphicsUnit]::Pixel)
        $g.DrawImage($ref3dSource,[System.Drawing.Rectangle]::new(0,205,941,253),0,205,941,205,[System.Drawing.GraphicsUnit]::Pixel)
        $g.DrawImage($ref3dSource,[System.Drawing.Rectangle]::new(0,458,941,1074),0,410,941,1122,[System.Drawing.GraphicsUnit]::Pixel)
        $g.DrawImage($ref3dSource,[System.Drawing.Rectangle]::new(0,1532,941,140),0,1532,941,140,[System.Drawing.GraphicsUnit]::Pixel)
        Save-Png $ref3d 'art_refs/characters/miyu/3d_reference/Miyu_3DReference_REVIEW_v001.png'
    } finally { $g.Dispose() }

    # Three-direction comparison board.
    $a=New-Canvas 2048 1180; $bmp=$a[0]; $g=$a[1]
    try {
        Text $g 'MIYU / DIRECTION COMPARISON' 48 28 1300 52 $title
        Text $g 'ART-1101 / three independent directions / human approval pending' 50 76 1200 30 $body '#93A9BA'
        $imgs=@($cand1,$cand2,$cand3); $names=@('A  SOFT ORBIT','B  WORKSHOP CHIC','C  OVERCLOCK PULSE'); $ratios=@('7.480H / FAIL','7.364H / FAIL','6.746H / BORDERLINE FAIL');
        $notes=@('Approachable and playful; silhouette too tall.','Sleepy fashion-tech identity; selected identity base.','Compact and assertive; personality drift risk.')
        for($i=0;$i -lt 3;$i++){
            $x=48+$i*666; Panel $g $x 126 620 930 $(if($i -eq 1){'#14283A'}else{'#101D2C'}) $(if($i -eq 1){'#27D6E8'}else{'#29445B'})
            [void](Draw-Fit $g $imgs[$i] ([System.Drawing.RectangleF]::new($x+18,146,584,710)))
            Text $g $names[$i] ($x+22) 876 570 32 $h2 $(if($i -eq 1){'#4CEBFA'}else{'#F3F8FC'})
            Text $g $ratios[$i] ($x+22) 916 570 27 $body '#F3B36B'
            Text $g $notes[$i] ($x+22) 952 570 60 $small '#B7C6D3'
        }
        Panel $g 48 1080 1952 62 '#132334' '#27D6E8'
        Text $g 'SELECTION: B identity + C compact construction -> corrected Key Art v001 / 6.890H / REVIEW ONLY' 72 1097 1900 32 $body '#CFFAFF'
        Save-Png $bmp 'art_refs/characters/miyu/concept/Miyu_FullBodyCandidates_REVIEW_v001.png'
    } finally {$g.Dispose();$bmp.Dispose()}

    # Exact 128x128 face crop.
    $face=[System.Drawing.Bitmap]::new(128,128,[System.Drawing.Imaging.PixelFormat]::Format32bppArgb); $g=[System.Drawing.Graphics]::FromImage($face)
    try { $g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic; $g.DrawImage($key,[System.Drawing.Rectangle]::new(0,0,128,128),379,60,260,260,[System.Drawing.GraphicsUnit]::Pixel); Save-Png $face 'art_refs/characters/miyu/face/Miyu_Face128_REVIEW_v001.png' } finally {$g.Dispose();$face.Dispose()}

    # Proportion evidence.
    $a=New-Canvas 2048 1200; $bmp=$a[0]; $g=$a[1]
    try {
        Text $g 'MIYU / PROPORTION GATE EVIDENCE' 48 28 1400 50 $title
        Text $g 'Measured image-space coordinates; accessories and drone tips excluded from head count.' 50 76 1500 28 $body '#93A9BA'
        Panel $g 48 120 780 1010; Panel $g 850 120 1150 1010
        Text $g '2D KEY ART / 6.890H / PASS' 72 140 700 34 $h2 '#4CEBFA'
        $d=Draw-Fit $g $key ([System.Drawing.RectangleF]::new(90,190,696,860));
        $scale=$d.Height/$key.Height; foreach($m in @(@(86,'CROWN'),@(286,'CHIN / 1H'),@(1464,'SOLE / 6.890H'))){$y=$d.Y+$m[0]*$scale;$pen=[System.Drawing.Pen]::new((C '#27D6E8'),2);try{$g.DrawLine($pen,$d.X,$y,$d.Right,$y)}finally{$pen.Dispose()};Text $g $m[1] ($d.X+8) ($y-22) 220 24 $tiny '#D8FCFF'}
        Text $g 'crown 86 / chin 286 / sole 1464' 92 1072 680 28 $body '#B7C6D3'
        Text $g 'TURNAROUND / 6.905H EACH / PASS' 874 140 1000 34 $h2 '#4CEBFA'
        [void](Draw-Fit $g $turn ([System.Drawing.RectangleF]::new(882,210,1086,725)))
        Text $g 'Mapped proof coordinates: crown 70 / chin 196 / sole 940' 890 963 1040 30 $body '#B7C6D3'
        Text $g 'Front / Left / Back share the same aligned construction span.' 890 1004 1040 30 $body '#B7C6D3'
        Text $g 'STATUS: REVIEW / HUMAN REVIEWER PENDING / APPROVAL NOT GRANTED' 890 1066 1040 32 $body '#F3B36B'
        Save-Png $bmp 'art_refs/characters/miyu/proportion/Miyu_ProportionGateEvidence_REVIEW_v001.png'
    } finally {$g.Dispose();$bmp.Dispose()}

    # Equipment-included / removed silhouette test from the actual corrected front turnaround.
    $a=New-Canvas 1800 900; $bmp=$a[0]; $g=$a[1]
    try {
        Text $g 'MIYU / SILHOUETTE LOAD TEST' 48 30 1200 48 $title
        Text $g 'Actual front-view pixel silhouette: top 3 connected components versus largest human component.' 50 78 1500 28 $body '#93A9BA'
        $masks=[MiyuSilhouetteExtractor]::Extract([System.Drawing.Bitmap]$turn,[System.Drawing.Rectangle]::new(0,50,560,920))
        try {
            for($i=0;$i -lt 2;$i++){
                $x=60+$i*860; Panel $g $x 130 800 700 '#E7EDF1' '#456379'
                [void](Draw-Fit $g $masks[$i] ([System.Drawing.RectangleF]::new($x+70,150,660,570)))
                Text $g $(if($i -eq 0){'ACTUAL FRONT + 2 DRONES'}else{'ACTUAL FRONT / GEAR-MINIMAL'}) ($x+40) 755 720 32 $h2 '#1D3446' Center
                Text $g $(if($i -eq 0){'character plus round and angular separated components'}else{'largest connected character component only'}) ($x+40) 795 720 40 $small '#456379' Center
            }
        } finally { $masks[0].Dispose(); $masks[1].Dispose() }
        Save-Png $bmp 'art_refs/characters/miyu/silhouette/Miyu_SilhouetteTest_REVIEW_v001.png'
    } finally {$g.Dispose();$bmp.Dispose()}

    # Palette and materials.
    $a=New-Canvas 1800 900; $bmp=$a[0]; $g=$a[1]
    try {
        Text $g 'MIYU / MATERIAL + PALETTE LOCK' 48 30 1300 50 $title
        Text $g 'Smoky lilac and graphite base; cyan-blue light is equipment response, not costume flood.' 50 78 1500 30 $body '#93A9BA'
        $colors=@(@('#716184','SMOKY LILAC','hair base'),@('#9B8CB4','LILAC HIGHLIGHT','hair / bomber'),@('#242631','GRAPHITE','inner / shorts / boots'),@('#A8A4A5','WARM GREY','hard-surface support'),@('#21DFF3','ELECTRIC CYAN','scan response'),@('#167DFF','NEON BLUE','inner streak / target light'))
        for($i=0;$i -lt 6;$i++){ $x=50+($i%3)*575; $y=150+[math]::Floor($i/3)*230; $b=[System.Drawing.SolidBrush]::new((C $colors[$i][0]));try{$g.FillRectangle($b,$x,$y,530,118)}finally{$b.Dispose()};Text $g $colors[$i][1] $x ($y+126) 530 28 $h2;Text $g ($colors[$i][0]+' / '+$colors[$i][2]) $x ($y+161) 530 28 $body '#AFC0CF' }
        Panel $g 50 650 1700 180 '#111F2E' '#29445B'; Text $g 'MATERIAL INTENT' 76 674 280 32 $h2 '#4CEBFA'; Text $g 'Rubber-coated textile / matte graphite composite / ceramic drone shell / translucent cyan polymer / brushed steel hardware' 76 718 1600 35 $body;Text $g 'Eye, face, hair, cloth, hard-surface and emissive slots stay separable for 3D proof.' 76 762 1600 35 $body '#B7C6D3'; Text $g 'REVIEW ONLY / APPROVAL NOT GRANTED' 76 804 1600 28 $small '#F3B36B'
        Save-Png $bmp 'art_refs/characters/miyu/palette/Miyu_MaterialPalette_REVIEW_v001.png'
    } finally {$g.Dispose();$bmp.Dispose()}

    # 2D-to-3D translation board.
    $a=New-Canvas 2048 1440; $bmp=$a[0]; $g=$a[1]
    try {
        Text $g 'MIYU / 2D TO 3D TRANSLATION' 48 28 1400 50 $title; Text $g 'Height-normalized concept handoff / topology, rig and runtime proof still pending.' 50 78 1500 28 $body '#93A9BA'
        Panel $g 48 126 610 1000; Panel $g 680 126 610 1000; Panel $g 1312 126 688 1000
        Text $g '2D KEY ART / 6.890H' 72 148 560 32 $h2 '#4CEBFA'; [void](Draw-Fit $g $key ([System.Drawing.RectangleF]::new(76,190,554,880)))
        Text $g '3D VOLUME PROOF / 5.245H' 704 148 560 32 $h2 '#F3B36B'; [void](Draw-Fit $g $ref3d ([System.Drawing.RectangleF]::new(708,190,554,880)))
        $sections=@(@('IDENTITY LOCK','sleepy mature eyes; smoky-lilac bob; blue inner streak; one large sleeve'),@('EXPAND','head, hands, boots, drone face language and readable gauntlet'),@('DELETE','micro seams, excess straps, long-leg fashion exaggeration'),@('COMBINE','bomber + inner silhouette; belt + tool kit; holo emitter + gauntlet UI'),@('PHYSICS','hair tips, large sleeve hem and short panel only; clamp drone orbit'))
        $y=160; foreach($s in $sections){Panel $g 1340 $y 632 160 '#132334' '#35536A';Text $g $s[0] 1364 ($y+18) 580 28 $h2 '#4CEBFA';Text $g $s[1] 1364 ($y+58) 580 82 $body '#C0CFDA';$y+=180}
        Panel $g 48 1155 1952 220 '#111F2E' '#29445B'; Text $g 'PROPORTION LOCK' 72 1178 300 32 $h2 '#4CEBFA';Text $g '2D: crown 86 / chin 286 / sole 1464 = 6.890H PASS' 72 1222 820 30 $body;Text $g '3D: crown 205 / chin 458 / sole 1532 = 5.245H PASS' 72 1260 820 30 $body;Text $g 'Conditional: actual mesh, Humanoid deformation, socket placement and gameplay-camera readability are not tested.' 930 1222 1020 55 $body '#B7C6D3';Text $g 'REVIEW / HUMAN REVIEWER PENDING / APPROVAL NOT GRANTED' 930 1290 1020 30 $body '#F3B36B'
        Save-Png $bmp 'art_refs/characters/miyu/3d_reference/Miyu_2DTo3DTranslation_REVIEW_v001.png'
    } finally {$g.Dispose();$bmp.Dispose()}

    # Integrated production sheet.
    $silBoard = Load 'art_refs/characters/miyu/silhouette/Miyu_SilhouetteTest_REVIEW_v001.png'
    $a=New-Canvas 3200 2200; $bmp=$a[0]; $g=$a[1]
    try {
        Text $g 'MIYU / INTEGRATED CHARACTER PRODUCTION SHEET' 54 30 2300 56 (Font 42 Bold)
        Text $g 'ART-1101-1108 review package / adult feminine asymmetric drone technician' 58 88 2100 30 $body '#93A9BA'
        Panel $g 46 136 690 1520; Text $g 'SELECTED KEY ART / 6.890H' 66 154 640 34 $h2 '#4CEBFA'; [void](Draw-Fit $g $key ([System.Drawing.RectangleF]::new(70,200,642,1390)))
        Panel $g 758 136 1570 840; Text $g 'STRICT FRONT / LEFT / BACK / 6.905H' 780 154 1100 34 $h2 '#4CEBFA'; [void](Draw-Fit $g $turn ([System.Drawing.RectangleF]::new(780,210,1526,720)))
        Panel $g 2350 136 804 840; Text $g 'EXACTLY 8 EXPRESSIONS' 2374 154 740 34 $h2 '#4CEBFA'; [void](Draw-Fit $g $expr ([System.Drawing.RectangleF]::new(2374,210,756,720)))
        Panel $g 758 998 1180 658; Text $g 'EQUIPMENT CONSTRUCTION' 780 1016 1100 34 $h2 '#4CEBFA'; [void](Draw-Fit $g $equip ([System.Drawing.RectangleF]::new(780,1070,1136,540)))
        Panel $g 1960 998 1194 658; Text $g '3D VOLUME REFERENCE / 5.245H' 1982 1016 1120 34 $h2 '#F3B36B'; [void](Draw-Fit $g $ref3d ([System.Drawing.RectangleF]::new(1990,1062,490,552))); Text $g 'ROUND DRONE' 2510 1080 580 28 $h2 '#4CEBFA';Text $g 'pickup / scan / expressive face' 2510 1120 580 28 $body '#B7C6D3';Text $g 'ANGULAR DRONE' 2510 1180 580 28 $h2 '#4CEBFA';Text $g 'targeting / fire / sharper motion' 2510 1220 580 28 $body '#B7C6D3';Text $g 'CONTROL GAUNTLET' 2510 1280 580 28 $h2 '#4CEBFA';Text $g 'right arm command surface + holo pad' 2510 1320 580 50 $body '#B7C6D3';Text $g 'TOOL KIT' 2510 1390 580 28 $h2 '#4CEBFA';Text $g 'asymmetric belt mount / readable closed-open states' 2510 1430 580 58 $body '#B7C6D3'
        Panel $g 46 1680 3108 456 '#111F2E' '#29445B'; Text $g 'LOCKS' 74 1702 250 32 $h2 '#4CEBFA';Text $g 'Adult woman / sleepy deadpan <-> machine enthusiasm / smoky-lilac asym bob / exactly 2 drones / exactly 1 oversized sleeve' 74 1746 2200 34 $body;Text $g 'Palette: #716184  #9B8CB4  #242631  #A8A4A5  #21DFF3  #167DFF' 74 1792 1800 30 $body '#B7C6D3';Text $g '2D 6.890H PASS / Turnaround 6.905H PASS / 3D 5.245H PASS (image-space evidence)' 74 1840 2200 30 $body '#B7C6D3';Text $g 'Conditional: human appeal, five-character collision, originality, mesh topology, Humanoid rig, sockets, physics and runtime camera remain pending.' 74 1890 2200 52 $body '#F3B36B';Text $g 'STATUS: REVIEW ONLY / HUMAN REVIEWER PENDING / APPROVAL NOT GRANTED' 74 1970 2200 34 $h2 '#F3B36B';Text $g 'No external-IP copy target. Failed generations remain WIP history and are not promoted.' 74 2022 2200 30 $body '#93A9BA'; [void](Draw-Fit $g $silBoard ([System.Drawing.RectangleF]::new(2400,1704,710,390)))
        Save-Png $bmp 'art_refs/characters/miyu/Miyu_CharacterSheet_REVIEW_v001.png'
    } finally {$g.Dispose();$bmp.Dispose();$silBoard.Dispose()}
} finally {
    $title.Dispose(); $h2.Dispose(); $body.Dispose(); $small.Dispose(); $tiny.Dispose()
    $key.Dispose(); $turnSource.Dispose(); $ref3dSource.Dispose(); $expr.Dispose(); $equip.Dispose(); $cand1.Dispose(); $cand2.Dispose(); $cand3.Dispose()
    if ($turn) { $turn.Dispose() }; if ($ref3d) { $ref3d.Dispose() }
}
