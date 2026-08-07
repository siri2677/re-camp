[CmdletBinding()]
param(
    [string]$ProjectRoot,
    [string]$OutputDirectory = 'art_refs/characters/lineup',
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

if ([string]::IsNullOrWhiteSpace($ProjectRoot)) {
    $ProjectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
}
else {
    $ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot)
}

function Resolve-InputPath([string]$Path) {
    $candidate = if ([IO.Path]::IsPathRooted($Path)) { $Path } else { Join-Path $ProjectRoot $Path }
    return (Resolve-Path -LiteralPath $candidate -ErrorAction Stop).Path
}

function Resolve-OutputPath([string]$Path) {
    if ([IO.Path]::IsPathRooted($Path)) { return [IO.Path]::GetFullPath($Path) }
    return [IO.Path]::GetFullPath((Join-Path $ProjectRoot $Path))
}

function Get-Color([string]$Hex) {
    return [Drawing.ColorTranslator]::FromHtml($Hex)
}

function New-Font([float]$Size, [Drawing.FontStyle]$Style = [Drawing.FontStyle]::Regular) {
    try {
        return [Drawing.Font]::new('Segoe UI', $Size, $Style, [Drawing.GraphicsUnit]::Pixel)
    }
    catch {
        return [Drawing.Font]::new([Drawing.FontFamily]::GenericSansSerif, $Size, $Style, [Drawing.GraphicsUnit]::Pixel)
    }
}

