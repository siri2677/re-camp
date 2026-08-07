[CmdletBinding()]
param(
    [string]$ProjectRoot,
    [string]$KeyArtPath = 'art_refs/characters/luna/concept/Luna_KeyArt_REVIEW_v001.png',
    [string]$Reference3DPath = 'art_refs/characters/luna/3d_reference/Luna_3DReference_REVIEW_v001.png',
    [string]$OutputPath = 'art_refs/characters/luna/3d_reference/Luna_2DTo3DTranslation_REVIEW_v004.png',
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

function Resolve-InputPath {
    param([Parameter(Mandatory = $true)][string]$Path)

    $candidate = if ([System.IO.Path]::IsPathRooted($Path)) { $Path } else { Join-Path $ProjectRoot $Path }
    return (Resolve-Path -LiteralPath $candidate -ErrorAction Stop).Path
}

function Resolve-OutputPath {
    param([Parameter(Mandatory = $true)][string]$Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return [System.IO.Path]::GetFullPath($Path)
    }

    return [System.IO.Path]::GetFullPath((Join-Path $ProjectRoot $Path))
}

function Get-Color {
    param([Parameter(Mandatory = $true)][string]$Hex)
    return [System.Drawing.ColorTranslator]::FromHtml($Hex)
}

function New-Font {
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

function New-RoundedPath {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.RectangleF]$Rectangle,
        [Parameter(Mandatory = $true)][float]$Radius
    )

    $diameter = $Radius * 2.0
    $path = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $path.AddArc($Rectangle.X, $Rectangle.Y, $diameter, $diameter, 180, 90)
    $path.AddArc($Rectangle.Right - $diameter, $Rectangle.Y, $diameter, $diameter, 270, 90)
    $path.AddArc($Rectangle.Right - $diameter, $Rectangle.Bottom - $diameter, $diameter, $diameter, 0, 90)
    $path.AddArc($Rectangle.X, $Rectangle.Bottom - $diameter, $diameter, $diameter, 90, 90)
    $path.CloseFigure()
    return $path
}

function Fill-RoundedRectangle {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)][System.Drawing.Brush]$Brush,
        [Parameter(Mandatory = $true)][System.Drawing.RectangleF]$Rectangle,
        [float]$Radius = 18.0
    )

    $path = New-RoundedPath -Rectangle $Rectangle -Radius $Radius
    try { $Graphics.FillPath($Brush, $path) } finally { $path.Dispose() }
}

function Draw-RoundedRectangle {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)][System.Drawing.Pen]$Pen,
        [Parameter(Mandatory = $true)][System.Drawing.RectangleF]$Rectangle,
        [float]$Radius = 18.0
    )

    $path = New-RoundedPath -Rectangle $Rectangle -Radius $Radius
    try { $Graphics.DrawPath($Pen, $path) } finally { $path.Dispose() }
}

function Draw-Text {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)][string]$Text,
        [Parameter(Mandatory = $true)][System.Drawing.Font]$Font,
        [Parameter(Mandatory = $true)][System.Drawing.Brush]$Brush,
        [Parameter(Mandatory = $true)][System.Drawing.RectangleF]$Rectangle,
        [System.Drawing.StringAlignment]$Alignment = [System.Drawing.StringAlignment]::Near,
        [System.Drawing.StringAlignment]$LineAlignment = [System.Drawing.StringAlignment]::Near
    )

    $format = [System.Drawing.StringFormat]::new()
    try {
        $format.Alignment = $Alignment
        $format.LineAlignment = $LineAlignment
        $format.Trimming = [System.Drawing.StringTrimming]::EllipsisCharacter
        $Graphics.DrawString($Text, $Font, $Brush, $Rectangle, $format)
    }
    finally {
        $format.Dispose()
    }
}

