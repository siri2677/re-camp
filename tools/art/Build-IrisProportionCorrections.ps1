[CmdletBinding()]
param(
    [string]$ProjectRoot,
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing

if([string]::IsNullOrWhiteSpace($ProjectRoot)){$ProjectRoot=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))}else{$ProjectRoot=[IO.Path]::GetFullPath($ProjectRoot)}
function Resolve-In([string]$Path){$p=if([IO.Path]::IsPathRooted($Path)){$Path}else{Join-Path $ProjectRoot $Path};return (Resolve-Path -LiteralPath $p -ErrorAction Stop).Path}
function Resolve-Out([string]$Path){if([IO.Path]::IsPathRooted($Path)){return [IO.Path]::GetFullPath($Path)};return [IO.Path]::GetFullPath((Join-Path $ProjectRoot $Path))}

function Compress-Proportion {
    param(
        [string]$SourcePath,[string]$OutputPath,[int]$ExpectedWidth,[int]$ExpectedHeight,
        [int]$CrownY,[int]$ChinY,[int]$SourceSoleY,[double]$TargetHeads,[bool]$StretchTail
    )
    $source=[Drawing.Bitmap]::FromFile((Resolve-In $SourcePath));$output=$null;$g=$null
    try{
        if($source.Width-ne$ExpectedWidth-or$source.Height-ne$ExpectedHeight){throw "Expected ${ExpectedWidth}x${ExpectedHeight} source, got $($source.Width)x$($source.Height): $SourcePath"}
        if($CrownY-lt0-or$ChinY-le$CrownY-or$SourceSoleY-le$ChinY-or$SourceSoleY-ge$source.Height){throw "Invalid landmarks: $SourcePath"}
        $head=$ChinY-$CrownY;$targetSole=[int][Math]::Round($CrownY+$head*$TargetHeads);$sourceBody=$SourceSoleY-$ChinY;$targetBody=$targetSole-$ChinY
        $output=[Drawing.Bitmap]::new($source.Width,$source.Height,[Drawing.Imaging.PixelFormat]::Format24bppRgb);$g=[Drawing.Graphics]::FromImage($output)
        $g.CompositingMode=[Drawing.Drawing2D.CompositingMode]::SourceCopy;$g.CompositingQuality=[Drawing.Drawing2D.CompositingQuality]::HighQuality;$g.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic;$g.PixelOffsetMode=[Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $bg=[Drawing.SolidBrush]::new($source.GetPixel(8,[Math]::Min($SourceSoleY+2,$source.Height-1)));try{$g.FillRectangle($bg,0,0,$source.Width,$source.Height)}finally{$bg.Dispose()}
        $g.DrawImage($source,[Drawing.Rectangle]::new(0,0,$source.Width,$ChinY),[Drawing.Rectangle]::new(0,0,$source.Width,$ChinY),[Drawing.GraphicsUnit]::Pixel)
        $g.DrawImage($source,[Drawing.Rectangle]::new(0,$ChinY,$source.Width,$targetBody),[Drawing.Rectangle]::new(0,$ChinY,$source.Width,$sourceBody),[Drawing.GraphicsUnit]::Pixel)
        if($StretchTail){$g.DrawImage($source,[Drawing.Rectangle]::new(0,$targetSole,$source.Width,$source.Height-$targetSole),[Drawing.Rectangle]::new(0,$SourceSoleY,$source.Width,$source.Height-$SourceSoleY),[Drawing.GraphicsUnit]::Pixel)}
        $resolved=Resolve-Out $OutputPath;$dir=Split-Path -Parent $resolved;if(-not[IO.Directory]::Exists($dir)){[IO.Directory]::CreateDirectory($dir)|Out-Null};if([IO.File]::Exists($resolved)-and-not$Force){throw "Output exists: $resolved. Use -Force."};$output.Save($resolved,[Drawing.Imaging.ImageFormat]::Png)
        return [pscustomobject]@{Output=$resolved;Crown=$CrownY;Chin=$ChinY;Sole=$targetSole;Heads=[Math]::Round(($targetSole-$CrownY)/[double]$head,2);BodyVerticalScale=[Math]::Round($targetBody/[double]$sourceBody,4);Status='REVIEW';HumanApproval='Pending';Approved='NOT GRANTED'}
    }
    finally{if($g){$g.Dispose()};if($output){$output.Dispose()};$source.Dispose()}
}

$results=@()
$results+=Compress-Proportion -SourcePath 'art_refs/characters/iris/concept/Iris_KeyArt_REVIEW_v001.png' -OutputPath 'art_refs/characters/iris/concept/Iris_KeyArt_REVIEW_v002.png' -ExpectedWidth 864 -ExpectedHeight 1821 -CrownY 104 -ChinY 270 -SourceSoleY 1742 -TargetHeads 7.30 -StretchTail $true
$results+=Compress-Proportion -SourcePath 'art_refs/characters/iris/turnaround/Iris_Turnaround_REVIEW_v001.png' -OutputPath 'art_refs/characters/iris/turnaround/Iris_Turnaround_REVIEW_v002.png' -ExpectedWidth 1536 -ExpectedHeight 1024 -CrownY 29 -ChinY 135 -SourceSoleY 961 -TargetHeads 7.30 -StretchTail $true
$results+=Compress-Proportion -SourcePath 'art_refs/characters/iris/3d_reference/Iris_3DReference_REVIEW_v001.png' -OutputPath 'art_refs/characters/iris/3d_reference/Iris_3DReference_REVIEW_v002.png' -ExpectedWidth 887 -ExpectedHeight 1774 -CrownY 188 -ChinY 410 -SourceSoleY 1604 -TargetHeads 5.75 -StretchTail $false
$results
