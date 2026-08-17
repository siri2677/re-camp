[CmdletBinding()]
param(
    [string]$ProjectRoot,
    [string]$SourcePath = 'art_refs/characters/coco/3d_reference/Coco_3DReference_WIP_v002.png',
    [string]$OutputPath = 'art_refs/characters/coco/3d_reference/Coco_3DReference_REVIEW_v001.png',
    [int]$CrownY = 10,
    [int]$ChinY = 145,
    [int]$SourceSoleY = 932,
    [double]$TargetHeads = 5.55,
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

if ([string]::IsNullOrWhiteSpace($ProjectRoot)) {
    $ProjectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
}
else { $ProjectRoot = [System.IO.Path]::GetFullPath($ProjectRoot) }

function Resolve-Input {
    param([string]$Path)
    $candidate = if ([System.IO.Path]::IsPathRooted($Path)) { $Path } else { Join-Path $ProjectRoot $Path }
    return (Resolve-Path -LiteralPath $candidate -ErrorAction Stop).Path
}
function Resolve-Output {
    param([string]$Path)
    if ([System.IO.Path]::IsPathRooted($Path)) { return [System.IO.Path]::GetFullPath($Path) }
    return [System.IO.Path]::GetFullPath((Join-Path $ProjectRoot $Path))
}

$source = [System.Drawing.Bitmap]::FromFile((Resolve-Input $SourcePath))
$resolvedOutput = Resolve-Output $OutputPath
$output = $null
$graphics = $null
try {
    if ($source.Width -ne 1659 -or $source.Height -ne 948) {
        throw "Expected 1659x948 source, got $($source.Width)x$($source.Height)."
    }
    $headPixels = $ChinY - $CrownY
    $targetSoleY = [int][Math]::Round($CrownY + ($headPixels * $TargetHeads))
    $sourceBodyHeight = $SourceSoleY - $ChinY
    $targetBodyHeight = $targetSoleY - $ChinY

    $output = [System.Drawing.Bitmap]::new($source.Width, $source.Height, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($output)
    $graphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
    $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

    $backgroundBrush = [System.Drawing.SolidBrush]::new($source.GetPixel(8, $SourceSoleY))
    try { $graphics.FillRectangle($backgroundBrush, 0, 0, $source.Width, $source.Height) }
    finally { $backgroundBrush.Dispose() }

    $graphics.DrawImage($source,
        [System.Drawing.Rectangle]::new(0,0,$source.Width,$ChinY),
        [System.Drawing.Rectangle]::new(0,0,$source.Width,$ChinY),
        [System.Drawing.GraphicsUnit]::Pixel)
    $graphics.DrawImage($source,
        [System.Drawing.Rectangle]::new(0,$ChinY,$source.Width,$targetBodyHeight),
        [System.Drawing.Rectangle]::new(0,$ChinY,$source.Width,$sourceBodyHeight),
        [System.Drawing.GraphicsUnit]::Pixel)
    if ([System.IO.File]::Exists($resolvedOutput) -and -not $Force) {
        throw "Output exists: $resolvedOutput. Use -Force."
    }
    $output.Save($resolvedOutput, [System.Drawing.Imaging.ImageFormat]::Png)
    [pscustomobject]@{
        Output=$resolvedOutput
        Crown=$CrownY
        Chin=$ChinY
        Sole=$targetSoleY
        Heads=[Math]::Round(($targetSoleY-$CrownY)/[double]$headPixels,2)
        BodyVerticalScale=[Math]::Round($targetBodyHeight/[double]$sourceBodyHeight,4)
        Status='REVIEW'
        BlenderUnityProof='Not Tested'
        Approved='NOT GRANTED'
    }
}
finally {
    if($graphics){$graphics.Dispose()}
    if($output){$output.Dispose()}
    $source.Dispose()
}
