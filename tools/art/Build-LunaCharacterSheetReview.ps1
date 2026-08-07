[CmdletBinding()]
param(
    [string]$ProjectRoot,
    [string]$KeyArtPath = 'art_refs/characters/luna/concept/Luna_KeyArt_REVIEW_v001.png',
    [string]$TurnaroundPath = 'art_refs/characters/luna/turnaround/Luna_Turnaround_REVIEW_v003.png',
    [string]$ExpressionPath = 'art_refs/characters/luna/expressions/Luna_ExpressionSheet_REVIEW_v001.png',
    [string]$EquipmentPath = 'art_refs/characters/luna/equipment/Luna_EquipmentSheet_REVIEW_v001.png',
    [string]$PalettePath = 'art_refs/characters/luna/concept/Luna_MaterialPalette_REVIEW_v001.png',
    [string]$TranslationPath = 'art_refs/characters/luna/3d_reference/Luna_2DTo3DTranslation_REVIEW_v004.png',
    [string]$Face128Path = 'art_refs/characters/luna/concept/Luna_Face128_REVIEW_v002.png',
    [string]$SilhouettePath = 'art_refs/characters/luna/concept/Luna_SilhouetteTest_REVIEW_v002.png',
    [string]$OutputPath = 'art_refs/characters/luna/Luna_CharacterSheet_REVIEW_v001.png',
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

function Resolve-ProjectInput {
    param([Parameter(Mandatory = $true)][string]$Path)

    $candidate = if ([System.IO.Path]::IsPathRooted($Path)) { $Path } else { Join-Path $ProjectRoot $Path }
    return (Resolve-Path -LiteralPath $candidate -ErrorAction Stop).Path
}

function Resolve-ProjectOutput {
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

function Initialize-Graphics {
    param([Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics)

    $Graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $Graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $Graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $Graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
}

function Draw-ImageFit {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)][System.Drawing.Image]$Image,
        [Parameter(Mandatory = $true)][System.Drawing.RectangleF]$Bounds
    )

    $scale = [Math]::Min($Bounds.Width / $Image.Width, $Bounds.Height / $Image.Height)
    $width = $Image.Width * $scale
    $height = $Image.Height * $scale
    $x = $Bounds.X + (($Bounds.Width - $width) / 2.0)
    $y = $Bounds.Y + (($Bounds.Height - $height) / 2.0)
    $Graphics.DrawImage($Image, [System.Drawing.RectangleF]::new($x, $y, $width, $height))
}

function Draw-SourceFrame {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)][System.Drawing.Image]$Image,
        [Parameter(Mandatory = $true)][System.Drawing.Rectangle]$Bounds,
        [Parameter(Mandatory = $true)][string]$Title,
        [Parameter(Mandatory = $true)][string]$Subtitle,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$Accent
    )

    $panelBrush = [System.Drawing.SolidBrush]::new((Get-Color '#0E1929'))
    $imageBrush = [System.Drawing.SolidBrush]::new((Get-Color '#08111F'))
    $accentBrush = [System.Drawing.SolidBrush]::new($Accent)
    $titleBrush = [System.Drawing.SolidBrush]::new((Get-Color '#F8FAFC'))
    $mutedBrush = [System.Drawing.SolidBrush]::new((Get-Color '#93A4BA'))
    $borderPen = [System.Drawing.Pen]::new((Get-Color '#2A3B51'), 3.0)
    try {
        $Graphics.FillRectangle($panelBrush, $Bounds)
        $Graphics.DrawRectangle($borderPen, $Bounds)
        $Graphics.FillRectangle($accentBrush, $Bounds.X, $Bounds.Y, 10, 78)
        $Graphics.DrawString($Title, $script:FrameTitleFont, $titleBrush, $Bounds.X + 30, $Bounds.Y + 14)
        $Graphics.DrawString($Subtitle, $script:FrameSubtitleFont, $mutedBrush, $Bounds.X + 31, $Bounds.Y + 51)

        $inner = [System.Drawing.RectangleF]::new(
            $Bounds.X + 18,
            $Bounds.Y + 92,
            $Bounds.Width - 36,
            $Bounds.Height - 110)
        $Graphics.FillRectangle($imageBrush, $inner)
        Draw-ImageFit -Graphics $Graphics -Image $Image -Bounds ([System.Drawing.RectangleF]::new(
            $inner.X + 10,
            $inner.Y + 10,
            $inner.Width - 20,
            $inner.Height - 20))
    }
    finally {
        $borderPen.Dispose(); $mutedBrush.Dispose(); $titleBrush.Dispose(); $accentBrush.Dispose(); $imageBrush.Dispose(); $panelBrush.Dispose()
    }
}

