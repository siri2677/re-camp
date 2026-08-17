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
} else {
    $ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot)
}

function Resolve-In([string]$Path) {
    return (Resolve-Path -LiteralPath (Join-Path $ProjectRoot $Path) -ErrorAction Stop).Path
}

function Resolve-Out([string]$Path) {
    return [IO.Path]::GetFullPath((Join-Path $ProjectRoot $Path))
}

function Save-Png([Drawing.Bitmap]$Image, [string]$Path) {
    $directory = Split-Path -Parent $Path
    if (-not [IO.Directory]::Exists($directory)) { [IO.Directory]::CreateDirectory($directory) | Out-Null }
    if ([IO.File]::Exists($Path) -and -not $Force) { throw "Output exists: $Path. Use -Force." }
    $Image.Save($Path, [Drawing.Imaging.ImageFormat]::Png)
}

function New-Canvas([int]$Width, [int]$Height) {
    return [Drawing.Bitmap]::new($Width, $Height, [Drawing.Imaging.PixelFormat]::Format24bppRgb)
}

function Draw-Segment {
    param(
        [Drawing.Graphics]$Graphics,
        [Drawing.Bitmap]$Source,
        [int]$SourceTop,
        [int]$SourceBottom,
        [int]$DestinationTop,
        [int]$DestinationBottom
    )
    if ($SourceBottom -le $SourceTop -or $DestinationBottom -le $DestinationTop) { return }
    $sourceRect = [Drawing.Rectangle]::new(0, $SourceTop, $Source.Width, $SourceBottom - $SourceTop)
    $destRect = [Drawing.Rectangle]::new(0, $DestinationTop, $Source.Width, $DestinationBottom - $DestinationTop)
    $Graphics.DrawImage($Source, $destRect, $sourceRect, [Drawing.GraphicsUnit]::Pixel)
}

function New-BodyCorrectedImage {
    param(
        [Drawing.Bitmap]$Source,
        [int]$CrownY,
        [int]$ChinY,
        [int]$SoleY,
        [double]$TargetHeads
    )
    $head = $ChinY - $CrownY
    $targetSole = [int][Math]::Round($CrownY + $TargetHeads * $head)
    if ($targetSole -le $ChinY -or $targetSole -ge $Source.Height) { throw 'Computed target sole is outside the canvas.' }
    $output = New-Canvas $Source.Width $Source.Height
    $graphics = [Drawing.Graphics]::FromImage($output)
    try {
        $graphics.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.CompositingQuality = [Drawing.Drawing2D.CompositingQuality]::HighQuality
        Draw-Segment $graphics $Source 0 $ChinY 0 $ChinY
        Draw-Segment $graphics $Source $ChinY $SoleY $ChinY $targetSole
        Draw-Segment $graphics $Source $SoleY $Source.Height $targetSole $Source.Height
    } finally {
        $graphics.Dispose()
    }
    return [pscustomobject]@{
        Image = $output
        CrownY = $CrownY
        ChinY = $ChinY
        SoleY = $targetSole
        Heads = ($targetSole - $CrownY) / [double]$head
        BodyScale = ($targetSole - $ChinY) / [double]($SoleY - $ChinY)
    }
}

function New-HeadCorrectedImage {
    param(
        [Drawing.Bitmap]$Source,
        [int]$CrownY,
        [int]$ChinY,
        [int]$SoleY,
        [double]$TargetHeads
    )
    $oldHead = $ChinY - $CrownY
    $oldHeads = ($SoleY - $CrownY) / [double]$oldHead
    $headScale = ($oldHeads - 1.0) / ($TargetHeads - 1.0)
    $newHead = [int][Math]::Round($oldHead * $headScale)
    $newChin = $CrownY + $newHead
    $shift = $ChinY - $newChin
    $newSole = $SoleY - $shift
    $output = New-Canvas $Source.Width $Source.Height
    $graphics = [Drawing.Graphics]::FromImage($output)
    try {
        $graphics.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.CompositingQuality = [Drawing.Drawing2D.CompositingQuality]::HighQuality
        Draw-Segment $graphics $Source 0 $CrownY 0 $CrownY
        Draw-Segment $graphics $Source $CrownY $ChinY $CrownY $newChin
        Draw-Segment $graphics $Source $ChinY $SoleY $newChin $newSole
        Draw-Segment $graphics $Source $SoleY $Source.Height $newSole $Source.Height
    } finally {
        $graphics.Dispose()
    }
    return [pscustomobject]@{
        Image = $output
        CrownY = $CrownY
        ChinY = $newChin
        SoleY = $newSole
        Heads = ($newSole - $CrownY) / [double]$newHead
        HeadScale = $headScale
    }
}

$jobs = @(
    [pscustomobject]@{
        Kind = 'Body'
        Input = 'art_refs/characters/noah/concept/Noah_KeyArt_REVIEW_v001.png'
        Output = 'art_refs/characters/noah/concept/Noah_KeyArt_REVIEW_v002.png'
        Width = 864; Height = 1821; Crown = 129; Chin = 312; Sole = 1718; Target = 7.30
    },
    [pscustomobject]@{
        Kind = 'Body'
        Input = 'art_refs/characters/noah/turnaround/Noah_Turnaround_REVIEW_v001.png'
        Output = 'art_refs/characters/noah/turnaround/Noah_Turnaround_REVIEW_v002.png'
        Width = 1672; Height = 941; Crown = 20; Chin = 122; Sole = 909; Target = 7.30
    },
    [pscustomobject]@{
        Kind = 'Head'
        Input = 'art_refs/characters/noah/3d_reference/Noah_3DReference_REVIEW_v001.png'
        Output = 'art_refs/characters/noah/3d_reference/Noah_3DReference_REVIEW_v002.png'
        Width = 1024; Height = 1536; Crown = 75; Chin = 338; Sole = 1498; Target = 5.75
    }
)

$results = @()
foreach ($job in $jobs) {
    $source = [Drawing.Bitmap]::FromFile((Resolve-In $job.Input))
    try {
        if ($source.Width -ne $job.Width -or $source.Height -ne $job.Height) {
            throw "$($job.Input) dimensions changed: expected $($job.Width)x$($job.Height), got $($source.Width)x$($source.Height)."
        }
        $result = if ($job.Kind -eq 'Body') {
            New-BodyCorrectedImage $source $job.Crown $job.Chin $job.Sole $job.Target
        } else {
            New-HeadCorrectedImage $source $job.Crown $job.Chin $job.Sole $job.Target
        }
        try { Save-Png $result.Image (Resolve-Out $job.Output) } finally { $result.Image.Dispose() }
        $results += [pscustomobject]@{
            Output = $job.Output
            CrownY = $result.CrownY
            ChinY = $result.ChinY
            SoleY = $result.SoleY
            Heads = [Math]::Round($result.Heads, 3)
            Transform = if ($job.Kind -eq 'Body') { 'body-only vertical correction' } else { 'head-only vertical correction + body translation' }
        }
    } finally {
        $source.Dispose()
    }
}

$results