function Draw-Chip {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)][string]$Text,
        [Parameter(Mandatory = $true)][System.Drawing.RectangleF]$Rectangle,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$Fill,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$Stroke,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$TextColor,
        [Parameter(Mandatory = $true)][System.Drawing.Font]$Font
    )

    $fillBrush = [System.Drawing.SolidBrush]::new($Fill)
    $pen = [System.Drawing.Pen]::new($Stroke, 1.5)
    $textBrush = [System.Drawing.SolidBrush]::new($TextColor)
    try {
        Fill-RoundedRectangle -Graphics $Graphics -Brush $fillBrush -Rectangle $Rectangle -Radius 16
        Draw-RoundedRectangle -Graphics $Graphics -Pen $pen -Rectangle $Rectangle -Radius 16
        Draw-Text -Graphics $Graphics -Text $Text -Font $Font -Brush $textBrush -Rectangle $Rectangle `
            -Alignment Center -LineAlignment Center
    }
    finally {
        $fillBrush.Dispose()
        $pen.Dispose()
        $textBrush.Dispose()
    }
}

function Draw-SectionCard {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)][string]$Title,
        [Parameter(Mandatory = $true)][string[]]$Lines,
        [Parameter(Mandatory = $true)][System.Drawing.RectangleF]$Rectangle,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$Accent,
        [Parameter(Mandatory = $true)][System.Drawing.Font]$TitleFont,
        [Parameter(Mandatory = $true)][System.Drawing.Font]$BodyFont,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$TextColor,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$MutedColor
    )

    $cardBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(238, 17, 27, 43))
    $borderPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 45, 65, 89), 1.5)
    $accentBrush = [System.Drawing.SolidBrush]::new($Accent)
    $titleBrush = [System.Drawing.SolidBrush]::new($TextColor)
    $bodyBrush = [System.Drawing.SolidBrush]::new($MutedColor)
    try {
        Fill-RoundedRectangle -Graphics $Graphics -Brush $cardBrush -Rectangle $Rectangle -Radius 16
        Draw-RoundedRectangle -Graphics $Graphics -Pen $borderPen -Rectangle $Rectangle -Radius 16
        $Graphics.FillRectangle($accentBrush, $Rectangle.X, $Rectangle.Y + 17, 5, $Rectangle.Height - 34)
        Draw-Text -Graphics $Graphics -Text $Title -Font $TitleFont -Brush $titleBrush `
            -Rectangle ([System.Drawing.RectangleF]::new($Rectangle.X + 22, $Rectangle.Y + 13, $Rectangle.Width - 40, 30))

        $lineY = $Rectangle.Y + 50
        foreach ($line in $Lines) {
            Draw-Text -Graphics $Graphics -Text ('- ' + $line) -Font $BodyFont -Brush $bodyBrush `
                -Rectangle ([System.Drawing.RectangleF]::new($Rectangle.X + 24, $lineY, $Rectangle.Width - 42, 30))
            $lineY += 29
        }
    }
    finally {
        $cardBrush.Dispose()
        $borderPen.Dispose()
        $accentBrush.Dispose()
        $titleBrush.Dispose()
        $bodyBrush.Dispose()
    }
}

function Draw-FigurePanel {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)][System.Drawing.Image]$Image,
        [Parameter(Mandatory = $true)][System.Drawing.RectangleF]$Panel,
        [Parameter(Mandatory = $true)][string]$Label,
        [Parameter(Mandatory = $true)][string]$SubLabel,
        [Parameter(Mandatory = $true)][int]$SourceCrownY,
        [Parameter(Mandatory = $true)][int]$SourceChinY,
        [Parameter(Mandatory = $true)][int]$SourceSoleY,
        [Parameter(Mandatory = $true)][float]$TargetCrownY,
        [Parameter(Mandatory = $true)][float]$TargetSoleY,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$Accent,
        [Parameter(Mandatory = $true)][System.Drawing.Font]$LabelFont,
        [Parameter(Mandatory = $true)][System.Drawing.Font]$SmallFont,
        [Parameter(Mandatory = $true)][System.Drawing.Font]$GuideFont
    )

    $ratio = [math]::Round(($SourceSoleY - $SourceCrownY) / [double]($SourceChinY - $SourceCrownY), 2)
    $targetHeight = $TargetSoleY - $TargetCrownY
    $scale = $targetHeight / [double]($SourceSoleY - $SourceCrownY)
    $destinationWidth = [float]($Image.Width * $scale)
    $destinationHeight = [float]($Image.Height * $scale)
    $destinationX = [float]($Panel.X + (($Panel.Width - $destinationWidth) / 2.0))
    $destinationY = [float]($TargetCrownY - ($SourceCrownY * $scale))

    $panelBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(246, 10, 20, 35))
    $borderPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 42, 62, 87), 1.5)
    $accentBrush = [System.Drawing.SolidBrush]::new($Accent)
    $mainBrush = [System.Drawing.SolidBrush]::new((Get-Color '#EEF7FF'))
    $mutedBrush = [System.Drawing.SolidBrush]::new((Get-Color '#91A6BB'))
    $guidePen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(138, $Accent), 1.25)
    $guideBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(235, $Accent))
    try {
        Fill-RoundedRectangle -Graphics $Graphics -Brush $panelBrush -Rectangle $Panel -Radius 22
        Draw-RoundedRectangle -Graphics $Graphics -Pen $borderPen -Rectangle $Panel -Radius 22
        $Graphics.FillRectangle($accentBrush, $Panel.X + 20, $Panel.Y + 21, 8, 48)
        Draw-Text -Graphics $Graphics -Text $Label -Font $LabelFont -Brush $mainBrush `
            -Rectangle ([System.Drawing.RectangleF]::new($Panel.X + 43, $Panel.Y + 17, $Panel.Width - 68, 35))
        Draw-Text -Graphics $Graphics -Text $SubLabel -Font $SmallFont -Brush $mutedBrush `
            -Rectangle ([System.Drawing.RectangleF]::new($Panel.X + 43, $Panel.Y + 52, $Panel.Width - 68, 27))

        $oldClip = $Graphics.Clip
        try {
            $imageClip = [System.Drawing.RectangleF]::new($Panel.X + 2, $Panel.Y + 83, $Panel.Width - 4, $Panel.Height - 85)
            $Graphics.SetClip($imageClip)
            $destination = [System.Drawing.RectangleF]::new($destinationX, $destinationY, $destinationWidth, $destinationHeight)
            $Graphics.DrawImage($Image, $destination)
        }
        finally {
            $Graphics.Clip = $oldClip
            $oldClip.Dispose()
        }

        $headStep = $targetHeight / $ratio
        for ($index = 0; $index -le [math]::Floor($ratio); $index++) {
            $y = [float]($TargetCrownY + ($headStep * $index))
            $guidePen.DashStyle = if ($index -eq 0) {
                [System.Drawing.Drawing2D.DashStyle]::Solid
            }
            else {
                [System.Drawing.Drawing2D.DashStyle]::Dash
            }
            $Graphics.DrawLine($guidePen, $Panel.X + 14, $y, $Panel.Right - 14, $y)
            Draw-Text -Graphics $Graphics -Text ($index.ToString() + 'H') -Font $GuideFont -Brush $guideBrush `
                -Rectangle ([System.Drawing.RectangleF]::new($Panel.Right - 51, $y - 18, 38, 25)) `
                -Alignment Far -LineAlignment Center
        }

        $Graphics.DrawLine($guidePen, $Panel.X + 14, $TargetSoleY, $Panel.Right - 14, $TargetSoleY)
        Draw-Text -Graphics $Graphics -Text ($ratio.ToString('0.00') + 'H') -Font $GuideFont -Brush $guideBrush `
            -Rectangle ([System.Drawing.RectangleF]::new($Panel.Right - 75, $TargetSoleY - 24, 62, 26)) `
            -Alignment Far -LineAlignment Center
    }
    finally {
        $panelBrush.Dispose()
        $borderPen.Dispose()
        $accentBrush.Dispose()
        $mainBrush.Dispose()
        $mutedBrush.Dispose()
        $guidePen.Dispose()
        $guideBrush.Dispose()
    }
}

$resolvedKeyArt = Resolve-InputPath -Path $KeyArtPath
$resolved3D = Resolve-InputPath -Path $Reference3DPath
$resolvedOutput = Resolve-OutputPath -Path $OutputPath

if ([System.IO.File]::Exists($resolvedOutput) -and -not $Force) {
    throw "Output already exists: $resolvedOutput. Re-run with -Force to replace deterministic REVIEW output."
}

$outputDirectory = Split-Path -Parent $resolvedOutput
if (-not [System.IO.Directory]::Exists($outputDirectory)) {
    [System.IO.Directory]::CreateDirectory($outputDirectory) | Out-Null
}

$canvas = [System.Drawing.Bitmap]::new(2048, 1440, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$graphics = [System.Drawing.Graphics]::FromImage($canvas)
$keyArt = [System.Drawing.Image]::FromFile($resolvedKeyArt)
$reference3D = [System.Drawing.Image]::FromFile($resolved3D)

$titleFont = New-Font -Size 38 -Style Bold
$subtitleFont = New-Font -Size 17 -Style Regular
$panelLabelFont = New-Font -Size 25 -Style Bold
$smallFont = New-Font -Size 15 -Style Regular
$chipFont = New-Font -Size 16 -Style Bold
$guideFont = New-Font -Size 13 -Style Bold
$sectionTitleFont = New-Font -Size 18 -Style Bold
$sectionBodyFont = New-Font -Size 15 -Style Regular
$statusFont = New-Font -Size 18 -Style Bold
$statusSmallFont = New-Font -Size 15 -Style Regular

try {
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $background = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
        [System.Drawing.Rectangle]::new(0, 0, 2048, 1440),
        (Get-Color '#07111F'),
        (Get-Color '#0B1B2B'),
        25.0)
    $headerLinePen = [System.Drawing.Pen]::new((Get-Color '#1B3E56'), 2)
    $titleBrush = [System.Drawing.SolidBrush]::new((Get-Color '#F4FAFF'))
    $subtitleBrush = [System.Drawing.SolidBrush]::new((Get-Color '#8EA5BA'))
    try {
        $graphics.FillRectangle($background, 0, 0, 2048, 1440)
        $graphics.DrawLine($headerLinePen, 42, 105, 2006, 105)
        Draw-Text -Graphics $graphics -Text 'LUNA / 2D TO 3D TRANSLATION' -Font $titleFont -Brush $titleBrush `
            -Rectangle ([System.Drawing.RectangleF]::new(48, 24, 810, 52))
        Draw-Text -Graphics $graphics -Text 'REVIEW v004 / height-normalized proportion and implementation handoff' `
            -Font $subtitleFont -Brush $subtitleBrush `
            -Rectangle ([System.Drawing.RectangleF]::new(50, 75, 850, 26))

        Draw-Chip -Graphics $graphics -Text '2D 7.09H  /  PASS' `
            -Rectangle ([System.Drawing.RectangleF]::new(1035, 33, 245, 48)) `
            -Fill ([System.Drawing.Color]::FromArgb(52, 16, 140, 170)) -Stroke (Get-Color '#3CE4EF') `
            -TextColor (Get-Color '#DFFFFF') -Font $chipFont
        Draw-Chip -Graphics $graphics -Text '3D 5.39H  /  PASS' `
            -Rectangle ([System.Drawing.RectangleF]::new(1295, 33, 245, 48)) `
            -Fill ([System.Drawing.Color]::FromArgb(52, 201, 136, 49)) -Stroke (Get-Color '#F7B95A') `
            -TextColor (Get-Color '#FFF0D4') -Font $chipFont
        Draw-Chip -Graphics $graphics -Text 'APPROVAL  /  PENDING' `
            -Rectangle ([System.Drawing.RectangleF]::new(1555, 33, 430, 48)) `
            -Fill ([System.Drawing.Color]::FromArgb(42, 114, 86, 136)) -Stroke (Get-Color '#9D7EC9') `
            -TextColor (Get-Color '#E9DBFF') -Font $chipFont

        $targetCrownY = 285.0
        $targetSoleY = 1085.0
        Draw-FigurePanel -Graphics $graphics -Image $keyArt `
            -Panel ([System.Drawing.RectangleF]::new(44, 126, 604, 1042)) `
            -Label '2D KEY ART' -SubLabel '7.09H / adult feminine silhouette / detail source' `
            -SourceCrownY 116 -SourceChinY 339 -SourceSoleY 1698 `
            -TargetCrownY $targetCrownY -TargetSoleY $targetSoleY -Accent (Get-Color '#3CE4EF') `
            -LabelFont $panelLabelFont -SmallFont $smallFont -GuideFont $guideFont
        Draw-FigurePanel -Graphics $graphics -Image $reference3D `
            -Panel ([System.Drawing.RectangleF]::new(670, 126, 604, 1042)) `
            -Label '3D CHARACTER PROOF' -SubLabel '5.39H / stylized volume / quarter-view priority' `
            -SourceCrownY 153 -SourceChinY 392 -SourceSoleY 1442 `
            -TargetCrownY $targetCrownY -TargetSoleY $targetSoleY -Accent (Get-Color '#F7B95A') `
            -LabelFont $panelLabelFont -SmallFont $smallFont -GuideFont $guideFont

        Draw-SectionCard -Graphics $graphics -Title 'IDENTITY LOCK' `
            -Lines @('mint-silver asymmetric wolf bob', 'mechanical sensor hood + two cyan eyes', 'cream / charcoal / cyan scout palette') `
            -Rectangle ([System.Drawing.RectangleF]::new(1302, 126, 702, 156)) -Accent (Get-Color '#3CE4EF') `
            -TitleFont $sectionTitleFont -BodyFont $sectionBodyFont -TextColor (Get-Color '#F4FAFF') -MutedColor (Get-Color '#B5C7D8')
        Draw-SectionCard -Graphics $graphics -Title 'EXPAND' `
            -Lines @('head, hands and boots for gameplay read', 'sensor / scanner cyan response', 'hip-thigh volume for stable 5.39H mass') `
            -Rectangle ([System.Drawing.RectangleF]::new(1302, 296, 702, 156)) -Accent (Get-Color '#49D49D') `
            -TitleFont $sectionTitleFont -BodyFont $sectionBodyFont -TextColor (Get-Color '#F4FAFF') -MutedColor (Get-Color '#B5C7D8')
        Draw-SectionCard -Graphics $graphics -Title 'DELETE' `
            -Lines @('micro seam noise and tiny hardware', '2D long-leg fashion exaggeration', 'unsupported secondary cloth layers') `
            -Rectangle ([System.Drawing.RectangleF]::new(1302, 466, 702, 156)) -Accent (Get-Color '#F07F86') `
            -TitleFont $sectionTitleFont -BodyFont $sectionBodyFont -TextColor (Get-Color '#F4FAFF') -MutedColor (Get-Color '#B5C7D8')
        Draw-SectionCard -Graphics $graphics -Title 'COMBINE' `
            -Lines @('hood shell + sensor frame as one read', 'compact pack + single probe cable root', 'one asymmetrical panel physics layer') `
            -Rectangle ([System.Drawing.RectangleF]::new(1302, 636, 702, 156)) -Accent (Get-Color '#9D7EC9') `
            -TitleFont $sectionTitleFont -BodyFont $sectionBodyFont -TextColor (Get-Color '#F4FAFF') -MutedColor (Get-Color '#B5C7D8')
        Draw-SectionCard -Graphics $graphics -Title 'PHYSICS / MOTION' `
            -Lines @('simulate hair tips, probe cable and panel only', 'clamp swing; protect legs, daggers and pack', 'keep face, sensor ears and twin daggers readable') `
            -Rectangle ([System.Drawing.RectangleF]::new(1302, 806, 702, 156)) -Accent (Get-Color '#F7B95A') `
            -TitleFont $sectionTitleFont -BodyFont $sectionBodyFont -TextColor (Get-Color '#F4FAFF') -MutedColor (Get-Color '#B5C7D8')
        Draw-SectionCard -Graphics $graphics -Title 'NEXT MODEL GATE' `
            -Lines @('front + rear + gameplay quarter views', 'Humanoid joints and socket proof', 'Mesh / ART-2001 budget: still pending') `
            -Rectangle ([System.Drawing.RectangleF]::new(1302, 976, 702, 192)) -Accent (Get-Color '#6B8DA8') `
            -TitleFont $sectionTitleFont -BodyFont $sectionBodyFont -TextColor (Get-Color '#F4FAFF') -MutedColor (Get-Color '#B5C7D8')

        $statusRect = [System.Drawing.RectangleF]::new(44, 1194, 1960, 196)
        $statusBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(244, 8, 18, 31))
        $statusPen = [System.Drawing.Pen]::new((Get-Color '#28445C'), 1.5)
        $statusTitleBrush = [System.Drawing.SolidBrush]::new((Get-Color '#F4FAFF'))
        $statusBodyBrush = [System.Drawing.SolidBrush]::new((Get-Color '#AFC1D2'))
        $pendingBrush = [System.Drawing.SolidBrush]::new((Get-Color '#F7B95A'))
        try {
            Fill-RoundedRectangle -Graphics $graphics -Brush $statusBrush -Rectangle $statusRect -Radius 20
            Draw-RoundedRectangle -Graphics $graphics -Pen $statusPen -Rectangle $statusRect -Radius 20
            Draw-Text -Graphics $graphics -Text 'PROPORTION GATE' -Font $statusFont -Brush $statusTitleBrush `
                -Rectangle ([System.Drawing.RectangleF]::new(70, 1218, 250, 31))
            Draw-Text -Graphics $graphics -Text 'Crown-to-sole height is normalized on this board. Sensor-ear tips are excluded from head count.' `
                -Font $statusSmallFont -Brush $statusBodyBrush `
                -Rectangle ([System.Drawing.RectangleF]::new(70, 1255, 790, 52))
            Draw-Text -Graphics $graphics -Text '2D  7.09H' -Font $statusFont -Brush $statusTitleBrush `
                -Rectangle ([System.Drawing.RectangleF]::new(900, 1222, 180, 30))
            Draw-Text -Graphics $graphics -Text 'crown 116 / chin 339 / sole 1698' -Font $statusSmallFont -Brush $statusBodyBrush `
                -Rectangle ([System.Drawing.RectangleF]::new(900, 1260, 360, 28))
            Draw-Text -Graphics $graphics -Text '3D  5.39H' -Font $statusFont -Brush $statusTitleBrush `
                -Rectangle ([System.Drawing.RectangleF]::new(1302, 1222, 180, 30))
            Draw-Text -Graphics $graphics -Text 'crown 153 / chin 392 / sole 1442' -Font $statusSmallFont -Brush $statusBodyBrush `
                -Rectangle ([System.Drawing.RectangleF]::new(1302, 1260, 360, 28))
            Draw-Text -Graphics $graphics -Text 'REVIEW ONLY / HUMAN APPROVAL NOT GRANTED' -Font $statusFont -Brush $pendingBrush `
                -Rectangle ([System.Drawing.RectangleF]::new(900, 1320, 760, 32))
        }
        finally {
            $statusBrush.Dispose()
            $statusPen.Dispose()
            $statusTitleBrush.Dispose()
            $statusBodyBrush.Dispose()
            $pendingBrush.Dispose()
        }
    }
    finally {
        $background.Dispose()
        $headerLinePen.Dispose()
        $titleBrush.Dispose()
        $subtitleBrush.Dispose()
    }

    $canvas.Save($resolvedOutput, [System.Drawing.Imaging.ImageFormat]::Png)
    Write-Output "Created $resolvedOutput (2048x1440)"
}
finally {
    $titleFont.Dispose()
    $subtitleFont.Dispose()
    $panelLabelFont.Dispose()
    $smallFont.Dispose()
    $chipFont.Dispose()
    $guideFont.Dispose()
    $sectionTitleFont.Dispose()
    $sectionBodyFont.Dispose()
    $statusFont.Dispose()
    $statusSmallFont.Dispose()
    $keyArt.Dispose()
    $reference3D.Dispose()
    $graphics.Dispose()
    $canvas.Dispose()
}