function Get-StatusColor {
    param([Parameter(Mandatory = $true)][string]$Kind)

    switch ($Kind) {
        'pass' { return Get-Color '#61E6A5' }
        'auto' { return Get-Color '#35E7FF' }
        'pending' { return Get-Color '#F7B955' }
        'partial' { return Get-Color '#A78BFA' }
        'not-tested' { return Get-Color '#FF8EA3' }
        default { return Get-Color '#CBD5E1' }
    }
}

function Draw-PrecheckTable {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)][System.Drawing.Rectangle]$Bounds,
        [Parameter(Mandatory = $true)][string]$Title,
        [Parameter(Mandatory = $true)][object[]]$Rows,
        [Parameter(Mandatory = $true)][int]$RowHeight,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$Accent
    )

    $panelBrush = [System.Drawing.SolidBrush]::new((Get-Color '#0E1929'))
    $headerBrush = [System.Drawing.SolidBrush]::new((Get-Color '#15243A'))
    $alternateBrush = [System.Drawing.SolidBrush]::new((Get-Color '#111E30'))
    $titleBrush = [System.Drawing.SolidBrush]::new((Get-Color '#F8FAFC'))
    $mutedBrush = [System.Drawing.SolidBrush]::new((Get-Color '#A7B5C7'))
    $accentBrush = [System.Drawing.SolidBrush]::new($Accent)
    $borderPen = [System.Drawing.Pen]::new((Get-Color '#2A3B51'), 2.0)
    $gridPen = [System.Drawing.Pen]::new((Get-Color '#26374C'), 1.0)
    $format = [System.Drawing.StringFormat]::new()
    $format.LineAlignment = [System.Drawing.StringAlignment]::Center
    $format.Trimming = [System.Drawing.StringTrimming]::EllipsisCharacter
    $format.FormatFlags = [System.Drawing.StringFormatFlags]::NoWrap

    try {
        $Graphics.FillRectangle($panelBrush, $Bounds)
        $Graphics.DrawRectangle($borderPen, $Bounds)
        $Graphics.FillRectangle($accentBrush, $Bounds.X, $Bounds.Y, 10, 66)
        $Graphics.DrawString($Title, $script:TableTitleFont, $titleBrush, $Bounds.X + 30, $Bounds.Y + 15)

        $headerY = $Bounds.Y + 68
        $Graphics.FillRectangle($headerBrush, $Bounds.X + 2, $headerY, $Bounds.Width - 4, 44)
        $Graphics.DrawString('ID', $script:TableHeaderFont, $mutedBrush, [System.Drawing.RectangleF]::new($Bounds.X + 20, $headerY, 180, 44), $format)
        $Graphics.DrawString('PRECHECK', $script:TableHeaderFont, $mutedBrush, [System.Drawing.RectangleF]::new($Bounds.X + 220, $headerY, 930, 44), $format)
        $Graphics.DrawString('STATE', $script:TableHeaderFont, $mutedBrush, [System.Drawing.RectangleF]::new($Bounds.X + 1190, $headerY, $Bounds.Width - 1210, 44), $format)

        $rowY = $headerY + 44
        for ($i = 0; $i -lt $Rows.Count; $i++) {
            $row = $Rows[$i]
            if (($i % 2) -eq 1) {
                $Graphics.FillRectangle($alternateBrush, $Bounds.X + 2, $rowY, $Bounds.Width - 4, $RowHeight)
            }
            $Graphics.DrawLine($gridPen, $Bounds.X + 2, $rowY + $RowHeight, $Bounds.Right - 2, $rowY + $RowHeight)

            $statusBrush = [System.Drawing.SolidBrush]::new((Get-StatusColor $row.Kind))
            try {
                $Graphics.DrawString($row.Id, $script:TableIdFont, $titleBrush, [System.Drawing.RectangleF]::new($Bounds.X + 20, $rowY, 180, $RowHeight), $format)
                $Graphics.DrawString($row.Check, $script:TableBodyFont, $titleBrush, [System.Drawing.RectangleF]::new($Bounds.X + 220, $rowY, 930, $RowHeight), $format)
                $Graphics.DrawString($row.State, $script:TableStatusFont, $statusBrush, [System.Drawing.RectangleF]::new($Bounds.X + 1190, $rowY, $Bounds.Width - 1210, $RowHeight), $format)
            }
            finally { $statusBrush.Dispose() }
            $rowY += $RowHeight
        }
    }
    finally {
        $format.Dispose(); $gridPen.Dispose(); $borderPen.Dispose(); $accentBrush.Dispose(); $mutedBrush.Dispose(); $titleBrush.Dispose(); $alternateBrush.Dispose(); $headerBrush.Dispose(); $panelBrush.Dispose()
    }
}

