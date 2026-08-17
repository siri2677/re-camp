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

function Resolve-ProjectPath([string]$Path) {
    if ([IO.Path]::IsPathRooted($Path)) {
        return [IO.Path]::GetFullPath($Path)
    }

    return [IO.Path]::GetFullPath((Join-Path $ProjectRoot $Path))
}

function ConvertTo-Rectangle([string]$Value) {
    $parts = @($Value.Split(',') | ForEach-Object { [int]$_.Trim() })
    if ($parts.Count -ne 4) {
        throw "Crop must be x,y,width,height: $Value"
    }

    return [Drawing.Rectangle]::new($parts[0], $parts[1], $parts[2], $parts[3])
}

function Assert-Crop([Drawing.Image]$Image, [Drawing.Rectangle]$Crop, [string]$Name) {
    if ($Crop.Width -le 0 -or $Crop.Height -le 0 -or
        $Crop.Left -lt 0 -or $Crop.Top -lt 0 -or
        $Crop.Right -gt $Image.Width -or $Crop.Bottom -gt $Image.Height) {
        throw "$Name crop is outside $($Image.Width)x$($Image.Height): $Crop"
    }
}

function Save-Face128(
    [Drawing.Bitmap]$Source,
    [Drawing.Rectangle]$Crop,
    [string]$OutputPath
) {
    if ([IO.File]::Exists($OutputPath) -and -not $Force) {
        throw "Output exists: $OutputPath. Use -Force to rebuild deterministic evidence."
    }

    [IO.Directory]::CreateDirectory((Split-Path -Parent $OutputPath)) | Out-Null
    $canvas = [Drawing.Bitmap]::new(128, 128, [Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [Drawing.Graphics]::FromImage($canvas)
    $attributes = [Drawing.Imaging.ImageAttributes]::new()
    try {
        $graphics.CompositingMode = [Drawing.Drawing2D.CompositingMode]::SourceCopy
        $graphics.CompositingQuality = [Drawing.Drawing2D.CompositingQuality]::HighQuality
        $graphics.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.SmoothingMode = [Drawing.Drawing2D.SmoothingMode]::HighQuality
        $attributes.SetWrapMode([Drawing.Drawing2D.WrapMode]::TileFlipXY)
        $graphics.DrawImage(
            $Source,
            [Drawing.Rectangle]::new(0, 0, 128, 128),
            $Crop.X,
            $Crop.Y,
            $Crop.Width,
            $Crop.Height,
            [Drawing.GraphicsUnit]::Pixel,
            $attributes)
        $canvas.Save($OutputPath, [Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $attributes.Dispose()
        $graphics.Dispose()
        $canvas.Dispose()
    }
}

# Crops deliberately include the full hair silhouette, both eyes, chin, and a small
# amount of costume color. They are review portraits, not runtime-authored icons.
$characters = @(
    [pscustomobject]@{
        Name = 'Luna'
        Source = 'art_refs/characters/luna/concept/Luna_KeyArt_REVIEW_v002.png'
        Crop = '276,116,336,336'
        Output = 'art_refs/characters/luna/concept/Luna_Face128_REVIEW_v003.png'
    },
    [pscustomobject]@{
        Name = 'Miyu'
        Source = 'art_refs/characters/miyu/concept/Miyu_KeyArt_REVIEW_v002.png'
        Crop = '342,68,360,360'
        Output = 'art_refs/characters/miyu/face/Miyu_Face128_REVIEW_v002.png'
    },
    [pscustomobject]@{
        Name = 'Coco'
        Source = 'art_refs/characters/coco/concept/Coco_KeyArt_REVIEW_v005.png'
        Crop = '285,125,280,280'
        Output = 'art_refs/characters/coco/concept/Coco_Face128_REVIEW_v003.png'
    },
    [pscustomobject]@{
        Name = 'Iris'
        Source = 'art_refs/characters/iris/concept/Iris_KeyArt_REVIEW_v006.png'
        Crop = '310,205,280,280'
        Output = 'art_refs/characters/iris/concept/Iris_Face128_REVIEW_v003.png'
    },
    [pscustomobject]@{
        Name = 'Noah'
        Source = 'art_refs/characters/noah/concept/Noah_KeyArt_REVIEW_v003.png'
        Crop = '330,170,250,250'
        Output = 'art_refs/characters/noah/concept/Noah_Face128_REVIEW_v002.png'
    }
)

$results = foreach ($character in $characters) {
    $sourcePath = Resolve-ProjectPath $character.Source
    $outputPath = Resolve-ProjectPath $character.Output
    $crop = ConvertTo-Rectangle $character.Crop
    $source = [Drawing.Bitmap]::FromFile($sourcePath)
    try {
        Assert-Crop -Image $source -Crop $crop -Name $character.Name
        Save-Face128 -Source $source -Crop $crop -OutputPath $outputPath
    }
    finally {
        $source.Dispose()
    }

    $output = [Drawing.Bitmap]::FromFile($outputPath)
    try {
        if ($output.Width -ne 128 -or $output.Height -ne 128) {
            throw "$($character.Name) output is not exact 128x128."
        }
    }
    finally {
        $output.Dispose()
    }

    [pscustomobject]@{
        Character = $character.Name
        Source = $sourcePath
        Crop = $character.Crop
        Output = $outputPath
        Size = '128x128'
        Status = 'JP SUBCULTURE STYLE RESET / REVIEW'
        HumanApproval = 'NOT GRANTED'
    }
}

$results
