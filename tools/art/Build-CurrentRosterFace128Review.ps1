param(
    [string]$OutputPath = 'art_refs/characters/roster/current/CH101-105_Roster_Face128_REVIEW_v001.png'
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

function Resolve-RepoPath([string]$Path) {
    if ([System.IO.Path]::IsPathRooted($Path)) { return $Path }
    return Join-Path (Get-Location) $Path
}

function New-Font([float]$Size, [System.Drawing.FontStyle]$Style = [System.Drawing.FontStyle]::Regular) {
    return [System.Drawing.Font]::new('Arial', $Size, $Style, [System.Drawing.GraphicsUnit]::Pixel)
}

$outputFull = Resolve-RepoPath $OutputPath
$outputDirectory = Split-Path -Parent $outputFull
New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null

$output = [System.Drawing.Bitmap]::new(960, 214, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
$graphics = [System.Drawing.Graphics]::FromImage($output)
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$titleFont = New-Font 15 ([System.Drawing.FontStyle]::Bold)
$labelFont = New-Font 12 ([System.Drawing.FontStyle]::Bold)
$smallFont = New-Font 10
$white = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
$ink = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(24, 32, 46))
$muted = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(88, 102, 118))
$line = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(198, 208, 220), 1)

try {
    $graphics.Clear([System.Drawing.Color]::FromArgb(247, 249, 252))
    $graphics.DrawString('CH101-CH105 / EXACT 128px FACE REVIEW', $titleFont, $ink, 16, 10)
    $graphics.DrawString('Deterministic face crops from current-roster support boards | REVIEW ONLY', $smallFont, $muted, 16, 31)

    # CH101/CH102 are already exact 128x128 support boards. CH103-CH105
    # are three-panel face boards derived from the same morning roster source;
    # crop only the first, equipment-free face panel from each board.
    $sources = @(
        @{ Id='CH101 Rin'; Path='art_refs/characters/rin/concept/CH101_Rin_Face128_WIP_A_v001.png'; Crop=$null },
        @{ Id='CH102 Mao'; Path='art_refs/characters/mao/concept/CH102_Mao_Face128_WIP_A_v001.png'; Crop=$null },
        @{ Id='CH103 Nozomi'; Path='art_refs/characters/nozomi/concept/CH103_Nozomi_Face128_WIP_A_v001.png'; Crop=[System.Drawing.Rectangle]::new(42, 76, 500, 500) },
        @{ Id='CH104 Shion'; Path='art_refs/characters/shion/concept/CH104_Shion_Face128_WIP_A_v001.png'; Crop=[System.Drawing.Rectangle]::new(68, 8, 500, 500) },
        @{ Id='CH105 Akari'; Path='art_refs/characters/akari/concept/CH105_Akari_Face128_WIP_A_v001.png'; Crop=[System.Drawing.Rectangle]::new(42, 105, 500, 500) }
    )
    $accent = @(
        [System.Drawing.Color]::FromArgb(42, 194, 211),
        [System.Drawing.Color]::FromArgb(137, 96, 212),
        [System.Drawing.Color]::FromArgb(241, 125, 105),
        [System.Drawing.Color]::FromArgb(92, 70, 170),
        [System.Drawing.Color]::FromArgb(190, 135, 45)
    )

    for ($i = 0; $i -lt $sources.Count; $i++) {
        $sourcePath = Resolve-RepoPath $sources[$i].Path
        if (!(Test-Path $sourcePath)) { throw "Missing support source: $($sources[$i].Path)" }
        $source = [System.Drawing.Bitmap]::FromFile($sourcePath)
        try {
        $x = 16 + ($i * 184)
        $y = 52
        $card = [System.Drawing.Rectangle]::new($x, $y, 136, 136)
        $cardBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
        $cardPen = [System.Drawing.Pen]::new($accent[$i], 2)
        try {
            $graphics.FillRectangle($cardBrush, $card)
            $graphics.DrawRectangle($cardPen, $card)
            if ($null -eq $sources[$i].Crop) {
                if ($source.Width -ne 128 -or $source.Height -ne 128) { throw "Expected exact 128x128 source: $($sources[$i].Path)" }
                $graphics.DrawImage($source, [System.Drawing.Rectangle]::new($x + 4, $y + 4, 128, 128))
            } else {
                $crop = $sources[$i].Crop
                $graphics.DrawImage($source, [System.Drawing.Rectangle]::new($x + 4, $y + 4, 128, 128), $crop, [System.Drawing.GraphicsUnit]::Pixel)
            }
            $graphics.DrawString($sources[$i].Id, $labelFont, $ink, $x + 3, 194)
        } finally {
            $cardBrush.Dispose()
            $cardPen.Dispose()
        }
        } finally {
            $source.Dispose()
        }
    }

    $output.Save($outputFull, [System.Drawing.Imaging.ImageFormat]::Png)
    [pscustomobject]@{
        Output = $OutputPath
        Dimensions = '960x214'
        Source = 'CH101/CH102 exact Face128 boards plus CH103/CH104/CH105 Face128 support boards'
        CropSize = 'Support-board face crop -> exact 128x128 display'
        Status = 'REVIEW ONLY'
    }
} finally {
    $line.Dispose()
    $muted.Dispose()
    $ink.Dispose()
    $white.Dispose()
    $smallFont.Dispose()
    $labelFont.Dispose()
    $titleFont.Dispose()
    $graphics.Dispose()
    $output.Dispose()
}