function Draw-Badge {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)][System.Drawing.Rectangle]$Bounds,
        [Parameter(Mandatory = $true)][string]$Label,
        [Parameter(Mandatory = $true)][string]$Value,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$Accent
    )

    $panelBrush = [System.Drawing.SolidBrush]::new((Get-Color '#132238'))
    $labelBrush = [System.Drawing.SolidBrush]::new((Get-Color '#93A4BA'))
    $valueBrush = [System.Drawing.SolidBrush]::new($Accent)
    $borderPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(180, $Accent), 2.0)
    try {
        $Graphics.FillRectangle($panelBrush, $Bounds)
        $Graphics.DrawRectangle($borderPen, $Bounds)
        $Graphics.DrawString($Label, $script:BadgeLabelFont, $labelBrush, $Bounds.X + 20, $Bounds.Y + 13)
        $Graphics.DrawString($Value, $script:BadgeValueFont, $valueBrush, $Bounds.X + 20, $Bounds.Y + 43)
    }
    finally { $borderPen.Dispose(); $valueBrush.Dispose(); $labelBrush.Dispose(); $panelBrush.Dispose() }
}

$resolvedInputs = [ordered]@{
    KeyArt = Resolve-ProjectInput $KeyArtPath
    Turnaround = Resolve-ProjectInput $TurnaroundPath
    Expressions = Resolve-ProjectInput $ExpressionPath
    Equipment = Resolve-ProjectInput $EquipmentPath
    Palette = Resolve-ProjectInput $PalettePath
    Translation = Resolve-ProjectInput $TranslationPath
    Face128 = Resolve-ProjectInput $Face128Path
    Silhouette = Resolve-ProjectInput $SilhouettePath
}
$resolvedOutput = Resolve-ProjectOutput $OutputPath

$images = [ordered]@{}
foreach ($entry in $resolvedInputs.GetEnumerator()) {
    $images[$entry.Key] = [System.Drawing.Bitmap]::FromFile($entry.Value)
}

$expectedDimensions = [ordered]@{
    KeyArt = @(866, 1817)
    Turnaround = @(1672, 941)
    Expressions = @(1717, 916)
    Equipment = @(1536, 1024)
    Palette = @(1600, 1050)
    Translation = @(2048, 1440)
    Face128 = @(128, 128)
    Silhouette = @(1600, 960)
}

$canvas = $null
$graphics = $null
$disposables = [System.Collections.Generic.List[System.IDisposable]]::new()

