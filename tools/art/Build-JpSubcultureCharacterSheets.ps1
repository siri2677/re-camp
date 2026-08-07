[CmdletBinding()]
param(
    [string]$ProjectRoot,
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

function Resolve-In([string]$Path) {
    $full = if ([IO.Path]::IsPathRooted($Path)) { $Path } else { Join-Path $ProjectRoot $Path }
    return (Resolve-Path -LiteralPath $full -ErrorAction Stop).Path
}

function Resolve-Out([string]$Path) {
    if ([IO.Path]::IsPathRooted($Path)) { return [IO.Path]::GetFullPath($Path) }
    return [IO.Path]::GetFullPath((Join-Path $ProjectRoot $Path))
}

function Color([string]$Hex) { return [Drawing.ColorTranslator]::FromHtml($Hex) }

function Font([float]$Size, [Drawing.FontStyle]$Style = [Drawing.FontStyle]::Regular) {
    try { return [Drawing.Font]::new('Segoe UI', $Size, $Style, [Drawing.GraphicsUnit]::Pixel) }
    catch { return [Drawing.Font]::new([Drawing.FontFamily]::GenericSansSerif, $Size, $Style, [Drawing.GraphicsUnit]::Pixel) }
}

function Init([Drawing.Graphics]$Graphics) {
    $Graphics.SmoothingMode = [Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $Graphics.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $Graphics.PixelOffsetMode = [Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $Graphics.CompositingQuality = [Drawing.Drawing2D.CompositingQuality]::HighQuality
    $Graphics.TextRenderingHint = [Drawing.Text.TextRenderingHint]::AntiAliasGridFit
}

function Text(
    [Drawing.Graphics]$Graphics,
    [string]$Value,
    [Drawing.Font]$Font,
    [Drawing.Brush]$Brush,
    [Drawing.RectangleF]$Bounds,
    [Drawing.StringAlignment]$Alignment = [Drawing.StringAlignment]::Near
) {
    $format = [Drawing.StringFormat]::new()
    try {
        $format.Alignment = $Alignment
        $format.LineAlignment = [Drawing.StringAlignment]::Near
        $format.Trimming = [Drawing.StringTrimming]::EllipsisCharacter
        $format.FormatFlags = [Drawing.StringFormatFlags]::LineLimit
        $Graphics.DrawString($Value, $Font, $Brush, $Bounds, $format)
    }
    finally { $format.Dispose() }
}

function Fit([Drawing.Graphics]$Graphics, [Drawing.Image]$Image, [Drawing.RectangleF]$Bounds) {
    $scale = [Math]::Min($Bounds.Width / $Image.Width, $Bounds.Height / $Image.Height)
    $width = [float]($Image.Width * $scale)
    $height = [float]($Image.Height * $scale)
    $destination = [Drawing.RectangleF]::new(
        [float]($Bounds.X + ($Bounds.Width - $width) / 2.0),
        [float]($Bounds.Y + ($Bounds.Height - $height) / 2.0),
        $width,
        $height)
    $Graphics.DrawImage($Image, $destination)
}

function Frame(
    [Drawing.Graphics]$Graphics,
    [Drawing.Image]$Image,
    [Drawing.Rectangle]$Bounds,
    [string]$Title,
    [string]$Subtitle,
    [Drawing.Color]$Accent,
    [hashtable]$Fonts,
    [Drawing.Brush]$PanelBrush,
    [Drawing.Brush]$WhiteBrush,
    [Drawing.Brush]$MutedBrush,
    [Drawing.Pen]$BorderPen
) {
    $Graphics.FillRectangle($PanelBrush, $Bounds)
    $Graphics.DrawRectangle($BorderPen, $Bounds)
    $accentBrush = [Drawing.SolidBrush]::new($Accent)
    try {
        $Graphics.FillRectangle($accentBrush, $Bounds.X, $Bounds.Y, 8, $Bounds.Height)
        Text $Graphics $Title $Fonts.FrameTitle $WhiteBrush ([Drawing.RectangleF]::new($Bounds.X + 30, $Bounds.Y + 22, $Bounds.Width - 60, 42))
        Text $Graphics $Subtitle $Fonts.FrameSub $MutedBrush ([Drawing.RectangleF]::new($Bounds.X + 31, $Bounds.Y + 70, $Bounds.Width - 62, 32))
        $imageBounds = [Drawing.RectangleF]::new($Bounds.X + 22, $Bounds.Y + 116, $Bounds.Width - 44, $Bounds.Height - 138)
        Fit $Graphics $Image $imageBounds
    }
    finally { $accentBrush.Dispose() }
}

$characters = @(
    [pscustomobject]@{
        Id='CH001'; Name='LUNA'; Role='Sensor-cat Scout'; Accent='#43E6E1'; Ratio2D='6.90-7.10 H'; Ratio3D='5.30-5.40 H';
        Hook='Bright adult scout / mechanical sensor hood / paired energy daggers';
        Candidates='art_refs/characters/luna/concept/Luna_FullBodyCandidates_REVIEW_v003.png';
        KeyArt='art_refs/characters/luna/concept/Luna_KeyArt_REVIEW_v002.png';
        Turnaround='art_refs/characters/luna/turnaround/Luna_Turnaround_REVIEW_v004.png';
        Expressions='art_refs/characters/luna/expressions/Luna_ExpressionSheet_REVIEW_v002.png';
        Equipment='art_refs/characters/luna/equipment/Luna_EquipmentSheet_REVIEW_v002.png';
        Palette='art_refs/characters/luna/concept/Luna_MaterialPalette_REVIEW_v001.png';
        Translation='art_refs/characters/luna/3d_reference/Luna_2DTo3DTranslation_REVIEW_v005.png';
        Face='art_refs/characters/luna/concept/Luna_Face128_REVIEW_v003.png';
        Silhouette='art_refs/characters/luna/concept/Luna_SilhouetteTest_REVIEW_v002.png';
        Output='art_refs/characters/luna/Luna_CharacterSheet_REVIEW_v002.png'
    },
    [pscustomobject]@{
        Id='CH002'; Name='MIYU'; Role='Drone Technician'; Accent='#B69AF6'; Ratio2D='6.80-7.00 H'; Ratio3D='5.20-5.30 H';
        Hook='Sleepy adult technician / one oversized sleeve / two distinct drones';
        Candidates='art_refs/characters/miyu/concept/Miyu_FullBodyCandidates_REVIEW_v002.png';
        KeyArt='art_refs/characters/miyu/concept/Miyu_KeyArt_REVIEW_v002.png';
        Turnaround='art_refs/characters/miyu/turnaround/Miyu_Turnaround_REVIEW_v002.png';
        Expressions='art_refs/characters/miyu/expressions/Miyu_ExpressionSheet_REVIEW_v002.png';
        Equipment='art_refs/characters/miyu/equipment/Miyu_EquipmentSheet_REVIEW_v002.png';
        Palette='art_refs/characters/miyu/palette/Miyu_MaterialPalette_REVIEW_v001.png';
        Translation='art_refs/characters/miyu/3d_reference/Miyu_2DTo3DTranslation_REVIEW_v002.png';
        Face='art_refs/characters/miyu/face/Miyu_Face128_REVIEW_v002.png';
        Silhouette='art_refs/characters/miyu/silhouette/Miyu_SilhouetteTest_REVIEW_v001.png';
        Output='art_refs/characters/miyu/Miyu_CharacterSheet_REVIEW_v002.png'
    },
    [pscustomobject]@{
        Id='CH003'; Name='COCO'; Role='Rescue Captain'; Accent='#E88773'; Ratio2D='7.00-7.20 H'; Ratio3D='5.50-5.60 H';
        Hook='Warm adult rescue captain / coral half-cape / injector and clear protection field';
        Candidates='art_refs/characters/coco/concept/Coco_FullBodyCandidates_REVIEW_v002.png';
        KeyArt='art_refs/characters/coco/concept/Coco_KeyArt_REVIEW_v005.png';
        Turnaround='art_refs/characters/coco/turnaround/Coco_Turnaround_REVIEW_v002.png';
        Expressions='art_refs/characters/coco/expressions/Coco_ExpressionSheet_REVIEW_v002.png';
        Equipment='art_refs/characters/coco/equipment/Coco_EquipmentSheet_REVIEW_v002.png';
        Palette='art_refs/characters/coco/concept/Coco_MaterialPalette_REVIEW_v001.png';
        Translation='art_refs/characters/coco/3d_reference/Coco_2DTo3DTranslation_REVIEW_v002.png';
        Face='art_refs/characters/coco/concept/Coco_Face128_REVIEW_v003.png';
        Silhouette='art_refs/characters/coco/concept/Coco_SilhouetteTest_REVIEW_v001.png';
        Output='art_refs/characters/coco/Coco_CharacterSheet_REVIEW_v002.png'
    },
    [pscustomobject]@{
        Id='CH004'; Name='IRIS'; Role='Observation Specialist'; Accent='#E15B78'; Ratio2D='7.20-7.40 H'; Ratio3D='5.70-5.80 H';
        Hook='Elegant adult observer / long split white coat / fictional non-firearm energy observation lance';
        Candidates='art_refs/characters/iris/concept/Iris_FullBodyCandidates_REVIEW_v002.png';
        KeyArt='art_refs/characters/iris/concept/Iris_KeyArt_REVIEW_v006.png';
        Turnaround='art_refs/characters/iris/turnaround/Iris_Turnaround_REVIEW_v003.png';
        Expressions='art_refs/characters/iris/expressions/Iris_ExpressionSheet_REVIEW_v002.png';
        Equipment='art_refs/characters/iris/equipment/Iris_EquipmentSheet_REVIEW_v002.png';
        Palette='art_refs/characters/iris/concept/Iris_MaterialPalette_REVIEW_v001.png';
        Translation='art_refs/characters/iris/3d_reference/Iris_2DTo3DTranslation_REVIEW_v002.png';
        Face='art_refs/characters/iris/concept/Iris_Face128_REVIEW_v003.png';
        Silhouette='art_refs/characters/iris/concept/Iris_SilhouetteTest_REVIEW_v001.png';
        Output='art_refs/characters/iris/Iris_CharacterSheet_REVIEW_v002.png'
    },
    [pscustomobject]@{
        Id='CH005'; Name='NOAH'; Role='Mobile Haven Guardian'; Accent='#F0A84A'; Ratio2D='7.20-7.40 H'; Ratio3D='5.70-5.80 H';
        Hook='Calm adult guardian / navy bob with amber underlight / case-to-door barrier shield';
        Candidates='art_refs/characters/noah/concept/Noah_FullBodyCandidates_REVIEW_v002.png';
        KeyArt='art_refs/characters/noah/concept/Noah_KeyArt_REVIEW_v003.png';
        Turnaround='art_refs/characters/noah/turnaround/Noah_Turnaround_REVIEW_v003.png';
        Expressions='art_refs/characters/noah/expressions/Noah_ExpressionSheet_REVIEW_v002.png';
        Equipment='art_refs/characters/noah/equipment/Noah_EquipmentSheet_REVIEW_v002.png';
        Palette='art_refs/characters/noah/concept/Noah_MaterialPalette_REVIEW_v001.png';
        Translation='art_refs/characters/noah/3d_reference/Noah_2DTo3DTranslation_REVIEW_v002.png';
        Face='art_refs/characters/noah/concept/Noah_Face128_REVIEW_v002.png';
        Silhouette='art_refs/characters/noah/concept/Noah_SilhouetteTest_REVIEW_v001.png';
        Output='art_refs/characters/noah/Noah_CharacterSheet_REVIEW_v002.png'
    }
)

$fonts = @{
    Title=Font 54 ([Drawing.FontStyle]::Bold)
    Subtitle=Font 25
    Summary=Font 24
    FrameTitle=Font 27 ([Drawing.FontStyle]::Bold)
    FrameSub=Font 18
    Footer=Font 19 ([Drawing.FontStyle]::Bold)
}
$background = [Drawing.SolidBrush]::new((Color '#07111F'))
$panel = [Drawing.SolidBrush]::new((Color '#0E1929'))
$panelAlt = [Drawing.SolidBrush]::new((Color '#111F33'))
$white = [Drawing.SolidBrush]::new((Color '#F8FAFC'))
$muted = [Drawing.SolidBrush]::new((Color '#9BAABD'))
$warning = [Drawing.SolidBrush]::new((Color '#F7B955'))
$border = [Drawing.Pen]::new((Color '#2A3B51'), 3)

$results = @()
try {
    foreach ($character in $characters) {
        $paths = [ordered]@{
            Candidates=Resolve-In $character.Candidates
            KeyArt=Resolve-In $character.KeyArt
            Turnaround=Resolve-In $character.Turnaround
            Expressions=Resolve-In $character.Expressions
            Equipment=Resolve-In $character.Equipment
            Palette=Resolve-In $character.Palette
            Translation=Resolve-In $character.Translation
            Face=Resolve-In $character.Face
            Silhouette=Resolve-In $character.Silhouette
        }
        $images = [ordered]@{}
        try {
            foreach ($entry in $paths.GetEnumerator()) {
                $images[$entry.Key] = [Drawing.Bitmap]::FromFile($entry.Value)
            }
            if ($images.Face.Width -ne 128 -or $images.Face.Height -ne 128) {
                throw "$($character.Name) Face evidence must be exact 128x128."
            }

            $outputPath = Resolve-Out $character.Output
            if ([IO.File]::Exists($outputPath) -and -not $Force) {
                throw "Output exists: $outputPath. Use -Force to rebuild."
            }
            [IO.Directory]::CreateDirectory((Split-Path -Parent $outputPath)) | Out-Null

            $canvas = [Drawing.Bitmap]::new(4096, 4608, [Drawing.Imaging.PixelFormat]::Format24bppRgb)
            $graphics = [Drawing.Graphics]::FromImage($canvas)
            $accent = Color $character.Accent
            $accentBrush = [Drawing.SolidBrush]::new($accent)
            $accentPen = [Drawing.Pen]::new($accent, 3)
            try {
                Init $graphics
                $graphics.FillRectangle($background, 0, 0, $canvas.Width, $canvas.Height)
                Text $graphics "$($character.Id) / $($character.Name) / INTEGRATED CHARACTER REVIEW" $fonts.Title $white ([Drawing.RectangleF]::new(48, 26, 2900, 70))
                Text $graphics 'JP SUBCULTURE STYLE RESET / 2D DESIGN + 3D TRANSLATION EVIDENCE' $fonts.Subtitle $muted ([Drawing.RectangleF]::new(51, 100, 3000, 38))
                Text $graphics 'REVIEW / HUMAN APPROVAL PENDING / NOT GRANTED' $fonts.Subtitle $warning ([Drawing.RectangleF]::new(2930, 54, 1118, 40)) ([Drawing.StringAlignment]::Far)
                $graphics.DrawLine($accentPen, 48, 150, 4048, 150)

                $summary = [Drawing.Rectangle]::new(48, 178, 4000, 250)
                $graphics.FillRectangle($panel, $summary)
                $graphics.DrawRectangle($border, $summary)
                Text $graphics "$($character.Role)" $fonts.FrameTitle $accentBrush ([Drawing.RectangleF]::new(80, 204, 800, 42))
                Text $graphics $character.Hook $fonts.Summary $white ([Drawing.RectangleF]::new(80, 256, 3800, 40))
                Text $graphics "2D TARGET  $($character.Ratio2D)     |     3D TARGET  $($character.Ratio3D)" $fonts.Summary $accentBrush ([Drawing.RectangleF]::new(80, 310, 2500, 38))
                Text $graphics 'Japanese mobile-RPG anime face, refined hair clumps and clean cel/soft-gradient rendering are locked. Western semi-realistic and painterly rendering are rejected.' $fonts.FrameSub $muted ([Drawing.RectangleF]::new(80, 365, 3800, 34))

                $x = @(48, 2064)
                $y = @(458, 1438, 2418, 3398)
                $w = 1984
                $h = 948
                Frame $graphics $images.Candidates ([Drawing.Rectangle]::new($x[0],$y[0],$w,$h)) '01 / THREE DESIGN DIRECTIONS' 'Style-reset candidates; selected direction remains the KeyArt anchor' $accent $fonts $panel $white $muted $border
                Frame $graphics $images.KeyArt ([Drawing.Rectangle]::new($x[1],$y[0],$w,$h)) '02 / SELECTED KEY ART' 'Japanese-subculture face and full-body identity anchor' $accent $fonts $panel $white $muted $border
                Frame $graphics $images.Turnaround ([Drawing.Rectangle]::new($x[0],$y[1],$w,$h)) '03 / FRONT + SIDE + BACK' 'Design consistency evidence; model topology and rig remain untested' $accent $fonts $panel $white $muted $border
                Frame $graphics $images.Expressions ([Drawing.Rectangle]::new($x[1],$y[1],$w,$h)) '04 / EXACTLY EIGHT EXPRESSIONS' 'Same Japanese-subculture face construction across emotional range' $accent $fonts $panel $white $muted $border
                Frame $graphics $images.Equipment ([Drawing.Rectangle]::new($x[0],$y[2],$w,$h)) '05 / EQUIPMENT CONSTRUCTION' 'Signature equipment, fold states, grips and emission language' $accent $fonts $panel $white $muted $border
                Frame $graphics $images.Palette ([Drawing.Rectangle]::new($x[1],$y[2],$w,$h)) '06 / MATERIAL PALETTE' 'Locked palette retained and rechecked against the style-reset KeyArt' $accent $fonts $panel $white $muted $border
                Frame $graphics $images.Translation ([Drawing.Rectangle]::new($x[0],$y[3],$w,$h)) '07 / 2D TO 3D TRANSLATION' 'Same adult identity translated to the character-specific 5-6H target' $accent $fonts $panel $white $muted $border

                $evidence = [Drawing.Rectangle]::new($x[1],$y[3],$w,$h)
                $graphics.FillRectangle($panel, $evidence)
                $graphics.DrawRectangle($border, $evidence)
                $graphics.FillRectangle($accentBrush, $evidence.X, $evidence.Y, 8, $evidence.Height)
                Text $graphics '08 / 128px FACE + SILHOUETTE EVIDENCE' $fonts.FrameTitle $white ([Drawing.RectangleF]::new($evidence.X + 30,$evidence.Y + 22,$evidence.Width - 60,42))
                Text $graphics 'Exact face crop uses the new KeyArt; silhouette remains role/equipment structural evidence.' $fonts.FrameSub $muted ([Drawing.RectangleF]::new($evidence.X + 31,$evidence.Y + 70,$evidence.Width - 62,32))
                $oldInterpolation = $graphics.InterpolationMode
                $graphics.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
                $graphics.DrawImage($images.Face, [Drawing.Rectangle]::new($evidence.X + 80,$evidence.Y + 180,512,512))
                $graphics.InterpolationMode = $oldInterpolation
                Fit $graphics $images.Silhouette ([Drawing.RectangleF]::new($evidence.X + 650,$evidence.Y + 130,1260,650))
                Text $graphics 'FACE 128x128 / JP STYLE RESET' $fonts.Footer $accentBrush ([Drawing.RectangleF]::new($evidence.X + 80,$evidence.Y + 720,520,32))
                Text $graphics 'SILHOUETTE / ROLE HOOK RETAINED' $fonts.Footer $accentBrush ([Drawing.RectangleF]::new($evidence.X + 750,$evidence.Y + 800,1080,32))

                $footerY = 4380
                $graphics.DrawLine($border, 48, $footerY, 4048, $footerY)
                Text $graphics 'PACKAGE READINESS: STYLE-RESET REVIEW EVIDENCE ASSEMBLED' $fonts.Footer $accentBrush ([Drawing.RectangleF]::new(48,$footerY + 32,2100,34))
                Text $graphics 'Gate A subjective appeal/originality and all Blender/Unity Gate B/C proof remain pending. APPROVED is not granted.' $fonts.Footer $warning ([Drawing.RectangleF]::new(48,$footerY + 82,3800,34))
                Text $graphics 'Deterministic composite: tools/art/Build-JpSubcultureCharacterSheets.ps1' $fonts.FrameSub $muted ([Drawing.RectangleF]::new(48,$footerY + 132,3800,30))

                $canvas.Save($outputPath, [Drawing.Imaging.ImageFormat]::Png)
                $results += [pscustomobject]@{
                    Character=$character.Name
                    Output=$outputPath
                    Dimensions='4096x4608'
                    Sources=$paths.Count
                    Face='128x128'
                    Status='JP SUBCULTURE STYLE RESET / REVIEW'
                    HumanApproval='NOT GRANTED'
                }
            }
            finally {
                $accentPen.Dispose()
                $accentBrush.Dispose()
                $graphics.Dispose()
                $canvas.Dispose()
            }
        }
        finally {
            foreach ($image in $images.Values) { $image.Dispose() }
        }
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
}

$results