function Initialize-Graphics([Drawing.Graphics]$Graphics) {
    $Graphics.SmoothingMode = [Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $Graphics.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $Graphics.PixelOffsetMode = [Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $Graphics.CompositingQuality = [Drawing.Drawing2D.CompositingQuality]::HighQuality
    $Graphics.TextRenderingHint = [Drawing.Text.TextRenderingHint]::AntiAliasGridFit
}

function Draw-Text(
    [Drawing.Graphics]$Graphics,
    [string]$Text,
    [Drawing.Font]$Font,
    [Drawing.Brush]$Brush,
    [Drawing.RectangleF]$Bounds,
    [Drawing.StringAlignment]$Alignment = [Drawing.StringAlignment]::Near,
    [Drawing.StringAlignment]$LineAlignment = [Drawing.StringAlignment]::Near
) {
    $format = [Drawing.StringFormat]::new()
    try {
        $format.Alignment = $Alignment
        $format.LineAlignment = $LineAlignment
        $format.Trimming = [Drawing.StringTrimming]::EllipsisCharacter
        $format.FormatFlags = [Drawing.StringFormatFlags]::LineLimit
        $Graphics.DrawString($Text, $Font, $Brush, $Bounds, $format)
    }
    finally {
        $format.Dispose()
    }
}

function Get-FitRectangle([Drawing.Image]$Image, [Drawing.RectangleF]$Bounds) {
    $scale = [Math]::Min($Bounds.Width / $Image.Width, $Bounds.Height / $Image.Height)
    $width = [float]($Image.Width * $scale)
    $height = [float]($Image.Height * $scale)
    return [Drawing.RectangleF]::new(
        [float]($Bounds.X + ($Bounds.Width - $width) / 2.0),
        [float]($Bounds.Y + ($Bounds.Height - $height) / 2.0),
        $width,
        $height)
}

function Draw-ImageFit([Drawing.Graphics]$Graphics, [Drawing.Image]$Image, [Drawing.RectangleF]$Bounds) {
    $destination = Get-FitRectangle -Image $Image -Bounds $Bounds
    $Graphics.DrawImage($Image, $destination)
}

function Draw-ImageHeightNormalized(
    [Drawing.Graphics]$Graphics,
    [Drawing.Image]$Image,
    [Drawing.RectangleF]$Bounds,
    [double]$FigureCrownY,
    [double]$FigureSoleY,
    [double]$FigureCenterX,
    [bool]$Desaturated = $false
) {
    $figureHeight = $FigureSoleY - $FigureCrownY
    if ($figureHeight -le 0) { throw 'FigureSoleY must be below FigureCrownY.' }

    $targetHeight = [double]$Bounds.Height - 64.0
    $scale = $targetHeight / $figureHeight
    $destination = [Drawing.RectangleF]::new(
        [float]($Bounds.X + $Bounds.Width / 2.0 - $FigureCenterX * $scale),
        [float]($Bounds.Y + 32.0 - $FigureCrownY * $scale),
        [float]($Image.Width * $scale),
        [float]($Image.Height * $scale))

    $state = $Graphics.Save()
    try {
        $Graphics.SetClip($Bounds)
        if (-not $Desaturated) {
            $Graphics.DrawImage($Image, $destination)
            return
        }

        $matrix = [Drawing.Imaging.ColorMatrix]::new([single[][]]@(
            [single[]]@(0.299, 0.299, 0.299, 0, 0),
            [single[]]@(0.587, 0.587, 0.587, 0, 0),
            [single[]]@(0.114, 0.114, 0.114, 0, 0),
            [single[]]@(0, 0, 0, 1, 0),
            [single[]]@(0, 0, 0, 0, 1)
        ))
        $attributes = [Drawing.Imaging.ImageAttributes]::new()
        try {
            $attributes.SetColorMatrix($matrix)
            $destinationInt = [Drawing.Rectangle]::new(
                [int][Math]::Round($destination.X),
                [int][Math]::Round($destination.Y),
                [int][Math]::Round($destination.Width),
                [int][Math]::Round($destination.Height))
            $Graphics.DrawImage(
                $Image,
                $destinationInt,
                0,
                0,
                $Image.Width,
                $Image.Height,
                [Drawing.GraphicsUnit]::Pixel,
                $attributes)
        }
        finally {
            $attributes.Dispose()
        }
    }
    finally {
        $Graphics.Restore($state)
    }
}

function Draw-ImageFitDesaturated([Drawing.Graphics]$Graphics, [Drawing.Image]$Image, [Drawing.RectangleF]$Bounds) {
    $destination = Get-FitRectangle -Image $Image -Bounds $Bounds
    $matrix = [Drawing.Imaging.ColorMatrix]::new([single[][]]@(
        [single[]]@(0.299, 0.299, 0.299, 0, 0),
        [single[]]@(0.587, 0.587, 0.587, 0, 0),
        [single[]]@(0.114, 0.114, 0.114, 0, 0),
        [single[]]@(0, 0, 0, 1, 0),
        [single[]]@(0, 0, 0, 0, 1)
    ))
    $attributes = [Drawing.Imaging.ImageAttributes]::new()
    try {
        $attributes.SetColorMatrix($matrix)
        $destinationInt = [Drawing.Rectangle]::new(
            [int][Math]::Round($destination.X),
            [int][Math]::Round($destination.Y),
            [int][Math]::Round($destination.Width),
            [int][Math]::Round($destination.Height))
        $Graphics.DrawImage(
            $Image,
            $destinationInt,
            0,
            0,
            $Image.Width,
            $Image.Height,
            [Drawing.GraphicsUnit]::Pixel,
            $attributes)
    }
    finally {
        $attributes.Dispose()
    }
}

function Save-Canvas([Drawing.Bitmap]$Canvas, [string]$Path) {
    if ([IO.File]::Exists($Path) -and -not $Force) {
        throw "Output exists: $Path. Use -Force to overwrite deterministic outputs."
    }
    $directory = Split-Path -Parent $Path
    [IO.Directory]::CreateDirectory($directory) | Out-Null
    $Canvas.Save($Path, [Drawing.Imaging.ImageFormat]::Png)
}

$characters = @(
    [pscustomobject]@{
        Id='CH001'; Name='LUNA'; Role='Sensor-cat Scout';
        Hook='Bright scout / sensor ears / paired energy daggers';
        Ratio2D='6.90-7.10 H'; Ratio3D='5.30-5.40 H'; Accent='#43E6E1';
        KeyArt='art_refs/characters/luna/concept/Luna_KeyArt_REVIEW_v002.png';
        Face='art_refs/characters/luna/concept/Luna_Face128_REVIEW_v003.png';
        CrownY=210; SoleY=1685; CenterX=432;
        Silhouette='art_refs/characters/luna/concept/Luna_SilhouetteTest_REVIEW_v002.png'
    },
    [pscustomobject]@{
        Id='CH002'; Name='MIYU'; Role='Drone Technician';
        Hook='Sleepy technician / one large sleeve / two distinct drones';
        Ratio2D='6.80-7.00 H'; Ratio3D='5.20-5.30 H'; Accent='#B69AF6';
        KeyArt='art_refs/characters/miyu/concept/Miyu_KeyArt_REVIEW_v002.png';
        Face='art_refs/characters/miyu/face/Miyu_Face128_REVIEW_v002.png';
        CrownY=145; SoleY=1460; CenterX=512;
        Silhouette='art_refs/characters/miyu/silhouette/Miyu_SilhouetteTest_REVIEW_v001.png'
    },
    [pscustomobject]@{
        Id='CH003'; Name='COCO'; Role='Rescue Captain';
        Hook='Warm rescue lead / coral half-cape / injector + clear field';
        Ratio2D='7.00-7.20 H'; Ratio3D='5.50-5.60 H'; Accent='#E88773';
        KeyArt='art_refs/characters/coco/concept/Coco_KeyArt_REVIEW_v005.png';
        Face='art_refs/characters/coco/concept/Coco_Face128_REVIEW_v003.png';
        CrownY=145; SoleY=1720; CenterX=430;
        Silhouette='art_refs/characters/coco/concept/Coco_SilhouetteTest_REVIEW_v001.png'
    },
    [pscustomobject]@{
        Id='CH004'; Name='IRIS'; Role='Observation Specialist';
        Hook='Elegant observer / long white coat / energy observation lance';
        Ratio2D='7.20-7.40 H'; Ratio3D='5.70-5.80 H'; Accent='#E15B78';
        KeyArt='art_refs/characters/iris/concept/Iris_KeyArt_REVIEW_v006.png';
        Face='art_refs/characters/iris/concept/Iris_Face128_REVIEW_v003.png';
        CrownY=225; SoleY=1765; CenterX=455;
        Silhouette='art_refs/characters/iris/concept/Iris_SilhouetteTest_REVIEW_v001.png'
    },
    [pscustomobject]@{
        Id='CH005'; Name='NOAH'; Role='Mobile Haven Guardian';
        Hook='Calm guardian / short navy bob / case-to-door barrier shield';
        Ratio2D='7.20-7.40 H'; Ratio3D='5.70-5.80 H'; Accent='#F0A84A';
        KeyArt='art_refs/characters/noah/concept/Noah_KeyArt_REVIEW_v003.png';
        Face='art_refs/characters/noah/concept/Noah_Face128_REVIEW_v002.png';
        CrownY=205; SoleY=1545; CenterX=455;
        Silhouette='art_refs/characters/noah/concept/Noah_SilhouetteTest_REVIEW_v001.png'
    }
)

$images = @()
foreach ($character in $characters) {
    $keyArt = [Drawing.Bitmap]::FromFile((Resolve-InputPath $character.KeyArt))
    $face = [Drawing.Bitmap]::FromFile((Resolve-InputPath $character.Face))
    $silhouette = [Drawing.Bitmap]::FromFile((Resolve-InputPath $character.Silhouette))
    if ($face.Width -ne 128 -or $face.Height -ne 128) {
        $keyArt.Dispose(); $face.Dispose(); $silhouette.Dispose()
        throw "$($character.Name) Face128 must be exactly 128x128."
    }
    $images += [pscustomobject]@{ Character=$character; KeyArt=$keyArt; Face=$face; Silhouette=$silhouette }
}

$outputRoot = Resolve-OutputPath $OutputDirectory
$lineupPath = Join-Path $outputRoot 'ReCamp_FiveCharacterLineup_REVIEW_v002.png'
$crossReviewPath = Join-Path $outputRoot 'ReCamp_FiveCharacterCrossReview_REVIEW_v002.png'

$fonts = @{
    Title=New-Font 48 ([Drawing.FontStyle]::Bold)
    Subtitle=New-Font 22
    Name=New-Font 34 ([Drawing.FontStyle]::Bold)
    Role=New-Font 20 ([Drawing.FontStyle]::Bold)
    Body=New-Font 18
    Small=New-Font 15
    Section=New-Font 28 ([Drawing.FontStyle]::Bold)
    Status=New-Font 20 ([Drawing.FontStyle]::Bold)
}

$background = [Drawing.SolidBrush]::new((Get-Color '#07111F'))
$panel = [Drawing.SolidBrush]::new((Get-Color '#0E1929'))
$panelAlt = [Drawing.SolidBrush]::new((Get-Color '#111F33'))
$white = [Drawing.SolidBrush]::new((Get-Color '#F8FAFC'))
$muted = [Drawing.SolidBrush]::new((Get-Color '#9BAABD'))
$warning = [Drawing.SolidBrush]::new((Get-Color '#F7B955'))
$border = [Drawing.Pen]::new((Get-Color '#2A3B51'), 2)

try {
    $lineup = [Drawing.Bitmap]::new(4096, 2304, [Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [Drawing.Graphics]::FromImage($lineup)
    try {
        Initialize-Graphics $graphics
        $graphics.FillRectangle($background, 0, 0, $lineup.Width, $lineup.Height)
        Draw-Text $graphics 'RE:CAMP / FIVE-CHARACTER DESIGN LINEUP' $fonts.Title $white ([Drawing.RectangleF]::new(48, 28, 2500, 64))
        Draw-Text $graphics 'ART-1501 + ART-1504 / JP subculture style reset / body-height normalized / current Baseline targets' $fonts.Subtitle $muted ([Drawing.RectangleF]::new(51, 96, 3100, 36))
        Draw-Text $graphics 'JP STYLE RESET / REVIEW / APPROVAL PENDING' $fonts.Status $warning ([Drawing.RectangleF]::new(2870, 52, 1178, 36)) ([Drawing.StringAlignment]::Far)

        $margin = 48
        $gap = 16
        $panelWidth = 787
        $panelTop = 160
        $panelHeight = 2030
        for ($i = 0; $i -lt $images.Count; $i++) {
            $entry = $images[$i]
            $character = $entry.Character
            $x = $margin + $i * ($panelWidth + $gap)
            $bounds = [Drawing.Rectangle]::new($x, $panelTop, $panelWidth, $panelHeight)
            $accent = Get-Color $character.Accent
            $accentBrush = [Drawing.SolidBrush]::new($accent)
            $accentPen = [Drawing.Pen]::new($accent, 3)
            try {
                $graphics.FillRectangle($panel, $bounds)
                $graphics.DrawRectangle($border, $bounds)
                $graphics.FillRectangle($accentBrush, $x, $panelTop, 8, $panelHeight)
                Draw-Text $graphics "$($character.Id) / $($character.Name)" $fonts.Name $white ([Drawing.RectangleF]::new($x + 26, $panelTop + 18, $panelWidth - 50, 48))
                Draw-Text $graphics $character.Role $fonts.Role $accentBrush ([Drawing.RectangleF]::new($x + 27, $panelTop + 70, $panelWidth - 50, 34))
                $imageBounds = [Drawing.RectangleF]::new($x + 20, $panelTop + 120, $panelWidth - 40, 1520)
                $graphics.FillRectangle($panelAlt, $imageBounds)
                Draw-ImageHeightNormalized $graphics $entry.KeyArt $imageBounds $character.CrownY $character.SoleY $character.CenterX
                $graphics.DrawLine($accentPen, $x + 24, $panelTop + 1660, $x + $panelWidth - 24, $panelTop + 1660)
                Draw-Text $graphics 'IDENTITY HOOK' $fonts.Small $muted ([Drawing.RectangleF]::new($x + 26, $panelTop + 1680, $panelWidth - 52, 28))
                Draw-Text $graphics $character.Hook $fonts.Body $white ([Drawing.RectangleF]::new($x + 26, $panelTop + 1712, $panelWidth - 52, 78))
                Draw-Text $graphics "2D TARGET  $($character.Ratio2D)" $fonts.Role $accentBrush ([Drawing.RectangleF]::new($x + 26, $panelTop + 1810, $panelWidth - 52, 30))
                Draw-Text $graphics "3D TARGET  $($character.Ratio3D)" $fonts.Role $accentBrush ([Drawing.RectangleF]::new($x + 26, $panelTop + 1848, $panelWidth - 52, 30))
                Draw-Text $graphics 'Exact measured values and construction caveats remain in the individual package.' $fonts.Small $muted ([Drawing.RectangleF]::new($x + 26, $panelTop + 1900, $panelWidth - 52, 70))
            }
            finally {
                $accentPen.Dispose()
                $accentBrush.Dispose()
            }
        }
        Draw-Text $graphics 'Direction precheck: five distinct adult-woman archetypes, role equipment and palette families are present. This board does not grant Gate A approval.' $fonts.Body $warning ([Drawing.RectangleF]::new(48, 2220, 4000, 36))
        Save-Canvas $lineup $lineupPath
    }
    finally {
        $graphics.Dispose()
        $lineup.Dispose()
    }

    $review = [Drawing.Bitmap]::new(4096, 2304, [Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [Drawing.Graphics]::FromImage($review)
    try {
        Initialize-Graphics $graphics
        $graphics.FillRectangle($background, 0, 0, $review.Width, $review.Height)
        Draw-Text $graphics 'RE:CAMP / FIVE-CHARACTER CROSS-REVIEW' $fonts.Title $white ([Drawing.RectangleF]::new(48, 28, 2500, 64))
        Draw-Text $graphics 'ART-1502 / exact 128px faces + normalized silhouette sheets + desaturated full-body read' $fonts.Subtitle $muted ([Drawing.RectangleF]::new(51, 96, 3100, 36))
        Draw-Text $graphics 'PRECHECK / HUMAN VERDICT PENDING' $fonts.Status $warning ([Drawing.RectangleF]::new(3100, 52, 948, 36)) ([Drawing.StringAlignment]::Far)

        $margin = 48
        $gap = 16
        $columnWidth = 787
        Draw-Text $graphics '01 / EXACT 128px FACE READ' $fonts.Section $white ([Drawing.RectangleF]::new(48, 150, 1900, 42))
        Draw-Text $graphics 'Source crops remain 128x128; enlarged here with nearest-neighbor interpolation.' $fonts.Body $muted ([Drawing.RectangleF]::new(1940, 160, 2108, 34)) ([Drawing.StringAlignment]::Far)
        for ($i = 0; $i -lt $images.Count; $i++) {
            $entry = $images[$i]
            $character = $entry.Character
            $x = $margin + $i * ($columnWidth + $gap)
            $facePanel = [Drawing.Rectangle]::new($x, 205, $columnWidth, 390)
            $accentBrush = [Drawing.SolidBrush]::new((Get-Color $character.Accent))
            try {
                $graphics.FillRectangle($panel, $facePanel)
                $graphics.DrawRectangle($border, $facePanel)
                $oldInterpolation = $graphics.InterpolationMode
                $graphics.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
                $graphics.DrawImage($entry.Face, [Drawing.Rectangle]::new($x + 253, 225, 280, 280))
                $graphics.InterpolationMode = $oldInterpolation
                Draw-Text $graphics $character.Name $fonts.Role $accentBrush ([Drawing.RectangleF]::new($x + 20, 520, $columnWidth - 40, 30)) ([Drawing.StringAlignment]::Center)
            }
            finally {
                $accentBrush.Dispose()
            }
        }

        Draw-Text $graphics '02 / HEIGHT-NORMALIZED SILHOUETTE SOURCES' $fonts.Section $white ([Drawing.RectangleF]::new(48, 625, 2200, 42))
        Draw-Text $graphics 'Each panel contains equipment-inclusive and gear-minimal evidence from the character package.' $fonts.Body $muted ([Drawing.RectangleF]::new(2040, 636, 2008, 34)) ([Drawing.StringAlignment]::Far)
        for ($i = 0; $i -lt $images.Count; $i++) {
            $entry = $images[$i]
            $x = $margin + $i * ($columnWidth + $gap)
            $silhouettePanel = [Drawing.Rectangle]::new($x, 680, $columnWidth, 500)
            $graphics.FillRectangle($panel, $silhouettePanel)
            $graphics.DrawRectangle($border, $silhouettePanel)
            Draw-ImageFit $graphics $entry.Silhouette ([Drawing.RectangleF]::new($x + 12, 692, $columnWidth - 24, 476))
        }

        Draw-Text $graphics '03 / LOW-SATURATION VALUE READ' $fonts.Section $white ([Drawing.RectangleF]::new(48, 1210, 1900, 42))
        Draw-Text $graphics 'Hue is removed to expose value hierarchy; this is not a color-vision-deficiency simulation.' $fonts.Body $muted ([Drawing.RectangleF]::new(1900, 1221, 2148, 34)) ([Drawing.StringAlignment]::Far)
        for ($i = 0; $i -lt $images.Count; $i++) {
            $entry = $images[$i]
            $character = $entry.Character
            $x = $margin + $i * ($columnWidth + $gap)
            $desatPanel = [Drawing.Rectangle]::new($x, 1265, $columnWidth, 760)
            $accentBrush = [Drawing.SolidBrush]::new((Get-Color $character.Accent))
            try {
                $graphics.FillRectangle($panelAlt, $desatPanel)
                $graphics.DrawRectangle($border, $desatPanel)
                Draw-ImageHeightNormalized $graphics $entry.KeyArt ([Drawing.RectangleF]::new($x + 16, 1280, $columnWidth - 32, 680)) $character.CrownY $character.SoleY $character.CenterX $true
                Draw-Text $graphics "$($character.Name) / $($character.Role)" $fonts.Small $accentBrush ([Drawing.RectangleF]::new($x + 18, 1970, $columnWidth - 36, 28)) ([Drawing.StringAlignment]::Center)
            }
            finally {
                $accentBrush.Dispose()
            }
        }

        $summaryBounds = [Drawing.Rectangle]::new(48, 2055, 4000, 180)
        $graphics.FillRectangle($panel, $summaryBounds)
        $graphics.DrawRectangle($border, $summaryBounds)
        Draw-Text $graphics 'CROSS-REVIEW PRECHECK' $fonts.Role $warning ([Drawing.RectangleF]::new(76, 2075, 600, 32))
        Draw-Text $graphics 'Face: all five now use the Japanese mobile-subculture face contract and retain distinct hair/eye families.  Silhouette: existing role-equipment hooks remain readable; gear-minimal distinction still needs human/runtime confirmation.  Value: dark outfit overlap remains a Gate C risk.' $fonts.Body $white ([Drawing.RectangleF]::new(76, 2115, 3880, 66))
        Draw-Text $graphics 'JP SUBCULTURE STYLE RESET / REVIEW / HUMAN APPROVAL PENDING / NOT GRANTED' $fonts.Status $warning ([Drawing.RectangleF]::new(76, 2190, 3880, 32)) ([Drawing.StringAlignment]::Far)
        Save-Canvas $review $crossReviewPath
    }
    finally {
        $graphics.Dispose()
        $review.Dispose()
    }

    [pscustomobject]@{
        Lineup = $lineupPath
        CrossReview = $crossReviewPath
        Dimensions = '4096x2304 each'
        Characters = $characters.Count
        FaceSource = '128x128 each'
        Status = 'JP SUBCULTURE STYLE RESET / REVIEW'
        HumanApproval = 'NOT GRANTED'
    }
}
finally {
    $border.Dispose()
    $warning.Dispose()
    $muted.Dispose()
    $white.Dispose()
    $panelAlt.Dispose()
    $panel.Dispose()
    $background.Dispose()
    foreach ($font in $fonts.Values) { $font.Dispose() }
    foreach ($entry in $images) {
        $entry.KeyArt.Dispose()
        $entry.Face.Dispose()
        $entry.Silhouette.Dispose()
    }
}
