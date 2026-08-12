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

function Save-Canvas([Drawing.Bitmap]$Canvas, [string]$Path) {
    if ([IO.File]::Exists($Path) -and -not $Force) {
        throw "Output exists: $Path. Use -Force to overwrite deterministic outputs."
    }
    [IO.Directory]::CreateDirectory((Split-Path -Parent $Path)) | Out-Null
    $Canvas.Save($Path, [Drawing.Imaging.ImageFormat]::Png)
}

$characters = @(
    [pscustomobject]@{
        Id='CH101'; Name='RIN'; Role='Signal Runner'; Hook='Cyan signal ribbon / single saber / fast scout';
        Palette='Pearl white / charcoal / cyan'; Ratio2D='6.9-7.1H'; Ratio3D='5.3-5.4H'; Accent='#35D8E4'; Status='2D APPROVED';
        Sheet='art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_APPROVED_v001.png'; Contract='art_source/manifests/CH101_Rin_Production_Sheet_Approval_20260811.md'
    },
    [pscustomobject]@{
        Id='CH102'; Name='MAO'; Role='Salvage Architect'; Hook='Silver-lavender hair / one folding mechanical bow';
        Palette='Graphite / violet / acid lemon'; Ratio2D='6.8-7.0H'; Ratio3D='5.2-5.3H'; Accent='#A989F0'; Status='2D APPROVED';
        Sheet='art_refs/characters/mao/concept/CH102_Mao_CharacterSheet_APPROVED_v001.png'; Contract='art_source/manifests/CH102_Mao_Production_Sheet_Approval_20260811.md'
    },
    [pscustomobject]@{
        Id='CH103'; Name='NOZOMI'; Role='Resonance Medic'; Hook='Coral braid / orb baton / controlled rescue veil';
        Palette='Coral rose / ivory / aqua mint'; Ratio2D='7.0-7.2H'; Ratio3D='5.5-5.6H'; Accent='#F08A79'; Status='2D APPROVED';
        Sheet='art_refs/characters/nozomi/concept/CH103_Nozomi_CharacterSheet_APPROVED_v001.png'; Contract='art_source/manifests/CH103_Nozomi_Production_Sheet_Approval_20260811.md'
    },
    [pscustomobject]@{
        Id='CH104'; Name='SHION'; Role='Orbit Cartographer'; Hook='Indigo vertical read / prism fan / one map ring';
        Palette='Porcelain ivory / deep indigo / magenta'; Ratio2D='7.1-7.3H'; Ratio3D='5.6-5.7H'; Accent='#AF8BE9'; Status='2D APPROVED';
        Sheet='art_refs/characters/shion/concept/CH104_Shion_CharacterSheet_APPROVED_v001.png'; Contract='art_source/manifests/CH104_Shion_Production_Sheet_Approval_20260812.md'
    },
    [pscustomobject]@{
        Id='CH105'; Name='AKARI'; Role='Anchor Warden'; Hook='Black/teal hair / gauntlet pair / one anchor ring';
        Palette='Deep black / forest green / copper gold'; Ratio2D='7.2-7.4H'; Ratio3D='5.7-5.8H'; Accent='#D39A42'; Status='GATE A PENDING';
        Sheet='art_refs/characters/akari/concept/CH105_Akari_CharacterSheet_REVIEW_v001.png'; Contract='art_source/manifests/CH105_Akari_GateA_Review_Request_20260812.md'
    }
)

$sourcePath = 'art_refs/characters/roster/current/CH101-105_Roster_FaceDiversity_WIP_v003.png'
$outputPath = Join-Path (Resolve-OutputPath $OutputDirectory) 'ReCamp_CurrentRoster_ART-1504_FinalComparison_REVIEW_20260812.png'
$images = @()
$fonts = @{}
$brushes = @()
$pens = @()

