param(
    [string]$SourcePath = 'art_refs/characters/shion/concept/CH104_Shion_CharacterSheet_APPROVED_v001.png',
    [string]$OutputPath = 'art_refs/characters/shion/concept/CH104_Shion_Turnaround_REVIEW_v001.png'
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

function Resolve-RepoPath([string]$Path) {
    if ([System.IO.Path]::IsPathRooted($Path)) { return $Path }
    return Join-Path (Get-Location) $Path
}

function Get-ContentBounds([System.Drawing.Bitmap]$Image) {
    $minX = $Image.Width
    $minY = $Image.Height
    $maxX = -1
    $maxY = -1

    for ($y = 0; $y -lt $Image.Height; $y++) {
        for ($x = 0; $x -lt $Image.Width; $x++) {
            $pixel = $Image.GetPixel($x, $y)
            if ($pixel.A -gt 0 -and ($pixel.R -lt 248 -or $pixel.G -lt 248 -or $pixel.B -lt 248)) {
                if ($x -lt $minX) { $minX = $x }
                if ($y -lt $minY) { $minY = $y }
                if ($x -gt $maxX) { $maxX = $x }
                if ($y -gt $maxY) { $maxY = $y }
            }
        }
    }

    if ($maxX -lt 0) { throw 'No non-white figure pixels found in the source cell.' }
    return [System.Drawing.Rectangle]::new($minX, $minY, $maxX - $minX + 1, $maxY - $minY + 1)
}

function Crop-Figure([System.Drawing.Bitmap]$Source, [System.Drawing.Rectangle]$Cell) {
    $cellBitmap = [System.Drawing.Bitmap]::new($Cell.Width, $Cell.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $cellGraphics = [System.Drawing.Graphics]::FromImage($cellBitmap)
    try {
        $cellGraphics.Clear([System.Drawing.Color]::White)
        $cellGraphics.DrawImage($Source, [System.Drawing.Rectangle]::new(0, 0, $Cell.Width, $Cell.Height), $Cell, [System.Drawing.GraphicsUnit]::Pixel)
    } finally {
        $cellGraphics.Dispose()
    }

    $bounds = Get-ContentBounds $cellBitmap
    $padding = 14
    $x = [Math]::Max(0, $bounds.X - $padding)
    $y = [Math]::Max(0, $bounds.Y - $padding)
    $right = [Math]::Min($cellBitmap.Width, $bounds.Right + $padding)
    $bottom = [Math]::Min($cellBitmap.Height, $bounds.Bottom + $padding)
    $crop = [System.Drawing.Rectangle]::new($x, $y, $right - $x, $bottom - $y)
    $figure = $cellBitmap.Clone($crop, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $cellBitmap.Dispose()
    return $figure
}

$sourceFull = Resolve-RepoPath $SourcePath
$outputFull = Resolve-RepoPath $OutputPath
$outputDirectory = Split-Path -Parent $outputFull
New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null

$source = [System.Drawing.Bitmap]::FromFile($sourceFull)
$output = [System.Drawing.Bitmap]::new(1672, 941, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
$graphics = [System.Drawing.Graphics]::FromImage($output)
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

try {
    $graphics.Clear([System.Drawing.Color]::White)

    if ($source.Width -ne 1536 -or $source.Height -ne 1024) {
        throw "Unexpected CH104 approved-sheet dimensions: $($source.Width)x$($source.Height)"
    }

    # The approved sheet's top row is a strict front / rear / profile strip.
    # Equal-width cells prevent the lower A/B/C state panels from entering this export.
    $cells = @(
        [System.Drawing.Rectangle]::new(0, 0, 512, 660),
        [System.Drawing.Rectangle]::new(512, 0, 512, 660),
        [System.Drawing.Rectangle]::new(1024, 0, 512, 660)
    )
    $figures = @()
    foreach ($cell in $cells) {
        $figures += Crop-Figure $source $cell
    }

    $targetHeight = 820
    $centers = @(285, 836, 1387)
    for ($i = 0; $i -lt $figures.Count; $i++) {
        $figure = $figures[$i]
        try {
            $scale = $targetHeight / [double]$figure.Height
            $width = [int][Math]::Round($figure.Width * $scale)
            $height = [int][Math]::Round($figure.Height * $scale)
            $x = [int][Math]::Round($centers[$i] - ($width / 2.0))
            $y = 42
            $destination = [System.Drawing.Rectangle]::new($x, $y, $width, $height)
            $graphics.DrawImage($figure, $destination)
        } finally {
            $figure.Dispose()
        }
    }

    $output.Save($outputFull, [System.Drawing.Imaging.ImageFormat]::Png)
    [pscustomobject]@{
        Output = $OutputPath
        Dimensions = '1672x941'
        Source = $SourcePath
        Views = 'front, back, side profile'
        Method = 'deterministic crop and normalized layout from approved sheet'
    }
} finally {
    $graphics.Dispose()
    $output.Dispose()
    $source.Dispose()
}
