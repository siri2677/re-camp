[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)] [string]$SourcePath,
    [Parameter(Mandatory = $true)] [string]$OutputPath,
    [int]$Step = 50,
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$source = [Drawing.Bitmap]::FromFile((Resolve-Path -LiteralPath $SourcePath).Path)
try {
    if ([IO.File]::Exists($OutputPath) -and -not $Force) {
        throw "Output exists: $OutputPath. Use -Force."
    }
    [IO.Directory]::CreateDirectory((Split-Path -Parent ([IO.Path]::GetFullPath($OutputPath)))) | Out-Null
    $canvas = [Drawing.Bitmap]::new($source.Width, $source.Height, [Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [Drawing.Graphics]::FromImage($canvas)
    $minor = [Drawing.Pen]::new([Drawing.Color]::FromArgb(100, 255, 255, 255), 1)
    $major = [Drawing.Pen]::new([Drawing.Color]::FromArgb(190, 255, 80, 80), 2)
    $labelBrush = [Drawing.SolidBrush]::new([Drawing.Color]::FromArgb(230, 255, 230, 80))
    $font = [Drawing.Font]::new('Segoe UI', 14, [Drawing.FontStyle]::Bold, [Drawing.GraphicsUnit]::Pixel)
    try {
        $graphics.DrawImageUnscaled($source, 0, 0)
        for ($x = 0; $x -lt $source.Width; $x += $Step) {
            $pen = if (($x % ($Step * 2)) -eq 0) { $major } else { $minor }
            $graphics.DrawLine($pen, $x, 0, $x, $source.Height)
            if (($x % ($Step * 2)) -eq 0) { $graphics.DrawString("x$x", $font, $labelBrush, $x + 2, 2) }
        }
        for ($y = 0; $y -lt $source.Height; $y += $Step) {
            $pen = if (($y % ($Step * 2)) -eq 0) { $major } else { $minor }
            $graphics.DrawLine($pen, 0, $y, $source.Width, $y)
            if (($y % ($Step * 2)) -eq 0) { $graphics.DrawString("y$y", $font, $labelBrush, 2, $y + 2) }
        }
        $canvas.Save($OutputPath, [Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $font.Dispose()
        $labelBrush.Dispose()
        $major.Dispose()
        $minor.Dispose()
        $graphics.Dispose()
        $canvas.Dispose()
    }
}
finally { $source.Dispose() }

[pscustomobject]@{ Source=$SourcePath; Output=$OutputPath; Step=$Step }