try {
    $source = [Drawing.Bitmap]::FromFile((Resolve-InputPath $sourcePath))
    foreach ($character in $characters) {
        $sheet = [Drawing.Bitmap]::FromFile((Resolve-InputPath $character.Sheet))
        $images += [pscustomobject]@{ Character=$character; Sheet=$sheet }
    }

    $fonts = @{
        Title=New-Font 48 ([Drawing.FontStyle]::Bold)
        Subtitle=New-Font 21
        Section=New-Font 25 ([Drawing.FontStyle]::Bold)
        Name=New-Font 31 ([Drawing.FontStyle]::Bold)
        Role=New-Font 20 ([Drawing.FontStyle]::Bold)
        Body=New-Font 17
        Small=New-Font 14
        Status=New-Font 18 ([Drawing.FontStyle]::Bold)
    }

    $canvas = [Drawing.Bitmap]::new(4096, 2304, [Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [Drawing.Graphics]::FromImage($canvas)
    $background = [Drawing.SolidBrush]::new((Get-Color '#07111F'))
    $panel = [Drawing.SolidBrush]::new((Get-Color '#0E1929'))
    $panelAlt = [Drawing.SolidBrush]::new((Get-Color '#111F33'))
    $white = [Drawing.SolidBrush]::new((Get-Color '#F8FAFC'))
    $muted = [Drawing.SolidBrush]::new((Get-Color '#9BAABD'))
    $warning = [Drawing.SolidBrush]::new((Get-Color '#F7B955'))
    $border = [Drawing.Pen]::new((Get-Color '#2A3B51'), 2)
    try {
        Initialize-Graphics $graphics
        $graphics.FillRectangle($background, 0, 0, $canvas.Width, $canvas.Height)
        Draw-Text $graphics 'RE:CAMP / CURRENT ROSTER FINAL COMPARISON' $fonts.Title $white ([Drawing.RectangleF]::new(48, 28, 2700, 62))
        Draw-Text $graphics 'ART-1504 / morning roster source-faithful / 2D review package + 2D-to-3D target visibility' $fonts.Subtitle $muted ([Drawing.RectangleF]::new(51, 96, 3000, 34))
        Draw-Text $graphics 'REVIEW / HUMAN VERDICT PENDING / NOT GRANTED' $fonts.Status $warning ([Drawing.RectangleF]::new(2750, 52, 1298, 34)) ([Drawing.StringAlignment]::Far)

        $sourceBounds = [Drawing.Rectangle]::new(48, 165, 2460, 440)
        $summaryBounds = [Drawing.Rectangle]::new(2540, 165, 1508, 440)
        $graphics.FillRectangle($panel, $sourceBounds)
        $graphics.DrawRectangle($border, $sourceBounds)
        Draw-Text $graphics 'SOURCE LOCK / MORNING ROSTER' $fonts.Section $white ([Drawing.RectangleF]::new(72, 184, 1100, 34))
        Draw-Text $graphics 'CH101 -> CH102 -> CH103 -> CH104 -> CH105' $fonts.Body $muted ([Drawing.RectangleF]::new(72, 222, 1100, 30))
        Draw-ImageFit $graphics $source ([Drawing.RectangleF]::new(72, 260, 2412, 325))

        $graphics.FillRectangle($panel, $summaryBounds)
        $graphics.DrawRectangle($border, $summaryBounds)
        Draw-Text $graphics 'COMPARISON BOUNDARY' $fonts.Section $white ([Drawing.RectangleF]::new(2570, 184, 1100, 34))
        Draw-Text $graphics 'Source commit  418ef96' $fonts.Body $muted ([Drawing.RectangleF]::new(2570, 238, 1400, 28))
        Draw-Text $graphics '2D targets  6.8-7.4H per character' $fonts.Body $muted ([Drawing.RectangleF]::new(2570, 274, 1400, 28))
        Draw-Text $graphics '3D targets  5.2-5.8H planning contract only' $fonts.Body $muted ([Drawing.RectangleF]::new(2570, 310, 1400, 28))
        Draw-Text $graphics 'CH101-CH104  2D approved references' $fonts.Body $white ([Drawing.RectangleF]::new(2570, 360, 1400, 28))
        Draw-Text $graphics 'CH105  Gate A decision pending' $fonts.Body $warning ([Drawing.RectangleF]::new(2570, 396, 1400, 28))
        Draw-Text $graphics 'No 3D mesh / rig / Unity asset is included.' $fonts.Body $warning ([Drawing.RectangleF]::new(2570, 450, 1400, 28))
        Draw-Text $graphics 'Final five-person result remains human review.' $fonts.Body $warning ([Drawing.RectangleF]::new(2570, 486, 1400, 28))
        Draw-Text $graphics 'Historical Luna/Miyu/Coco/Iris/Noah imagery excluded.' $fonts.Small $muted ([Drawing.RectangleF]::new(2570, 535, 1400, 28))

        $margin = 48
        $gap = 16
        $panelWidth = 787
        $panelTop = 650
        $panelHeight = 1420
        for ($i = 0; $i -lt $images.Count; $i++) {
            $entry = $images[$i]
            $character = $entry.Character
            $x = $margin + $i * ($panelWidth + $gap)
            $bounds = [Drawing.Rectangle]::new($x, $panelTop, $panelWidth, $panelHeight)
            $accentBrush = [Drawing.SolidBrush]::new((Get-Color $character.Accent))
            $accentPen = [Drawing.Pen]::new((Get-Color $character.Accent), 3)
            $brushes += $accentBrush
            $pens += $accentPen
            $graphics.FillRectangle($panel, $bounds)
            $graphics.DrawRectangle($border, $bounds)
            $graphics.FillRectangle($accentBrush, $x, $panelTop, 8, $panelHeight)
            Draw-Text $graphics "$($character.Id) / $($character.Name)" $fonts.Name $white ([Drawing.RectangleF]::new($x + 26, $panelTop + 18, $panelWidth - 50, 44))
            Draw-Text $graphics $character.Role $fonts.Role $accentBrush ([Drawing.RectangleF]::new($x + 27, $panelTop + 68, $panelWidth - 50, 30))
            Draw-Text $graphics $character.Status $fonts.Status $(if ($character.Status -eq 'GATE A PENDING') { $warning } else { $white }) ([Drawing.RectangleF]::new($x + 27, $panelTop + 104, $panelWidth - 50, 28))
            $imageBounds = [Drawing.RectangleF]::new($x + 20, $panelTop + 150, $panelWidth - 40, 790)
            $graphics.FillRectangle($panelAlt, $imageBounds)
            Draw-ImageFit $graphics $entry.Sheet $imageBounds
            $graphics.DrawLine($accentPen, $x + 24, $panelTop + 970, $x + $panelWidth - 24, $panelTop + 970)
            Draw-Text $graphics 'IDENTITY HOOK' $fonts.Small $muted ([Drawing.RectangleF]::new($x + 26, $panelTop + 988, $panelWidth - 52, 24))
            Draw-Text $graphics $character.Hook $fonts.Body $white ([Drawing.RectangleF]::new($x + 26, $panelTop + 1018, $panelWidth - 52, 52))
            Draw-Text $graphics $character.Palette $fonts.Small $muted ([Drawing.RectangleF]::new($x + 26, $panelTop + 1080, $panelWidth - 52, 30))
            Draw-Text $graphics "2D TARGET  $($character.Ratio2D)" $fonts.Role $accentBrush ([Drawing.RectangleF]::new($x + 26, $panelTop + 1132, $panelWidth - 52, 28))
            Draw-Text $graphics "3D TARGET  $($character.Ratio3D)" $fonts.Role $accentBrush ([Drawing.RectangleF]::new($x + 26, $panelTop + 1168, $panelWidth - 52, 28))
            Draw-Text $graphics '3D status: planning contract only' $fonts.Small $muted ([Drawing.RectangleF]::new($x + 26, $panelTop + 1210, $panelWidth - 52, 28))
            Draw-Text $graphics 'Contract and approval record remain separate.' $fonts.Small $muted ([Drawing.RectangleF]::new($x + 26, $panelTop + 1242, $panelWidth - 52, 44))
        }

        $footer = [Drawing.Rectangle]::new(48, 2110, 4000, 145)
        $graphics.FillRectangle($panel, $footer)
        $graphics.DrawRectangle($border, $footer)
        Draw-Text $graphics 'ART-1504 REVIEW RESULT' $fonts.Role $warning ([Drawing.RectangleF]::new(76, 2130, 700, 28))
        Draw-Text $graphics 'Current five-person comparison is assembled from the morning source and source-faithful character sheets. Human 5/5 separation, CH105 Gate A, and formal cross-review decisions remain pending.' $fonts.Body $white ([Drawing.RectangleF]::new(76, 2164, 2500, 52))
        Draw-Text $graphics 'No APPROVED comparison export / no Gate B / no 3D / no Unity / no Runtime migration' $fonts.Status $warning ([Drawing.RectangleF]::new(2580, 2160, 1420, 54)) ([Drawing.StringAlignment]::Far)
        Save-Canvas $canvas $outputPath
    }
    finally {
        $graphics.Dispose()
        $canvas.Dispose()
        $border.Dispose()
        $warning.Dispose()
        $muted.Dispose()
        $white.Dispose()
        $panelAlt.Dispose()
        $panel.Dispose()
        $background.Dispose()
        foreach ($brush in $brushes) { $brush.Dispose() }
        foreach ($pen in $pens) { $pen.Dispose() }
        foreach ($font in $fonts.Values) { $font.Dispose() }
    }

    [pscustomobject]@{
        Output = $outputPath
        Dimensions = '4096x2304'
        Source = $sourcePath
        Characters = $characters.Count
        Status = 'REVIEW / HUMAN VERDICT PENDING / NOT GRANTED'
    }
}
finally {
    if ($null -ne $source) { $source.Dispose() }
    foreach ($entry in $images) { $entry.Sheet.Dispose() }
}
