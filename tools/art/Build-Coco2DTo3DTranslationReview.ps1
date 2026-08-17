[CmdletBinding()]
param(
    [string]$ProjectRoot,
    [string]$KeyArtPath = 'art_refs/characters/coco/concept/Coco_KeyArt_REVIEW_v002.png',
    [string]$Reference3DPath = 'art_refs/characters/coco/3d_reference/Coco_3DReference_REVIEW_v001.png',
    [string]$OutputPath = 'art_refs/characters/coco/3d_reference/Coco_2DTo3DTranslation_REVIEW_v001.png',
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

if ([string]::IsNullOrWhiteSpace($ProjectRoot)) { $ProjectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..')) }
else { $ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot) }

function Resolve-In([string]$Path) {
    $candidate = if ([IO.Path]::IsPathRooted($Path)) { $Path } else { Join-Path $ProjectRoot $Path }
    return (Resolve-Path -LiteralPath $candidate -ErrorAction Stop).Path
}
function Resolve-Out([string]$Path) {
    if ([IO.Path]::IsPathRooted($Path)) { return [IO.Path]::GetFullPath($Path) }
    return [IO.Path]::GetFullPath((Join-Path $ProjectRoot $Path))
}
function C([string]$Hex) { return [Drawing.ColorTranslator]::FromHtml($Hex) }
function F([float]$Size,[Drawing.FontStyle]$Style=[Drawing.FontStyle]::Regular) {
    try { return [Drawing.Font]::new('Segoe UI',$Size,$Style,[Drawing.GraphicsUnit]::Pixel) }
    catch { return [Drawing.Font]::new([Drawing.FontFamily]::GenericSansSerif,$Size,$Style,[Drawing.GraphicsUnit]::Pixel) }
}
function Init-G([Drawing.Graphics]$G) {
    $G.SmoothingMode=[Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $G.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $G.PixelOffsetMode=[Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $G.CompositingQuality=[Drawing.Drawing2D.CompositingQuality]::HighQuality
    $G.TextRenderingHint=[Drawing.Text.TextRenderingHint]::AntiAliasGridFit
}
function Draw-Text([Drawing.Graphics]$G,[string]$Text,[Drawing.Font]$Font,[Drawing.Brush]$Brush,[Drawing.RectangleF]$Rect,[Drawing.StringAlignment]$Align=[Drawing.StringAlignment]::Near,[Drawing.StringAlignment]$Line=[Drawing.StringAlignment]::Near) {
    $sf=[Drawing.StringFormat]::new()
    try { $sf.Alignment=$Align;$sf.LineAlignment=$Line;$sf.Trimming=[Drawing.StringTrimming]::EllipsisCharacter;$G.DrawString($Text,$Font,$Brush,$Rect,$sf) }
    finally { $sf.Dispose() }
}
function Draw-Chip([Drawing.Graphics]$G,[string]$Text,[Drawing.RectangleF]$Rect,[Drawing.Color]$Color,[Drawing.Font]$Font) {
    $fill=[Drawing.SolidBrush]::new([Drawing.Color]::FromArgb(50,$Color));$pen=[Drawing.Pen]::new($Color,2);$brush=[Drawing.SolidBrush]::new([Drawing.Color]::White)
    try { $G.FillRectangle($fill,$Rect);$G.DrawRectangle($pen,$Rect.X,$Rect.Y,$Rect.Width,$Rect.Height);Draw-Text $G $Text $Font $brush $Rect Center Center }
    finally { $brush.Dispose();$pen.Dispose();$fill.Dispose() }
}
function Draw-FigurePanel {
    param(
        [Drawing.Graphics]$G,[Drawing.Image]$Image,[Drawing.RectangleF]$Panel,[Drawing.Rectangle]$Crop,
        [string]$Label,[string]$SubLabel,[int]$Crown,[int]$Chin,[int]$Sole,
        [float]$TargetCrown,[float]$TargetSole,[Drawing.Color]$Accent,
        [Drawing.Font]$LabelFont,[Drawing.Font]$SmallFont,[Drawing.Font]$GuideFont
    )
    $ratio=($Sole-$Crown)/[double]($Chin-$Crown);$scale=($TargetSole-$TargetCrown)/[double]($Sole-$Crown)
    $dw=$Crop.Width*$scale;$dh=$Crop.Height*$scale;$dx=$Panel.X+($Panel.Width-$dw)/2.0;$dy=$TargetCrown-($Crown-$Crop.Y)*$scale
    $panelBrush=[Drawing.SolidBrush]::new((C '#0A1423'));$border=[Drawing.Pen]::new((C '#2A3E57'),2);$accentBrush=[Drawing.SolidBrush]::new($Accent);$white=[Drawing.SolidBrush]::new((C '#F4FAFF'));$muted=[Drawing.SolidBrush]::new((C '#91A6BB'));$guide=[Drawing.Pen]::new([Drawing.Color]::FromArgb(175,$Accent),1.6);$guideBrush=[Drawing.SolidBrush]::new($Accent)
    try {
        $G.FillRectangle($panelBrush,$Panel);$G.DrawRectangle($border,$Panel.X,$Panel.Y,$Panel.Width,$Panel.Height);$G.FillRectangle($accentBrush,$Panel.X+18,$Panel.Y+20,7,49)
        Draw-Text $G $Label $LabelFont $white ([Drawing.RectangleF]::new($Panel.X+42,$Panel.Y+16,$Panel.Width-60,36))
        Draw-Text $G $SubLabel $SmallFont $muted ([Drawing.RectangleF]::new($Panel.X+42,$Panel.Y+51,$Panel.Width-60,30))
        $oldClip=$G.Clip
        try { $G.SetClip([Drawing.RectangleF]::new($Panel.X+2,$Panel.Y+84,$Panel.Width-4,$Panel.Height-86));$dest=[Drawing.Rectangle]::new([int][Math]::Round($dx),[int][Math]::Round($dy),[int][Math]::Round($dw),[int][Math]::Round($dh));$G.DrawImage($Image,$dest,$Crop.X,$Crop.Y,$Crop.Width,$Crop.Height,[Drawing.GraphicsUnit]::Pixel) }
        finally { $G.Clip=$oldClip;$oldClip.Dispose() }
        $step=($TargetSole-$TargetCrown)/$ratio
        for($i=0;$i -le [Math]::Floor($ratio);$i++) { $y=$TargetCrown+$i*$step;$guide.DashStyle=if($i-eq0){[Drawing.Drawing2D.DashStyle]::Solid}else{[Drawing.Drawing2D.DashStyle]::Dash};$G.DrawLine($guide,$Panel.X+12,$y,$Panel.Right-12,$y);Draw-Text $G ("${i}H") $GuideFont $guideBrush ([Drawing.RectangleF]::new($Panel.Right-58,$y-18,42,24)) Far Center }
        $guide.DashStyle=[Drawing.Drawing2D.DashStyle]::Solid;$G.DrawLine($guide,$Panel.X+12,$TargetSole,$Panel.Right-12,$TargetSole);Draw-Text $G (('{0:F2}H' -f $ratio)) $GuideFont $guideBrush ([Drawing.RectangleF]::new($Panel.Right-90,$TargetSole-23,72,24)) Far Center
    }
    finally { $guideBrush.Dispose();$guide.Dispose();$muted.Dispose();$white.Dispose();$accentBrush.Dispose();$border.Dispose();$panelBrush.Dispose() }
}
function Draw-Card([Drawing.Graphics]$G,[string]$Title,[string[]]$Lines,[Drawing.RectangleF]$Rect,[Drawing.Color]$Accent,[Drawing.Font]$TitleFont,[Drawing.Font]$BodyFont) {
    $fill=[Drawing.SolidBrush]::new((C '#111B2B'));$border=[Drawing.Pen]::new((C '#2D415A'),1.5);$accentBrush=[Drawing.SolidBrush]::new($Accent);$white=[Drawing.SolidBrush]::new((C '#F4FAFF'));$muted=[Drawing.SolidBrush]::new((C '#B5C7D8'))
    try {
        $G.FillRectangle($fill,$Rect);$G.DrawRectangle($border,$Rect.X,$Rect.Y,$Rect.Width,$Rect.Height);$G.FillRectangle($accentBrush,$Rect.X,$Rect.Y,6,$Rect.Height)
        Draw-Text $G $Title $TitleFont $white ([Drawing.RectangleF]::new($Rect.X+22,$Rect.Y+12,$Rect.Width-38,28))
        $y=$Rect.Y+47;foreach($line in $Lines){Draw-Text $G ('- '+$line) $BodyFont $muted ([Drawing.RectangleF]::new($Rect.X+24,$y,$Rect.Width-42,26));$y+=27}
    }
    finally { $muted.Dispose();$white.Dispose();$accentBrush.Dispose();$border.Dispose();$fill.Dispose() }
}

$keyPath=Resolve-In $KeyArtPath;$refPath=Resolve-In $Reference3DPath;$outPath=Resolve-Out $OutputPath
if([IO.File]::Exists($outPath)-and-not$Force){throw "Output exists: $outPath. Use -Force."}
$dir=Split-Path -Parent $outPath;if(-not[IO.Directory]::Exists($dir)){[IO.Directory]::CreateDirectory($dir)|Out-Null}
$key=[Drawing.Bitmap]::FromFile($keyPath);$ref=[Drawing.Bitmap]::FromFile($refPath)
if($key.Width-ne864-or$key.Height-ne1821){throw 'KeyArt dimensions changed.'}
if($ref.Width-ne1659-or$ref.Height-ne948){throw '3D reference dimensions changed.'}
$o=[Drawing.Bitmap]::new(2048,1440,[Drawing.Imaging.PixelFormat]::Format24bppRgb);$g=[Drawing.Graphics]::FromImage($o)
$title=F 38 ([Drawing.FontStyle]::Bold);$sub=F 17;$panelTitle=F 25 ([Drawing.FontStyle]::Bold);$small=F 15;$chip=F 16 ([Drawing.FontStyle]::Bold);$guideFont=F 13 ([Drawing.FontStyle]::Bold);$cardTitle=F 18 ([Drawing.FontStyle]::Bold);$cardBody=F 15;$status=F 18 ([Drawing.FontStyle]::Bold);$statusSmall=F 15
try {
    Init-G $g;$bg=[Drawing.Drawing2D.LinearGradientBrush]::new([Drawing.Rectangle]::new(0,0,2048,1440),(C '#07111F'),(C '#0B1B2B'),25);$white=[Drawing.SolidBrush]::new((C '#F4FAFF'));$muted=[Drawing.SolidBrush]::new((C '#8EA5BA'));$line=[Drawing.Pen]::new((C '#1B3E56'),2)
    try {
        $g.FillRectangle($bg,0,0,2048,1440);$g.DrawLine($line,42,105,2006,105)
        Draw-Text $g 'COCO / 2D TO 3D TRANSLATION' $title $white ([Drawing.RectangleF]::new(48,24,820,52))
        Draw-Text $g 'REVIEW v001 / height-normalized handoff for the rescue captain identity' $sub $muted ([Drawing.RectangleF]::new(50,75,900,26))
        Draw-Chip $g '2D 7.10H / PASS' ([Drawing.RectangleF]::new(1035,33,245,48)) (C '#35E9B7') $chip
        Draw-Chip $g '3D 5.55H / CONCEPT PASS' ([Drawing.RectangleF]::new(1295,33,305,48)) (C '#F7B95A') $chip
        Draw-Chip $g 'APPROVAL / PENDING' ([Drawing.RectangleF]::new(1615,33,370,48)) (C '#E67A66') $chip
        Draw-FigurePanel $g $key ([Drawing.RectangleF]::new(44,126,604,1042)) ([Drawing.Rectangle]::new(0,0,864,1821)) '2D KEY ART' '7.10H / adult feminine detail source' 160 340 1438 300 1000 (C '#35E9B7') $panelTitle $small $guideFont
        Draw-FigurePanel $g $ref ([Drawing.RectangleF]::new(670,126,604,1042)) ([Drawing.Rectangle]::new(500,0,620,830)) '3D STYLE REFERENCE' '5.55H concept / compact gameplay mass' 10 145 759 300 1000 (C '#F7B95A') $panelTitle $small $guideFont
        Draw-Card $g 'IDENTITY LOCK' @('coral side braid -> low wavy pony','short angular coral half-cape','ivory / charcoal / jade rescue suit') ([Drawing.RectangleF]::new(1302,126,702,156)) (C '#35E9B7') $cardTitle $cardBody
        Draw-Card $g 'EXPAND' @('head, eyes, hands and boots','braid mass + cape triangle','baton grip + jade chamber') ([Drawing.RectangleF]::new(1302,296,702,156)) (C '#79D7C7') $cardTitle $cardBody
        Draw-Card $g 'DELETE' @('micro ampoules and tiny hardware','excess straps, seams and stitches','2D long-leg fashion exaggeration') ([Drawing.RectangleF]::new(1302,466,702,156)) (C '#E67A66') $cardTitle $cardBody
        Draw-Card $g 'COMBINE' @('belts + harness into one hierarchy','pack modules into a compact waist mass','projector into one readable device') ([Drawing.RectangleF]::new(1302,636,702,156)) (C '#A78BFA') $cardTitle $cardBody
        Draw-Card $g 'PHYSICS / VFX' @('simulate pony/braid tips + cape only','clamp motion away from face and baton','shield is transparent VFX; never rigid gear') ([Drawing.RectangleF]::new(1302,806,702,156)) (C '#F09A78') $cardTitle $cardBody
        Draw-Card $g 'NEXT MODEL GATE' @('Blender front/rear/gameplay-quarter proof','Humanoid joints + grip/socket proof','rig, camera and animation: NOT TESTED') ([Drawing.RectangleF]::new(1302,976,702,192)) (C '#8FA8BD') $cardTitle $cardBody
        $sr=[Drawing.RectangleF]::new(44,1194,1960,196);$sf=[Drawing.SolidBrush]::new((C '#08121F'));$sp=[Drawing.Pen]::new((C '#28445C'),1.5);$amber=[Drawing.SolidBrush]::new((C '#F7B95A'))
        try{$g.FillRectangle($sf,$sr);$g.DrawRectangle($sp,$sr.X,$sr.Y,$sr.Width,$sr.Height);Draw-Text $g 'REVIEW ONLY / HUMAN APPROVAL NOT GRANTED' $status $amber ([Drawing.RectangleF]::new(70,1218,820,32));Draw-Text $g '2D ratio gate: PASS 7.10H. 3D reference: concept-space PASS 5.55H only.' $statusSmall $white ([Drawing.RectangleF]::new(70,1265,1000,28));Draw-Text $g 'Blender mesh, Humanoid rig, joint clearance, gameplay camera, animation and sockets remain NOT TESTED.' $statusSmall $muted ([Drawing.RectangleF]::new(70,1302,1300,28));Draw-Text $g 'No medical cross / no nurse costume / no opaque physical shield' $statusSmall $amber ([Drawing.RectangleF]::new(70,1339,1100,28));Draw-Text $g 'Deterministic composite: tools/art/Build-Coco2DTo3DTranslationReview.ps1' $statusSmall $muted ([Drawing.RectangleF]::new(1230,1340,720,28))}
        finally{$amber.Dispose();$sp.Dispose();$sf.Dispose()}
    }
    finally{$line.Dispose();$muted.Dispose();$white.Dispose();$bg.Dispose()}
    $o.Save($outPath,[Drawing.Imaging.ImageFormat]::Png)
    [pscustomobject]@{Output=$outPath;Dimensions='2048x1440';TwoDHeads=7.10;ThreeDHeads=5.55;Status='REVIEW ONLY';HumanApproval='NOT GRANTED';ImplementationProof='NOT TESTED'}
}
finally{$statusSmall.Dispose();$status.Dispose();$cardBody.Dispose();$cardTitle.Dispose();$guideFont.Dispose();$chip.Dispose();$small.Dispose();$panelTitle.Dispose();$sub.Dispose();$title.Dispose();$g.Dispose();$o.Dispose();$ref.Dispose();$key.Dispose()}
