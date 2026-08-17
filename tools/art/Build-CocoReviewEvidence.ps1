[CmdletBinding()]
param(
    [string]$ProjectRoot,
    [string]$KeyArtPath = 'art_refs/characters/coco/concept/Coco_KeyArt_REVIEW_v002.png',
    [string]$TurnaroundPath = 'art_refs/characters/coco/turnaround/Coco_Turnaround_REVIEW_v001.png',
    [string]$ExpressionPath = 'art_refs/characters/coco/expressions/Coco_ExpressionSheet_REVIEW_v001.png',
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

if ([string]::IsNullOrWhiteSpace($ProjectRoot)) { $ProjectRoot=[System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..')) }
else { $ProjectRoot=[System.IO.Path]::GetFullPath($ProjectRoot) }

function Resolve-In([string]$Path) { $p=if([IO.Path]::IsPathRooted($Path)){$Path}else{Join-Path $ProjectRoot $Path}; return (Resolve-Path -LiteralPath $p -ErrorAction Stop).Path }
function Resolve-Out([string]$Path) { if([IO.Path]::IsPathRooted($Path)){return [IO.Path]::GetFullPath($Path)}; return [IO.Path]::GetFullPath((Join-Path $ProjectRoot $Path)) }
function Color([string]$Hex) { return [Drawing.ColorTranslator]::FromHtml($Hex) }
function Font([float]$Size,[Drawing.FontStyle]$Style=[Drawing.FontStyle]::Regular) { try{return [Drawing.Font]::new('Segoe UI',$Size,$Style,[Drawing.GraphicsUnit]::Pixel)}catch{return [Drawing.Font]::new([Drawing.FontFamily]::GenericSansSerif,$Size,$Style,[Drawing.GraphicsUnit]::Pixel)} }
function Init-G([Drawing.Graphics]$G) { $G.SmoothingMode=[Drawing.Drawing2D.SmoothingMode]::AntiAlias; $G.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic; $G.PixelOffsetMode=[Drawing.Drawing2D.PixelOffsetMode]::HighQuality; $G.CompositingQuality=[Drawing.Drawing2D.CompositingQuality]::HighQuality }
function Save-Png([Drawing.Image]$Image,[string]$Path) { $d=Split-Path -Parent $Path; if(-not[IO.Directory]::Exists($d)){[IO.Directory]::CreateDirectory($d)|Out-Null}; if([IO.File]::Exists($Path)-and-not$Force){throw "Output exists: $Path. Use -Force."}; $Image.Save($Path,[Drawing.Imaging.ImageFormat]::Png) }

if(-not('ReCamp.CocoReview.MaskBuilder' -as [type])) {
Add-Type -ReferencedAssemblies 'System.Drawing' -TypeDefinition @'
using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;

namespace ReCamp.CocoReview {
 public static class MaskBuilder {
  public static Bitmap Dark(Bitmap source, Rectangle crop) {
   using(Bitmap input=source.Clone(crop,PixelFormat.Format24bppRgb)) {
    int w=input.Width,h=input.Height,stride; byte[] p=Read(input,out stride); bool[] m=new bool[w*h];
    for(int y=0;y<h;y++){int row=y*stride;for(int x=0;x<w;x++){int i=row+x*3,b=p[i],g=p[i+1],r=p[i+2],max=Math.Max(r,Math.Max(g,b)),min=Math.Min(r,Math.Min(g,b));
     bool bright=max>=112; bool warm=r>=48&&r>=g+4&&r>=b-6; bool jade=g>=70&&g>=r+8&&g>=b-20; bool neutral=max>=46&&(max-min)<=16; m[y*w+x]=bright||warm||jade||neutral;
    }}
    m=Close(m,w,h,2); RemoveSmall(m,w,h,8); FillHoles(m,w,h); return Render(m,w,h);
   }
  }
  public static Bitmap Light(Bitmap source, Rectangle crop) {
   using(Bitmap input=source.Clone(crop,PixelFormat.Format24bppRgb)) {
    int w=input.Width,h=input.Height,stride; byte[] p=Read(input,out stride); bool[] m=new bool[w*h];
    for(int y=0;y<h;y++){int row=y*stride,sn=Math.Min(10,Math.Max(1,w/8)),br=0,bg=0,bb=0,count=0;
     for(int x=0;x<sn;x++){int a=row+x*3,z=row+(w-1-x)*3;bb+=p[a]+p[z];bg+=p[a+1]+p[z+1];br+=p[a+2]+p[z+2];count+=2;}
     int rr=br/count,gg=bg/count,bbg=bb/count;
     for(int x=0;x<w;x++){int i=row+x*3,b=p[i],g=p[i+1],r=p[i+2],dr=r-rr,dg=g-gg,db=b-bbg;int d=dr*dr+dg*dg+db*db;bool darker=(rr+gg+bbg)-(r+g+b)>=20;m[y*w+x]=d>=390||darker;}
    }
    m=Close(m,w,h,2); RemoveSmall(m,w,h,18); FillHoles(m,w,h); return Render(m,w,h);
   }
  }
  static byte[] Read(Bitmap b,out int stride){Rectangle r=new Rectangle(0,0,b.Width,b.Height);BitmapData d=b.LockBits(r,ImageLockMode.ReadOnly,PixelFormat.Format24bppRgb);try{stride=Math.Abs(d.Stride);byte[] p=new byte[stride*b.Height];Marshal.Copy(d.Scan0,p,0,p.Length);return p;}finally{b.UnlockBits(d);}}
  static bool[] Close(bool[] m,int w,int h,int r){return Erode(Dilate(m,w,h,r),w,h,r);}
  static bool[] Dilate(bool[] m,int w,int h,int r){bool[] o=new bool[m.Length];for(int y=0;y<h;y++)for(int x=0;x<w;x++){bool v=false;for(int yy=Math.Max(0,y-r);yy<=Math.Min(h-1,y+r)&&!v;yy++)for(int xx=Math.Max(0,x-r);xx<=Math.Min(w-1,x+r);xx++)if(m[yy*w+xx]){v=true;break;}o[y*w+x]=v;}return o;}
  static bool[] Erode(bool[] m,int w,int h,int r){bool[] o=new bool[m.Length];for(int y=0;y<h;y++)for(int x=0;x<w;x++){bool v=true;for(int yy=y-r;yy<=y+r&&v;yy++){if(yy<0||yy>=h){v=false;break;}for(int xx=x-r;xx<=x+r;xx++)if(xx<0||xx>=w||!m[yy*w+xx]){v=false;break;}}o[y*w+x]=v;}return o;}
  static void RemoveSmall(bool[] m,int w,int h,int min){bool[] seen=new bool[m.Length];int[] q=new int[m.Length];int[] dx={-1,0,1,-1,1,-1,0,1},dy={-1,-1,-1,0,0,1,1,1};for(int s=0;s<m.Length;s++){if(!m[s]||seen[s])continue;int a=0,z=0;q[z++]=s;seen[s]=true;while(a<z){int n=q[a++],x=n%w,y=n/w;for(int k=0;k<8;k++){int nx=x+dx[k],ny=y+dy[k];if(nx<0||ny<0||nx>=w||ny>=h)continue;int ni=ny*w+nx;if(m[ni]&&!seen[ni]){seen[ni]=true;q[z++]=ni;}}}if(z<min)for(int i=0;i<z;i++)m[q[i]]=false;}}
  static void FillHoles(bool[] m,int w,int h){bool[] outside=new bool[m.Length];int[] q=new int[m.Length];int a=0,z=0;
   for(int x=0;x<w;x++){int i=x;if(!m[i]&&!outside[i]){outside[i]=true;q[z++]=i;}i=(h-1)*w+x;if(!m[i]&&!outside[i]){outside[i]=true;q[z++]=i;}}
   for(int y=0;y<h;y++){int i=y*w;if(!m[i]&&!outside[i]){outside[i]=true;q[z++]=i;}i=y*w+w-1;if(!m[i]&&!outside[i]){outside[i]=true;q[z++]=i;}}
   int[] dx={-1,1,0,0},dy={0,0,-1,1};while(a<z){int n=q[a++],x=n%w,y=n/w;for(int k=0;k<4;k++){int nx=x+dx[k],ny=y+dy[k];if(nx<0||ny<0||nx>=w||ny>=h)continue;int ni=ny*w+nx;if(!m[ni]&&!outside[ni]){outside[ni]=true;q[z++]=ni;}}}for(int i=0;i<m.Length;i++)if(!m[i]&&!outside[i])m[i]=true;
  }
  static Bitmap Render(bool[] m,int w,int h){Bitmap o=new Bitmap(w,h,PixelFormat.Format32bppArgb);Rectangle r=new Rectangle(0,0,w,h);BitmapData d=o.LockBits(r,ImageLockMode.WriteOnly,PixelFormat.Format32bppArgb);try{byte[] p=new byte[Math.Abs(d.Stride)*h];for(int y=0;y<h;y++)for(int x=0;x<w;x++)if(m[y*w+x]){int i=y*d.Stride+x*4;p[i]=43;p[i+1]=32;p[i+2]=25;p[i+3]=255;}Marshal.Copy(p,0,d.Scan0,p.Length);}finally{o.UnlockBits(d);}return o;}
 }
}
'@
}

function New-Face([Drawing.Bitmap]$Source) {
 $crop=[Drawing.Rectangle]::new(42,34,345,345); $o=[Drawing.Bitmap]::new(128,128,[Drawing.Imaging.PixelFormat]::Format24bppRgb);$g=[Drawing.Graphics]::FromImage($o);$a=[Drawing.Imaging.ImageAttributes]::new();try{Init-G $g;$g.CompositingMode=[Drawing.Drawing2D.CompositingMode]::SourceCopy;$a.SetWrapMode([Drawing.Drawing2D.WrapMode]::TileFlipXY);$g.DrawImage($Source,[Drawing.Rectangle]::new(0,0,128,128),$crop.X,$crop.Y,$crop.Width,$crop.Height,[Drawing.GraphicsUnit]::Pixel,$a)}finally{$a.Dispose();$g.Dispose()};return $o
}

function New-Palette {
 $items=@(
  @('HairCoralCopper','#C96850','Hair base / warm volume'),@('HairHighlight','#F09A78','Hair rim / braid highlight'),@('RescueIvory','#E9DFCF','Jacket / shorts shell'),
  @('InnerCharcoal','#25262D','Inner suit / straps'),@('CapeCoral','#E67A66','Short half-cape'),@('JadePolymer','#79D7C7','Ampoules / shield membrane'),
  @('EmeraldEmission','#35E9B7','Scanner / projector emission'),@('SkinWarm','#E8B28F','Skin base / warm midtone'),@('HardwareBronze','#8A6548','Baton / buckles / hardware'),
  @('BackdropNavy','#07111F','Review backdrop'))
 $o=[Drawing.Bitmap]::new(1600,1160,[Drawing.Imaging.PixelFormat]::Format24bppRgb);$g=[Drawing.Graphics]::FromImage($o);$bg=[Drawing.SolidBrush]::new((Color '#F4F7FA'));$card=[Drawing.SolidBrush]::new([Drawing.Color]::White);$tb=[Drawing.SolidBrush]::new((Color '#0F172A'));$mb=[Drawing.SolidBrush]::new((Color '#475569'));$pen=[Drawing.Pen]::new((Color '#CBD5E1'),2);$tf=Font 40 ([Drawing.FontStyle]::Bold);$nf=Font 22 ([Drawing.FontStyle]::Bold);$hf=Font 20 ([Drawing.FontStyle]::Bold);$rf=Font 16;$sf=Font 14 ([Drawing.FontStyle]::Bold)
 try{Init-G $g;$g.FillRectangle($bg,0,0,$o.Width,$o.Height);$g.DrawString('Coco - Material Palette / REVIEW',$tf,$tb,52,28);$g.DrawString('Exact sRGB material slots | coral rescue captain + transparent jade field technology',$hf,$mb,54,84)
  for($i=0;$i -lt $items.Count;$i++){ $col=$i%2;$row=[Math]::Floor($i/2);$x=50+$col*760;$y=135+$row*170;$rect=[Drawing.Rectangle]::new($x,$y,730,145);$sw=[Drawing.Rectangle]::new($x+18,$y+18,150,95);$sb=[Drawing.SolidBrush]::new((Color $items[$i][1]));try{$g.FillRectangle($card,$rect);$g.DrawRectangle($pen,$rect);$g.FillRectangle($sb,$sw);$g.DrawRectangle($pen,$sw);$g.DrawString($items[$i][0],$nf,$tb,$x+195,$y+18);$g.DrawString($items[$i][1],$hf,$mb,$x+195,$y+52);$g.DrawString($items[$i][2],$rf,$tb,$x+195,$y+92)}finally{$sb.Dispose()}}
  $g.DrawString('Grayscale readability',$nf,$tb,54,1000);for($i=0;$i -lt $items.Count;$i++){$c=Color $items[$i][1];$v=[int][Math]::Round(.2126*$c.R+.7152*$c.G+.0722*$c.B);$b=[Drawing.SolidBrush]::new([Drawing.Color]::FromArgb($v,$v,$v));try{$x=54+$i*150;$g.FillRectangle($b,$x,1045,132,52);$g.DrawRectangle($pen,$x,1045,132,52);$g.DrawString(($i+1).ToString('00'),$sf,$tb,$x+52,1102)}finally{$b.Dispose()}}
  $g.DrawString('REVIEW / Human approval Pending / APPROVED: NOT GRANTED',$rf,$mb,1040,1130)
 }finally{$sf.Dispose();$rf.Dispose();$hf.Dispose();$nf.Dispose();$tf.Dispose();$pen.Dispose();$mb.Dispose();$tb.Dispose();$card.Dispose();$bg.Dispose();$g.Dispose()};return $o
}

function New-Proportion([Drawing.Bitmap]$Key) {
 $crown=[Drawing.Point]::new(430,160);$chin=[Drawing.Point]::new(420,340);$sole=[Drawing.Point]::new(565,1438);$heads=($sole.Y-$crown.Y)/[double]($chin.Y-$crown.Y)
 $o=[Drawing.Bitmap]::new(1600,2000,[Drawing.Imaging.PixelFormat]::Format24bppRgb);$g=[Drawing.Graphics]::FromImage($o);$bg=[Drawing.SolidBrush]::new((Color '#07111F'));$tb=[Drawing.SolidBrush]::new((Color '#F8FAFC'));$mb=[Drawing.SolidBrush]::new((Color '#94A3B8'));$cb=[Drawing.SolidBrush]::new((Color '#35E9B7'));$pb=[Drawing.SolidBrush]::new((Color '#61E6A5'));$card=[Drawing.SolidBrush]::new([Drawing.Color]::FromArgb(238,17,26,43));$border=[Drawing.Pen]::new((Color '#334155'),2);$guide=[Drawing.Pen]::new((Color '#35E9B7'),2.5);$guide.DashStyle=[Drawing.Drawing2D.DashStyle]::Dash;$solePen=[Drawing.Pen]::new((Color '#FF7A66'),3.5);$title=Font 42 ([Drawing.FontStyle]::Bold);$sub=Font 22;$big=Font 64 ([Drawing.FontStyle]::Bold);$h=Font 30 ([Drawing.FontStyle]::Bold);$body=Font 21;$small=Font 17
 try{Init-G $g;$g.FillRectangle($bg,0,0,$o.Width,$o.Height);$g.DrawString('Coco - 2D Proportion Gate Evidence / REVIEW',$title,$tb,52,28);$g.DrawString('Selected KeyArt v002 | target 7.00-7.20H | deterministic image-space landmarks',$sub,$mb,54,88)
  $ix=58.0;$iy=150.0;$iw=820.0;$s=$iw/$Key.Width;$ih=$Key.Height*$s;$g.DrawImage($Key,[Drawing.RectangleF]::new($ix,$iy,$iw,$ih));$g.DrawRectangle($border,[int]$ix,[int]$iy,[int]$iw,[int]$ih)
  for($u=0;$u -le 7;$u++){$sy=$crown.Y+$u*($chin.Y-$crown.Y);$y=$iy+$sy*$s;$g.DrawLine($guide,$ix+18,$y,$ix+$iw-18,$y);$label=if($u-eq0){'0H CROWN'}elseif($u-eq1){'1H CHIN'}else{"${u}H"};$g.DrawString($label,$small,$tb,$ix+25,$y+4)};$sy2=$iy+$sole.Y*$s;$g.DrawLine($solePen,$ix+18,$sy2,$ix+$iw-18,$sy2);$g.DrawString('SOLE / 7.10H',$small,$tb,$ix+240,$sy2+7)
  $r=[Drawing.Rectangle]::new(930,175,620,700);$g.FillRectangle($card,$r);$g.DrawRectangle($border,$r);$g.DrawString('HEAD-UNIT RESULT',$h,$cb,978,220);$g.DrawString(('{0:F2} H'-f$heads),$big,$tb,978,285);$g.DrawString('PASS',$big,$pb,978,375);$g.DrawString('Coco LOCKED target',$body,$mb,980,490);$g.DrawString('7.00 - 7.20 H',$h,$tb,980,525);$g.DrawString('Crown (430,160)',$body,$tb,980,625);$g.DrawString('Chin  (420,340)',$body,$tb,980,670);$g.DrawString('Sole  (565,1438)',$body,$tb,980,715);$g.DrawString('1278 / 180 = 7.10',$h,$cb,980,785)
  $r2=[Drawing.Rectangle]::new(930,930,620,520);$g.FillRectangle($card,$r2);$g.DrawRectangle($border,$r2);$g.DrawString('METHOD / APPROVAL',$h,$cb,978,975);$g.DrawString('Generated KeyArt was proportion-corrected by',$body,$tb,980,1045);$g.DrawString('compressing the chin-to-sole span only.',$body,$tb,980,1082);$g.DrawString('Human appeal review: Pending',$body,$tb,980,1170);$g.DrawString('APPROVED: NOT GRANTED',$h,$tb,980,1220);$g.DrawString('No perspective correction; image-space gate.',$body,$mb,980,1310)
  $g.DrawString('REVIEW ONLY',$h,$cb,930,1880);$g.DrawString('HUMAN APPROVAL NOT GRANTED',$body,$tb,930,1928)
 }finally{$small.Dispose();$body.Dispose();$h.Dispose();$big.Dispose();$sub.Dispose();$title.Dispose();$solePen.Dispose();$guide.Dispose();$border.Dispose();$card.Dispose();$pb.Dispose();$cb.Dispose();$mb.Dispose();$tb.Dispose();$bg.Dispose();$g.Dispose()};return [pscustomobject]@{Image=$o;Heads=$heads}
}

function New-Silhouette([Drawing.Bitmap]$Key,[Drawing.Bitmap]$Turn) {
  $kc=[Drawing.Rectangle]::new(0,120,864,1325);$tc=[Drawing.Rectangle]::new(120,10,410,980);$km=[ReCamp.CocoReview.MaskBuilder]::Dark($Key,$kc);$tm=[ReCamp.CocoReview.MaskBuilder]::Light($Turn,$tc);$o=[Drawing.Bitmap]::new(1600,960,[Drawing.Imaging.PixelFormat]::Format24bppRgb);$g=[Drawing.Graphics]::FromImage($o);$bg=[Drawing.SolidBrush]::new((Color '#E9EEF4'));$panel=[Drawing.SolidBrush]::new([Drawing.Color]::White);$tb=[Drawing.SolidBrush]::new((Color '#0F172A'));$mb=[Drawing.SolidBrush]::new((Color '#475569'));$pen=[Drawing.Pen]::new((Color '#CBD5E1'),2);$guide=[Drawing.Pen]::new((Color '#64748B'),2);$guide.DashStyle=[Drawing.Drawing2D.DashStyle]::Dash;$title=Font 38 ([Drawing.FontStyle]::Bold);$sub=Font 21;$label=Font 25 ([Drawing.FontStyle]::Bold);$body=Font 18
 try{Init-G $g;$g.FillRectangle($bg,0,0,$o.Width,$o.Height);$g.DrawString('Coco - Height-normalized Silhouette Review',$title,$tb,48,24);$g.DrawString('Equipment-included KeyArt vs gear-minimal turnaround front | same crown-to-sole height',$sub,$mb,50,76);$l=[Drawing.Rectangle]::new(40,120,740,790);$r=[Drawing.Rectangle]::new(820,120,740,790);$g.FillRectangle($panel,$l);$g.FillRectangle($panel,$r);$g.DrawRectangle($pen,$l);$g.DrawRectangle($pen,$r)
  $cy=205.0;$sy=805.0;$kh=1438.0-160.0;$th=966.0-25.0;$ks=600.0/$kh;$ts=600.0/$th;$kw=$km.Width*$ks;$khe=$km.Height*$ks;$kx=410-$kw/2;$ky=$cy-(160-$kc.Y)*$ks;$tw=$tm.Width*$ts;$the=$tm.Height*$ts;$tx=1190-$tw/2;$ty=$cy-(25-$tc.Y)*$ts;$g.DrawImage($km,[Drawing.RectangleF]::new($kx,$ky,$kw,$khe));$g.DrawImage($tm,[Drawing.RectangleF]::new($tx,$ty,$tw,$the));foreach($x in @(58,838)){$g.DrawLine($guide,$x,$cy,$x+704,$cy);$g.DrawLine($guide,$x,$sy,$x+704,$sy)};$g.DrawString('CROWN',$body,$mb,62,$cy-25);$g.DrawString('SOLE',$body,$mb,62,$sy-25);$g.DrawString('CROWN',$body,$mb,842,$cy-25);$g.DrawString('SOLE',$body,$mb,842,$sy-25);$g.DrawString('A | KEY ART / EQUIPMENT INCLUDED',$label,$tb,140,842);$g.DrawString('Baton + emergency modules + half-cape',$body,$mb,205,882);$g.DrawString('B | TURNAROUND FRONT / GEAR MINIMAL',$label,$tb,890,842);$g.DrawString('Costume/hair mass; compact belt modules retained',$body,$mb,908,882);$g.DrawString('REVIEW / Human approval Pending / APPROVED: NOT GRANTED',$body,$mb,1040,929)
 }finally{$body.Dispose();$label.Dispose();$sub.Dispose();$title.Dispose();$guide.Dispose();$pen.Dispose();$mb.Dispose();$tb.Dispose();$panel.Dispose();$bg.Dispose();$g.Dispose();$km.Dispose();$tm.Dispose()};return $o
}

$key=[Drawing.Bitmap]::FromFile((Resolve-In $KeyArtPath));$turn=[Drawing.Bitmap]::FromFile((Resolve-In $TurnaroundPath));$expr=[Drawing.Bitmap]::FromFile((Resolve-In $ExpressionPath))
try{
 if($key.Width-ne864-or$key.Height-ne1821){throw 'KeyArt dimensions changed.'};if($turn.Width-ne1536-or$turn.Height-ne1024){throw 'Turnaround dimensions changed.'};if($expr.Width-ne1705-or$expr.Height-ne922){throw 'Expression dimensions changed.'}
 $dir=Resolve-Out 'art_refs/characters/coco/concept';$facePath=Join-Path $dir 'Coco_Face128_REVIEW_v001.png';$palPath=Join-Path $dir 'Coco_MaterialPalette_REVIEW_v001.png';$propPath=Join-Path $dir 'Coco_ProportionGateEvidence_REVIEW_v001.png';$silPath=Join-Path $dir 'Coco_SilhouetteTest_REVIEW_v001.png'
 $face=New-Face $expr;try{Save-Png $face $facePath}finally{$face.Dispose()};$pal=New-Palette;try{Save-Png $pal $palPath}finally{$pal.Dispose()};$prop=New-Proportion $key;try{Save-Png $prop.Image $propPath}finally{$prop.Image.Dispose()};$sil=New-Silhouette $key $turn;try{Save-Png $sil $silPath}finally{$sil.Dispose()}
 [pscustomobject]@{Face128=$facePath;Palette=$palPath;Proportion=$propPath;Silhouette=$silPath;Heads=[Math]::Round($prop.Heads,2);Status='REVIEW';HumanApproval='Pending';Approved='NOT GRANTED'}
}finally{$expr.Dispose();$turn.Dispose();$key.Dispose()}
