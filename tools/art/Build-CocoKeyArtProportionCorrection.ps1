[CmdletBinding()]
param(
    [string]$ProjectRoot,
    [string]$SourcePath = 'art_refs/characters/coco/concept/Coco_KeyArt_WIP_v003.png',
    [string]$OutputPath = 'art_refs/characters/coco/concept/Coco_KeyArt_REVIEW_v002.png',
    [int]$CrownY = 160,
    [int]$ChinY = 340,
    [int]$SourceSoleY = 1642,
    [double]$TargetHeads = 7.10,
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
    if ([System.IO.Path]::IsPathRooted($Path)) { return [System.IO.Path]::GetFullPath($Path) }
    return [System.IO.Path]::GetFullPath((Join-Path $ProjectRoot $Path))
}

$resolvedSource = Resolve-InputPath $SourcePath
$resolvedOutput = Resolve-OutputPath $OutputPath
$source = [System.Drawing.Bitmap]::FromFile($resolvedSource)
$output = $null
$graphics = $null

try {
    if ($source.Width -ne 864 -or $source.Height -ne 1821) {
        throw "Expected 864x1821 source, got $($source.Width)x$($source.Height)."
    }
    if ($CrownY -lt 0 -or $ChinY -le $CrownY -or $SourceSoleY -le $ChinY -or $SourceSoleY -ge $source.Height) {
        throw 'Invalid crown/chin/sole landmarks.'
    }

    $headPixels = $ChinY - $CrownY
    $targetSoleY = [int][Math]::Round($CrownY + ($headPixels * $TargetHeads))
    $destinationBodyHeight = $targetSoleY - $ChinY
    $sourceBodyHeight = $SourceSoleY - $ChinY
    if ($destinationBodyHeight -le 0) { throw 'Target body height is not positive.' }

    $output = [System.Drawing.Bitmap]::new($source.Width, $source.Height, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($output)
    $graphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
    $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality

    # Preserve the face/head segment exactly. Compress only the chin-to-sole span,
    # then stretch the source's empty ground/reflection tail to retain the canvas.
    $graphics.DrawImage(
        $source,
        [System.Drawing.Rectangle]::new(0, 0, $source.Width, $ChinY),
        [System.Drawing.Rectangle]::new(0, 0, $source.Width, $ChinY),
        [System.Drawing.GraphicsUnit]::Pixel)
    $graphics.DrawImage(
        $source,
        [System.Drawing.Rectangle]::new(0, $ChinY, $source.Width, $destinationBodyHeight),
        [System.Drawing.Rectangle]::new(0, $ChinY, $source.Width, $sourceBodyHeight),
        [System.Drawing.GraphicsUnit]::Pixel)
    $graphics.DrawImage(
        $source,
        [System.Drawing.Rectangle]::new(0, $targetSoleY, $source.Width, $source.Height - $targetSoleY),
        [System.Drawing.Rectangle]::new(0, $SourceSoleY, $source.Width, $source.Height - $SourceSoleY),
        [System.Drawing.GraphicsUnit]::Pixel)

    $directory = Split-Path -Parent $resolvedOutput
    if (-not [System.IO.Directory]::Exists($directory)) {
        [System.IO.Directory]::CreateDirectory($directory) | Out-Null
    }
    if ([System.IO.File]::Exists($resolvedOutput) -and -not $Force) {
        throw "Output exists: $resolvedOutput. Use -Force for a deterministic rebuild."
    }
    $output.Save($resolvedOutput, [System.Drawing.Imaging.ImageFormat]::Png)

    [pscustomobject]@{
        Output = $resolvedOutput
        Crown = $CrownY
        Chin = $ChinY
        Sole = $targetSoleY
        HeadPixels = $headPixels
        Heads = [Math]::Round(($targetSoleY - $CrownY) / [double]$headPixels, 2)
        BodyVerticalScale = [Math]::Round($destinationBodyHeight / [double]$sourceBodyHeight, 4)
        Status = 'REVIEW'
        HumanApproval = 'Pending'
        Approved = 'NOT GRANTED'
    }
}
finally {
    if ($graphics) { $graphics.Dispose() }
    if ($output) { $output.Dispose() }
    $source.Dispose()
}