try {
    foreach ($entry in $expectedDimensions.GetEnumerator()) {
        $image = $images[$entry.Key]
        $expectedWidth = $entry.Value[0]
        $expectedHeight = $entry.Value[1]
        if ($image.Width -ne $expectedWidth -or $image.Height -ne $expectedHeight) {
            throw "$($entry.Key) dimensions changed: expected ${expectedWidth}x${expectedHeight}, got $($image.Width)x$($image.Height). Recheck the deterministic layout."
        }
    }

    $canvas = [System.Drawing.Bitmap]::new(4096, 4608, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($canvas)
    Initialize-Graphics -Graphics $graphics

    $script:HeaderFont = New-Font 54 ([System.Drawing.FontStyle]::Bold)
    $script:HeaderSubFont = New-Font 24
    $script:SummaryTitleFont = New-Font 25 ([System.Drawing.FontStyle]::Bold)
    $script:SummaryBodyFont = New-Font 22
    $script:FrameTitleFont = New-Font 27 ([System.Drawing.FontStyle]::Bold)
    $script:FrameSubtitleFont = New-Font 18
    $script:TableTitleFont = New-Font 28 ([System.Drawing.FontStyle]::Bold)
    $script:TableHeaderFont = New-Font 17 ([System.Drawing.FontStyle]::Bold)
    $script:TableIdFont = New-Font 18 ([System.Drawing.FontStyle]::Bold)
    $script:TableBodyFont = New-Font 18
    $script:TableStatusFont = New-Font 17 ([System.Drawing.FontStyle]::Bold)
    $script:BadgeLabelFont = New-Font 17 ([System.Drawing.FontStyle]::Bold)
    $script:BadgeValueFont = New-Font 22 ([System.Drawing.FontStyle]::Bold)
    $script:EvidenceTitleFont = New-Font 24 ([System.Drawing.FontStyle]::Bold)
    $script:FooterFont = New-Font 20 ([System.Drawing.FontStyle]::Bold)
    foreach ($fontName in @('HeaderFont','HeaderSubFont','SummaryTitleFont','SummaryBodyFont','FrameTitleFont','FrameSubtitleFont','TableTitleFont','TableHeaderFont','TableIdFont','TableBodyFont','TableStatusFont','BadgeLabelFont','BadgeValueFont','EvidenceTitleFont','FooterFont')) {
        $disposables.Add((Get-Variable -Scope Script -Name $fontName -ValueOnly))
    }

    $backgroundBrush = [System.Drawing.SolidBrush]::new((Get-Color '#07111F'))
    $titleBrush = [System.Drawing.SolidBrush]::new((Get-Color '#F8FAFC'))
    $mutedBrush = [System.Drawing.SolidBrush]::new((Get-Color '#93A4BA'))
    $cyanBrush = [System.Drawing.SolidBrush]::new((Get-Color '#35E7FF'))
    $amberBrush = [System.Drawing.SolidBrush]::new((Get-Color '#F7B955'))
    $panelBrush = [System.Drawing.SolidBrush]::new((Get-Color '#0E1929'))
    $borderPen = [System.Drawing.Pen]::new((Get-Color '#2A3B51'), 3.0)
    $cyanPen = [System.Drawing.Pen]::new((Get-Color '#35E7FF'), 3.0)
    foreach ($item in @($backgroundBrush,$titleBrush,$mutedBrush,$cyanBrush,$amberBrush,$panelBrush,$borderPen,$cyanPen)) { $disposables.Add($item) }

    $graphics.FillRectangle($backgroundBrush, 0, 0, $canvas.Width, $canvas.Height)
    $graphics.DrawString('LUNA / INTEGRATED CHARACTER PRODUCTION SHEET', $script:HeaderFont, $titleBrush, 48, 28)
    $graphics.DrawString(
        'REVIEW v001 | selected 2D identity, production views, equipment, materials, and 2D -> 3D handoff',
        $script:HeaderSubFont,
        $mutedBrush,
        51,
        96)
    $graphics.DrawString('REVIEW ONLY / HUMAN APPROVAL NOT GRANTED', $script:SummaryTitleFont, $amberBrush, 3290, 52)
    $graphics.DrawLine($cyanPen, 48, 145, 4048, 145)

    $summaryRect = [System.Drawing.Rectangle]::new(48, 175, 4000, 310)
    $graphics.FillRectangle($panelBrush, $summaryRect)
    $graphics.DrawRectangle($borderPen, $summaryRect)
    $graphics.DrawString('IDENTITY LOCK', $script:SummaryTitleFont, $cyanBrush, 82, 204)
    $graphics.DrawString(
        'HOOK  | Sensor-cat scout of urban ruins with paired energy daggers',
        $script:SummaryBodyFont,
        $titleBrush,
        82,
        247)
    $graphics.DrawString(
        'ROLE  | Scout melee DPS / adult woman / slim athletic / playful off-duty, decisive on mission',
        $script:SummaryBodyFont,
        $titleBrush,
        82,
        287)
    $graphics.DrawString(
        'LOCK  | mint-silver asymmetric bob / mechanical sensor hood / cream-charcoal-cyan scout palette',
        $script:SummaryBodyFont,
        $titleBrush,
        82,
        327)
    $graphics.DrawString(
        'SCOPE | 2D target 6.90-7.10H: measured 7.09H PASS / 3D target 5.30-5.40H: concept 5.39H PRECHECK PASS',
        $script:SummaryBodyFont,
        $cyanBrush,
        82,
        377)
    $graphics.DrawString(
        'Primary: sensor ears + paired daggers   Secondary: wrist scanner + compact probe backpack/cable',
        $script:SummaryBodyFont,
        $mutedBrush,
        82,
        422)

    $frameWidth = 1312
    $frameHeight = 900
    $frameXs = @(48, 1392, 2736)
    $row1Y = 520
    $row2Y = 1450
    Draw-SourceFrame -Graphics $graphics -Image $images.KeyArt -Bounds ([System.Drawing.Rectangle]::new($frameXs[0],$row1Y,$frameWidth,$frameHeight)) -Title '01 / KEY ART / 2D 7.09H' -Subtitle 'Adult feminine silhouette + final detail source' -Accent (Get-Color '#35E7FF')
    Draw-SourceFrame -Graphics $graphics -Image $images.Turnaround -Bounds ([System.Drawing.Rectangle]::new($frameXs[1],$row1Y,$frameWidth,$frameHeight)) -Title '02 / TURNAROUND / v003' -Subtitle 'Hood-on front + side + rear consistency precheck' -Accent (Get-Color '#61E6A5')
    Draw-SourceFrame -Graphics $graphics -Image $images.Expressions -Bounds ([System.Drawing.Rectangle]::new($frameXs[2],$row1Y,$frameWidth,$frameHeight)) -Title '03 / EXPRESSIONS / 8-UP' -Subtitle 'Friendly, alert, focused, and vulnerable range' -Accent (Get-Color '#A78BFA')
    Draw-SourceFrame -Graphics $graphics -Image $images.Equipment -Bounds ([System.Drawing.Rectangle]::new($frameXs[0],$row2Y,$frameWidth,$frameHeight)) -Title '04 / EQUIPMENT STRUCTURE' -Subtitle 'Sensor hood + daggers + scanner + pack/cable' -Accent (Get-Color '#F7B955')
    Draw-SourceFrame -Graphics $graphics -Image $images.Palette -Bounds ([System.Drawing.Rectangle]::new($frameXs[1],$row2Y,$frameWidth,$frameHeight)) -Title '05 / MATERIAL PALETTE' -Subtitle 'Exact sRGB slots + grayscale value row' -Accent (Get-Color '#FF4F7B')
    Draw-SourceFrame -Graphics $graphics -Image $images.Translation -Bounds ([System.Drawing.Rectangle]::new($frameXs[2],$row2Y,$frameWidth,$frameHeight)) -Title '06 / 2D -> 3D TRANSLATION' -Subtitle 'Expand / delete / combine / physics notes' -Accent (Get-Color '#F7B955')

    $evidenceY = 2380
    $evidenceHeight = 680
    $facePanel = [System.Drawing.Rectangle]::new(48,$evidenceY,520,$evidenceHeight)
    $silhouettePanel = [System.Drawing.Rectangle]::new(600,$evidenceY,1500,$evidenceHeight)
    $summaryPanel = [System.Drawing.Rectangle]::new(2132,$evidenceY,1916,$evidenceHeight)
    foreach ($rect in @($facePanel,$silhouettePanel,$summaryPanel)) {
        $graphics.FillRectangle($panelBrush, $rect)
        $graphics.DrawRectangle($borderPen, $rect)
    }
    $graphics.DrawString('128px FACE EVIDENCE', $script:EvidenceTitleFont, $titleBrush, 76, $evidenceY + 24)
    $graphics.DrawString('Exact source: 128 x 128', $script:FrameSubtitleFont, $mutedBrush, 78, $evidenceY + 62)
    $oldInterpolation = $graphics.InterpolationMode
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::Half
    $graphics.DrawImage($images.Face128, [System.Drawing.Rectangle]::new(92,$evidenceY + 125,432,432))
    $graphics.InterpolationMode = $oldInterpolation
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $graphics.DrawString('Single-character read only', $script:FrameSubtitleFont, $amberBrush, 132, $evidenceY + 590)

    $graphics.DrawString('HEIGHT-NORMALIZED SILHOUETTE EVIDENCE', $script:EvidenceTitleFont, $titleBrush, 628, $evidenceY + 24)
    $graphics.DrawString('Equipment included vs gear minimal', $script:FrameSubtitleFont, $mutedBrush, 630, $evidenceY + 62)
    Draw-ImageFit -Graphics $graphics -Image $images.Silhouette -Bounds ([System.Drawing.RectangleF]::new(620,$evidenceY + 105,1460,535))

    $graphics.DrawString('EVIDENCE SUMMARY', $script:EvidenceTitleFont, $titleBrush, 2164, $evidenceY + 24)
    Draw-Badge -Graphics $graphics -Bounds ([System.Drawing.Rectangle]::new(2164,$evidenceY + 86,890,104)) -Label '2D PROPORTION / LOCKED 6.90-7.10H' -Value '7.09H / AUTO PASS' -Accent (Get-Color '#35E7FF')
    Draw-Badge -Graphics $graphics -Bounds ([System.Drawing.Rectangle]::new(3090,$evidenceY + 86,926,104)) -Label '3D CONCEPT / LOCKED 5.30-5.40H' -Value '5.39H / CONCEPT PRECHECK' -Accent (Get-Color '#F7B955')
    Draw-Badge -Graphics $graphics -Bounds ([System.Drawing.Rectangle]::new(2164,$evidenceY + 220,890,104)) -Label 'FACE / SOURCE SIZE' -Value '128 x 128 / PRESENT' -Accent (Get-Color '#61E6A5')
    Draw-Badge -Graphics $graphics -Bounds ([System.Drawing.Rectangle]::new(3090,$evidenceY + 220,926,104)) -Label 'SILHOUETTE / NORMALIZATION' -Value 'SAME CROWN-TO-SOLE' -Accent (Get-Color '#61E6A5')
    Draw-Badge -Graphics $graphics -Bounds ([System.Drawing.Rectangle]::new(2164,$evidenceY + 354,890,104)) -Label 'HUMAN APPEAL + FINAL ART' -Value 'PENDING' -Accent (Get-Color '#F7B955')
    Draw-Badge -Graphics $graphics -Bounds ([System.Drawing.Rectangle]::new(3090,$evidenceY + 354,926,104)) -Label 'BLENDER / UNITY CHARACTER PROOF' -Value 'NOT TESTED' -Accent (Get-Color '#FF8EA3')
    $graphics.DrawString(
        'PRECHECK is evidence readiness only. It is not Gate A/B approval.',
        $script:SummaryBodyFont,
        $amberBrush,
        2166,
        $evidenceY + 500)
    $graphics.DrawString(
        '5-character cross-review remains Pending; rig, joints, camera, sockets, and pose proof remain Not Tested.',
        $script:FrameSubtitleFont,
        $mutedBrush,
        2167,
        $evidenceY + 548)

    $gateARows = @(
        [pscustomobject]@{ Id='CHA-A01'; Check='Adult-woman read / no childlike regression'; State='PRECHECK PASS'; Kind='pass' },
        [pscustomobject]@{ Id='CHA-A02'; Check='2D character target 6.90-7.10H'; State='AUTO PASS / 7.09H'; Kind='auto' },
        [pscustomobject]@{ Id='CHA-A03'; Check='Subculture appeal: face, body, fashion'; State='PENDING / HUMAN'; Kind='pending' },
        [pscustomobject]@{ Id='CHA-A04'; Check='One-line visual hook reads in one image'; State='PRECHECK PASS'; Kind='pass' },
        [pscustomobject]@{ Id='CHA-A05'; Check='Face, hair, body, silhouette, gear anchors'; State='PRECHECK PASS'; Kind='pass' },
        [pscustomobject]@{ Id='CHA-A06'; Check='1 primary + 2 secondary identity features'; State='PRECHECK PASS'; Kind='pass' },
        [pscustomobject]@{ Id='CHA-A07'; Check='Fashion and scout equipment function link'; State='PRECHECK PASS'; Kind='pass' },
        [pscustomobject]@{ Id='CHA-A08'; Check='Palette distinct across five characters'; State='PENDING / 5-ROSTER'; Kind='pending' },
        [pscustomobject]@{ Id='CHA-A09'; Check='Combat role reads from signature equipment'; State='PRECHECK PASS'; Kind='pass' },
        [pscustomobject]@{ Id='CHA-A10'; Check='Gear-minimal silhouette distinguishes roster'; State='PENDING / 5-ROSTER'; Kind='pending' },
        [pscustomobject]@{ Id='CHA-A11'; Check='128px face distinguishes roster'; State='PENDING / 5-ROSTER'; Kind='pending' },
        [pscustomobject]@{ Id='CHA-A12'; Check='Low-saturation + color-accessibility preview'; State='NOT TESTED'; Kind='not-tested' },
        [pscustomobject]@{ Id='CHA-A13'; Check='No collision with another character motif'; State='PENDING / 5-ROSTER'; Kind='pending' },
        [pscustomobject]@{ Id='CHA-A14'; Check='Off-duty vs mission expression contrast'; State='PRECHECK PASS'; Kind='pass' },
        [pscustomobject]@{ Id='CHA-A15'; Check='External-IP difference/originality analysis'; State='PENDING / HUMAN-IP'; Kind='pending' },
        [pscustomobject]@{ Id='CHA-A16'; Check='2D and 3D scope difference is explicit'; State='PRECHECK PASS'; Kind='pass' }
    )
    $gateBRows = @(
        [pscustomobject]@{ Id='CHA-B01'; Check='Front / side / rear design consistency'; State='PRECHECK PASS'; Kind='pass' },
        [pscustomobject]@{ Id='CHA-B02'; Check='Equipment size, grip, fold, emission structure'; State='PRECHECK PASS'; Kind='pass' },
        [pscustomobject]@{ Id='CHA-B03'; Check='Expand / delete / combine rules documented'; State='PRECHECK PASS'; Kind='pass' },
        [pscustomobject]@{ Id='CHA-B04'; Check='5.3-5.4H adult read + Humanoid joints'; State='NOT TESTED / BLENDER-UNITY'; Kind='not-tested' },
        [pscustomobject]@{ Id='CHA-B05'; Check='Major joints clear costume in pose blockout'; State='NOT TESTED / BLENDER-UNITY'; Kind='not-tested' },
        [pscustomobject]@{ Id='CHA-B06'; Check='Face, eyes, hair, outfit, gear material slots'; State='PARTIAL / SLOT PROOF'; Kind='partial' },
        [pscustomobject]@{ Id='CHA-B07'; Check='Emphasis avoids camera, rig, animation blocks'; State='NOT TESTED / BLENDER-UNITY'; Kind='not-tested' },
        [pscustomobject]@{ Id='CHA-B08'; Check='Hair, panel, cable physics risk budget'; State='PRECHECK PASS / NOTE'; Kind='pass' },
        [pscustomobject]@{ Id='CHA-B09'; Check='Idle, Attack, Skill, Victory motion + sockets'; State='PENDING / MOTION-SOCKET'; Kind='pending' }
    )

    $tableY = 3125
    $tableWidth = 1984
    Draw-PrecheckTable -Graphics $graphics -Bounds ([System.Drawing.Rectangle]::new(48,$tableY,$tableWidth,1280)) -Title 'GATE A / CHA-A01-A16 PRECHECK' -Rows $gateARows -RowHeight 72 -Accent (Get-Color '#35E7FF')
    Draw-PrecheckTable -Graphics $graphics -Bounds ([System.Drawing.Rectangle]::new(2064,$tableY,$tableWidth,790)) -Title 'GATE B / CHA-B01-B09 PRECHECK' -Rows $gateBRows -RowHeight 74 -Accent (Get-Color '#F7B955')

    $scopeRect = [System.Drawing.Rectangle]::new(2064,3940,1984,465)
    $graphics.FillRectangle($panelBrush, $scopeRect)
    $graphics.DrawRectangle($borderPen, $scopeRect)
    $graphics.DrawString('PENDING / NOT TESTED BOUNDARY', $script:TableTitleFont, $amberBrush, 2095, 3970)
    $graphics.DrawString('Human Gate A/B approval ........ PENDING', $script:SummaryBodyFont, $titleBrush, 2098, 4030)
    $graphics.DrawString('Five-character silhouette/face/palette cross-review ........ PENDING', $script:SummaryBodyFont, $titleBrush, 2098, 4075)
    $graphics.DrawString('Blender proportion, Humanoid rig + joint proof ........ NOT TESTED', $script:SummaryBodyFont, $titleBrush, 2098, 4120)
    $graphics.DrawString('Unity gameplay camera, animation + socket proof ........ NOT TESTED', $script:SummaryBodyFont, $titleBrush, 2098, 4165)
    $graphics.DrawString('Final material/shader and physics implementation ........ NOT TESTED', $script:SummaryBodyFont, $titleBrush, 2098, 4210)
    $graphics.DrawString('Board conclusion: production evidence assembled; final design approval is not granted.', $script:SummaryBodyFont, $amberBrush, 2098, 4275)

    $graphics.DrawLine($borderPen, 48, 4440, 4048, 4440)
    $graphics.DrawString(
        'REVIEW ONLY / HUMAN APPROVAL NOT GRANTED',
        $script:FooterFont,
        $amberBrush,
        48,
        4470)
    $graphics.DrawString(
        'Deterministic composite: tools/art/Build-LunaCharacterSheetReview.ps1 | sources remain independently reviewable',
        $script:FooterFont,
        $mutedBrush,
        1750,
        4470)

    $outputDirectory = Split-Path -Parent $resolvedOutput
    if (-not [System.IO.Directory]::Exists($outputDirectory)) {
        [System.IO.Directory]::CreateDirectory($outputDirectory) | Out-Null
    }
    if ([System.IO.File]::Exists($resolvedOutput) -and -not $Force) {
        throw "Output already exists: $resolvedOutput. Use -Force for a deterministic rebuild."
    }
    $canvas.Save($resolvedOutput, [System.Drawing.Imaging.ImageFormat]::Png)

    [pscustomobject]@{
        Output = $resolvedOutput
        Dimensions = '4096x4608'
        Frames = 6
        EvidencePanels = 3
        GateARows = $gateARows.Count
        GateBRows = $gateBRows.Count
        Status = 'REVIEW ONLY'
        HumanApproval = 'NOT GRANTED'
    }
}
finally {
    if ($graphics) { $graphics.Dispose() }
    if ($canvas) { $canvas.Dispose() }
    foreach ($item in $disposables) { if ($item) { $item.Dispose() } }
    foreach ($image in $images.Values) { if ($image) { $image.Dispose() } }
}
