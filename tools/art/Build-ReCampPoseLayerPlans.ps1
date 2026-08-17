[CmdletBinding()]
param(
    [string]$ProjectRoot,
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

if ([string]::IsNullOrWhiteSpace($ProjectRoot)) {
    $ProjectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
}

function Resolve-ProjectPath([string]$RelativePath) {
    [System.IO.Path]::GetFullPath((Join-Path $ProjectRoot $RelativePath))
}
function Color([string]$Hex) { [System.Drawing.ColorTranslator]::FromHtml($Hex) }
function New-Font([float]$Size, [System.Drawing.FontStyle]$Style = [System.Drawing.FontStyle]::Regular) {
    [System.Drawing.Font]::new('Segoe UI', $Size, $Style, [System.Drawing.GraphicsUnit]::Pixel)
}
function Draw-Text {
    param([System.Drawing.Graphics]$Graphics,[string]$Value,[System.Drawing.Font]$Font,[string]$Hex,
        [float]$X,[float]$Y,[float]$Width,[float]$Height,
        [System.Drawing.StringAlignment]$Alignment=[System.Drawing.StringAlignment]::Near)
    $brush=[System.Drawing.SolidBrush]::new((Color $Hex)); $format=[System.Drawing.StringFormat]::new()
    try {
        $format.Alignment=$Alignment; $format.LineAlignment=[System.Drawing.StringAlignment]::Near
        $format.Trimming=[System.Drawing.StringTrimming]::EllipsisCharacter
        $Graphics.DrawString($Value,$Font,$brush,[System.Drawing.RectangleF]::new($X,$Y,$Width,$Height),$format)
    } finally { $brush.Dispose(); $format.Dispose() }
}
function Draw-Panel {
    param([System.Drawing.Graphics]$Graphics,[float]$X,[float]$Y,[float]$Width,[float]$Height,
        [string]$Fill='#101D2C',[string]$Stroke='#29445B')
    $brush=[System.Drawing.SolidBrush]::new((Color $Fill)); $pen=[System.Drawing.Pen]::new((Color $Stroke),2)
    try { $Graphics.FillRectangle($brush,$X,$Y,$Width,$Height); $Graphics.DrawRectangle($pen,$X,$Y,$Width,$Height) }
    finally { $brush.Dispose(); $pen.Dispose() }
}
function Draw-ImageContain {
    param([System.Drawing.Graphics]$Graphics,[System.Drawing.Image]$Image,[System.Drawing.RectangleF]$Rectangle)
    $scale=[Math]::Min($Rectangle.Width/$Image.Width,$Rectangle.Height/$Image.Height)
    $width=[float]($Image.Width*$scale); $height=[float]($Image.Height*$scale)
    $destination=[System.Drawing.RectangleF]::new($Rectangle.X+($Rectangle.Width-$width)/2,$Rectangle.Y+($Rectangle.Height-$height)/2,$width,$height)
    $Graphics.DrawImage($Image,$destination)
}
function Point-In([System.Drawing.RectangleF]$R,[double]$X,[double]$Y) {
    [System.Drawing.PointF]::new([float]($R.X+$R.Width*$X),[float]($R.Y+$R.Height*$Y))
}
function Draw-Bone([System.Drawing.Graphics]$G,[System.Drawing.Pen]$Pen,[System.Drawing.PointF]$A,[System.Drawing.PointF]$B) {
    $G.DrawLine($Pen,$A,$B)
}
function Draw-Joint([System.Drawing.Graphics]$G,[System.Drawing.Brush]$Brush,[System.Drawing.PointF]$P,[float]$Radius=5) {
    $G.FillEllipse($Brush,$P.X-$Radius,$P.Y-$Radius,$Radius*2,$Radius*2)
}
function Draw-PoseDiagram {
    param([System.Drawing.Graphics]$Graphics,[System.Drawing.RectangleF]$Rect,[hashtable]$Pose,[hashtable]$Character,[int]$PoseIndex,
        [System.Drawing.Font]$LabelFont,[System.Drawing.Font]$SmallFont)

    Draw-Panel $Graphics $Rect.X $Rect.Y $Rect.Width $Rect.Height '#E9EFF2' '#4D6879'
    Draw-Text $Graphics $Pose.Label $LabelFont '#183042' ($Rect.X+14) ($Rect.Y+12) ($Rect.Width-28) 30 Center
    Draw-Text $Graphics $Pose.Intent $SmallFont '#536B7A' ($Rect.X+14) ($Rect.Y+46) ($Rect.Width-28) 54 Center
    $stage=[System.Drawing.RectangleF]::new($Rect.X+18,$Rect.Y+105,$Rect.Width-36,$Rect.Height-180)
    $line=[System.Drawing.Pen]::new((Color '#172635'),12); $accent=[System.Drawing.Pen]::new((Color $Character.Accent),6)
    $joint=[System.Drawing.SolidBrush]::new((Color '#172635')); $soft=[System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(165,(Color $Character.Accent)),4)
    $soft.DashStyle=[System.Drawing.Drawing2D.DashStyle]::Dash
    try {
        $p=@{}
        foreach($name in $Pose.Keys){ if($Pose[$name] -is [object[]] -and $Pose[$name].Count -eq 2){$p[$name]=Point-In $stage $Pose[$name][0] $Pose[$name][1]} }
        $headRadius=[float]($stage.Width*0.095)
        $Graphics.DrawEllipse($line,$p.Head.X-$headRadius,$p.Head.Y-$headRadius,$headRadius*2,$headRadius*2)
        foreach($pair in @(@('Neck','Pelvis'),@('ShoulderL','ShoulderR'),@('HipL','HipR'),@('ShoulderL','ElbowL'),@('ElbowL','WristL'),@('ShoulderR','ElbowR'),@('ElbowR','WristR'),@('HipL','KneeL'),@('KneeL','AnkleL'),@('HipR','KneeR'),@('KneeR','AnkleR'))){Draw-Bone $Graphics $line $p[$pair[0]] $p[$pair[1]]}
        foreach($n in @('ShoulderL','ShoulderR','ElbowL','ElbowR','WristL','WristR','HipL','HipR','KneeL','KneeR','AnkleL','AnkleR')){Draw-Joint $Graphics $joint $p[$n] 5}

        switch($Character.Id) {
            'Luna' {
                if($PoseIndex -eq 0){$Graphics.DrawArc($accent,$p.Head.X-$headRadius*1.35,$p.Head.Y-$headRadius*1.5,$headRadius*2.7,$headRadius*1.1,195,150)}
                elseif($PoseIndex -eq 1){Draw-Bone $Graphics $accent (Point-In $stage 0.05 0.52) $p.WristL;Draw-Bone $Graphics $accent $p.WristR (Point-In $stage 0.96 0.46)}
                else{Draw-Bone $Graphics $accent (Point-In $stage 0.10 0.76) (Point-In $stage 0.88 0.18);$Graphics.DrawArc($soft,$stage.X+10,$stage.Y+20,$stage.Width-20,$stage.Height-50,205,130)}
            }
            'Miyu' {
                $Graphics.DrawEllipse($accent,$stage.X+8,$stage.Y+25,42,42);$Graphics.DrawPolygon($accent,[System.Drawing.PointF[]]@((Point-In $stage 0.82 0.10),(Point-In $stage 0.97 0.17),(Point-In $stage 0.84 0.26)))
                if($PoseIndex -eq 0){$Graphics.DrawRectangle($accent,$p.WristR.X-20,$p.WristR.Y-12,40,24)}
                elseif($PoseIndex -eq 1){Draw-Bone $Graphics $accent $p.WristR (Point-In $stage 0.92 0.42);$Graphics.DrawArc($soft,$stage.X+8,$stage.Y+12,$stage.Width-16,$stage.Height*.45,190,160)}
                else{$Graphics.DrawEllipse($soft,$stage.X+15,$stage.Y+10,$stage.Width-30,$stage.Height*.55);Draw-Bone $Graphics $accent (Point-In $stage 0.08 0.22) (Point-In $stage 0.94 0.15)}
            }
            'Coco' {
                Draw-Bone $Graphics $accent $p.WristR (Point-In $stage 0.92 $(if($PoseIndex -eq 2){0.20}else{0.62}))
                if($PoseIndex -eq 1){$Graphics.DrawArc($soft,$stage.X+12,$stage.Y+30,$stage.Width-24,$stage.Height*.72,205,130)}
                if($PoseIndex -eq 2){$Graphics.DrawArc($accent,$stage.X-5,$stage.Y+12,$stage.Width+10,$stage.Height*.82,195,150)}
            }
            'Iris' {
                Draw-Bone $Graphics $accent (Point-In $stage $(if($PoseIndex -eq 2){0.04}else{0.08}) $(if($PoseIndex -eq 0){0.72}else{0.44})) (Point-In $stage 0.96 $(if($PoseIndex -eq 2){0.18}else{0.36}))
                if($PoseIndex -eq 2){Draw-Bone $Graphics $soft (Point-In $stage 0.20 0.52) (Point-In $stage 0.98 0.02)}
            }
            'Noah' {
                if($PoseIndex -eq 0){$Graphics.DrawRectangle($accent,$stage.Right-56,$stage.Y+$stage.Height*.30,38,$stage.Height*.48)}
                elseif($PoseIndex -eq 1){$Graphics.DrawRectangle($accent,$stage.X+$stage.Width*.58,$stage.Y+$stage.Height*.20,$stage.Width*.28,$stage.Height*.68)}
                else{$Graphics.DrawRectangle($accent,$stage.X+10,$stage.Y+8,$stage.Width-20,$stage.Height-16);for($x=$stage.X+45;$x -lt $stage.Right-20;$x+=42){$Graphics.DrawLine($soft,$x,$stage.Y+15,$x,$stage.Bottom-15)};for($y=$stage.Y+55;$y -lt $stage.Bottom-15;$y+=48){$Graphics.DrawLine($soft,$stage.X+18,$y,$stage.Right-18,$y)}}
            }
        }
        Draw-Text $Graphics $Pose.Action $SmallFont '#183042' ($Rect.X+16) ($Rect.Bottom-60) ($Rect.Width-32) 48 Center
    } finally { $line.Dispose();$accent.Dispose();$joint.Dispose();$soft.Dispose() }
}
function New-Pose {
    param([string]$Label,[string]$Intent,[string]$Action,[object[]]$Coordinates)
    $names=@('Head','Neck','ShoulderL','ShoulderR','ElbowL','ElbowR','WristL','WristR','Pelvis','HipL','HipR','KneeL','KneeR','AnkleL','AnkleR')
    $h=@{Label=$Label;Intent=$Intent;Action=$Action}; for($i=0;$i -lt $names.Count;$i++){$h[$names[$i]]=$Coordinates[$i]}; return $h
}

$characters=@(
    @{Id='Luna';Folder='luna';Key='concept/Luna_KeyArt_REVIEW_v001.png';Output='concept/Luna_PoseLayerPlan_REVIEW_v001.png';Accent='#4CE7D2';Hook='Cat-sensor hood + twin energy daggers / playful scout to instant mission focus';
      Hair=@('Crown: mint-silver compact shell','Shape: asymmetric wolf-bob clumps','Detail: one cheek-side accent lock','Rigid clearance: sensor hood + ears','PHYS-HAIR: tips only / short range');
      Layers=@('BASE / charcoal active inner + utility shorts','MID / cream cropped scout jacket + waist panel','OUTER / sensor hood + compact pack + scanner cable','GEAR / twin daggers + wrist scanner','VFX / cyan sensor ring + short dagger trails');
      Poses=@(
        (New-Pose 'OFF-DUTY / LOBBY' 'Playful hood-check; weight on one hip.' 'Sensor ear reacts before she does.' @(@(.50,.11),@(.50,.23),@(.35,.27),@(.65,.27),@(.28,.40),@(.70,.39),@(.36,.18),@(.78,.50),@(.50,.54),@(.42,.54),@(.58,.54),@(.38,.72),@(.64,.72),@(.31,.94),@(.70,.94))),
        (New-Pose 'COMBAT IDLE' 'Low forward center; daggers split wide.' 'Face + hood + both blades remain visible.' @(@(.52,.12),@(.51,.23),@(.34,.29),@(.66,.27),@(.22,.43),@(.79,.40),@(.08,.55),@(.93,.50),@(.50,.54),@(.42,.55),@(.60,.53),@(.32,.73),@(.70,.68),@(.20,.94),@(.82,.91))),
        (New-Pose 'SIGNATURE ACTION' 'CatStep cross-lunge into scan arc.' 'Diagonal speed line; scanner ring stays clear.' @(@(.63,.11),@(.59,.24),@(.43,.29),@(.70,.26),@(.30,.42),@(.82,.36),@(.16,.60),@(.92,.27),@(.52,.55),@(.43,.56),@(.61,.54),@(.27,.72),@(.78,.70),@(.08,.92),@(.94,.92))))},
    @{Id='Miyu';Folder='miyu';Key='concept/Miyu_KeyArt_REVIEW_v001.png';Output='concept/Miyu_PoseLayerPlan_REVIEW_v001.png';Accent='#26DFF1';Hook='Sleepy asymmetric technician / exactly two drones become her expressive combat face';
      Hair=@('Crown: smoky-lilac asymmetric shell','Shape: jaw bob / one longer face side','Detail: neon-blue inner card','Clearance: cheek, gauntlet and drone orbit','PHYS-HAIR: lower tips / minimal amplitude');
      Layers=@('BASE / graphite maintenance inner + shorts + boots','MID / cropped work bomber + asymmetric tool belt','OUTER / exactly one oversized sleeve + short panel','GEAR / round drone + angular drone + right gauntlet','VFX / cyan holo pad + two distinct response paths');
      Poses=@(
        (New-Pose 'OFF-DUTY / LOBBY' 'Small slouch; holo pad held close.' 'Sleepy body, drones quietly curious.' @(@(.50,.13),@(.50,.25),@(.36,.30),@(.64,.30),@(.32,.45),@(.67,.44),@(.43,.52),@(.58,.53),@(.50,.56),@(.43,.56),@(.57,.56),@(.43,.75),@(.58,.75),@(.39,.95),@(.62,.95))),
        (New-Pose 'COMBAT IDLE' 'Body remains small; gauntlet leads triangle.' 'Round scans; angular drone targets.' @(@(.48,.12),@(.49,.24),@(.35,.29),@(.64,.28),@(.27,.43),@(.76,.39),@(.22,.60),@(.90,.36),@(.50,.55),@(.42,.56),@(.58,.56),@(.38,.74),@(.66,.72),@(.31,.95),@(.73,.94))),
        (New-Pose 'SIGNATURE ACTION' 'Machine enthusiasm opens chest and arms.' 'Dual vector fire around bright holo core.' @(@(.50,.10),@(.50,.23),@(.31,.29),@(.69,.29),@(.19,.43),@(.81,.42),@(.08,.55),@(.94,.53),@(.50,.54),@(.41,.55),@(.59,.55),@(.35,.74),@(.66,.74),@(.28,.95),@(.73,.95))))},
    @{Id='Coco';Folder='coco';Key='concept/Coco_KeyArt_REVIEW_v002.png';Output='concept/Coco_PoseLayerPlan_REVIEW_v001.png';Accent='#38D2A2';Hook='Warm rescue captain / smiling field command switches to decisive protection';
      Hair=@('Crown: coral-copper wave shell','Front: soft face-framing S waves','Rear: low pony or side braid mass','Clearance: half-cape collar + pack','PHYS-HAIR: tail/braid; cape is separate group');
      Layers=@('BASE / warm-ivory rescue suit','MID / waist harness + transparent ampoules','OUTER / short coral half-cape','GEAR / injector baton + rescue pack + projector','VFX / jade recovery pulse + transparent curved shield');
      Poses=@(
        (New-Pose 'OFF-DUTY / LOBBY' 'Open warm stance; baton safely lowered.' 'Inviting curve and visible rescue harness.' @(@(.50,.11),@(.50,.23),@(.34,.28),@(.66,.28),@(.24,.43),@(.76,.42),@(.16,.55),@(.84,.53),@(.50,.54),@(.41,.55),@(.59,.55),@(.38,.74),@(.64,.74),@(.34,.95),@(.68,.95))),
        (New-Pose 'COMBAT IDLE' 'Stable curved guard; projector faces party.' 'Baton ready, transparent shield does not hide waist.' @(@(.50,.11),@(.50,.23),@(.33,.29),@(.67,.29),@(.25,.45),@(.78,.42),@(.18,.62),@(.89,.50),@(.50,.54),@(.41,.55),@(.59,.55),@(.34,.74),@(.68,.73),@(.27,.95),@(.76,.95))),
        (New-Pose 'SIGNATURE ACTION' 'Forward rescue step with wide pulse sweep.' 'Warm smile resolves into command focus.' @(@(.57,.10),@(.55,.23),@(.38,.29),@(.71,.27),@(.28,.43),@(.80,.39),@(.18,.58),@(.93,.20),@(.52,.54),@(.43,.55),@(.61,.53),@(.32,.72),@(.75,.72),@(.20,.94),@(.83,.94))))},
    @{Id='Iris';Folder='iris';Key='concept/Iris_KeyArt_REVIEW_v002.png';Output='concept/Iris_PoseLayerPlan_REVIEW_v001.png';Accent='#E64C66';Hook='Elegant observation sniper / long white coat and folded lance form one precision line';
      Hair=@('Crown: deep-plum smooth cap','Front: controlled side locks below jaw','Rear: long sheet split into 3 major clumps','Rigid: silver observation band','PHYS-HAIR: lower third only / coat clearance');
      Layers=@('BASE / ink precision body suit','MID / cold-white segmented long coat','OUTER / long coat tails + silver observer band','GEAR / folding observation lance + range modules','VFX / compressed crimson sightline + impact flash');
      Poses=@(
        (New-Pose 'OFF-DUTY / LOBBY' 'Composed vertical line with one small mistake.' 'Folded lance catches the slipping accessory.' @(@(.50,.09),@(.50,.21),@(.34,.26),@(.66,.26),@(.28,.42),@(.72,.39),@(.19,.58),@(.82,.51),@(.50,.52),@(.42,.53),@(.58,.53),@(.40,.73),@(.62,.73),@(.37,.95),@(.65,.95))),
        (New-Pose 'COMBAT IDLE' 'Ordered rear aim; center remains upright.' 'Coat and long gear preserve vertical separation.' @(@(.52,.09),@(.51,.21),@(.35,.27),@(.67,.25),@(.30,.40),@(.76,.36),@(.22,.48),@(.88,.31),@(.50,.52),@(.42,.53),@(.58,.53),@(.38,.73),@(.64,.73),@(.34,.95),@(.69,.95))),
        (New-Pose 'SIGNATURE ACTION' 'Kneeling Perfect Shot along one long diagonal.' 'Crimson line exits camera-safe upper corner.' @(@(.57,.11),@(.55,.23),@(.39,.28),@(.70,.27),@(.31,.43),@(.79,.38),@(.23,.58),@(.91,.28),@(.50,.54),@(.41,.55),@(.59,.54),@(.30,.76),@(.70,.69),@(.18,.94),@(.83,.86))))},
    @{Id='Noah';Folder='noah';Key='concept/Noah_KeyArt_REVIEW_v002.png';Output='concept/Noah_PoseLayerPlan_REVIEW_v001.png';Accent='#F2A83A';Hook='Calm guardian / folded vertical case becomes a door-sized mobile shelter';
      Hair=@('Crown: midnight-navy tidy shell','Shape: short protective bob','Detail: amber nape underlight cards','Clearance: high collar + shoulder guards','PHYS-HAIR: tip flick only / near-rigid mass');
      Layers=@('BASE / fitted navy guard inner','MID / waist-shaped jacket + steel guards','OUTER / asymmetric half-cape','GEAR / folded vertical case -> wall shield + comms','VFX / amber grid barrier + heavy countershock');
      Poses=@(
        (New-Pose 'OFF-DUTY / LOBBY' 'Tall calm stance; folded case parked close.' 'Free hand offers quiet practical care.' @(@(.50,.09),@(.50,.21),@(.34,.26),@(.66,.26),@(.29,.42),@(.72,.40),@(.25,.58),@(.80,.54),@(.50,.52),@(.41,.53),@(.59,.53),@(.39,.73),@(.62,.73),@(.36,.95),@(.65,.95))),
        (New-Pose 'COMBAT IDLE' 'Low heavy center; case becomes forward guard.' 'Face and waistline remain visible beside shield.' @(@(.47,.10),@(.48,.22),@(.32,.28),@(.64,.27),@(.25,.43),@(.74,.40),@(.19,.60),@(.82,.55),@(.49,.53),@(.39,.54),@(.59,.54),@(.31,.73),@(.69,.72),@(.23,.95),@(.78,.95))),
        (New-Pose 'SIGNATURE ACTION' 'Wide brace behind deployed shelter wall.' 'Door grid protects party; recoil returns through legs.' @(@(.50,.12),@(.50,.24),@(.32,.29),@(.68,.29),@(.22,.43),@(.78,.43),@(.12,.57),@(.88,.57),@(.50,.55),@(.38,.56),@(.62,.56),@(.28,.75),@(.72,.75),@(.18,.95),@(.82,.95))))}
)

$titleFont=New-Font 34 Bold; $subtitleFont=New-Font 16; $sectionFont=New-Font 22 Bold; $poseFont=New-Font 18 Bold; $bodyFont=New-Font 15; $smallFont=New-Font 13; $statusFont=New-Font 20 Bold
try {
    foreach($character in $characters) {
        $inputPath=Resolve-ProjectPath (Join-Path ('art_refs/characters/'+$character.Folder) $character.Key)
        $outputRelative=Join-Path ('art_refs/characters/'+$character.Folder) $character.Output
        $outputPath=Resolve-ProjectPath $outputRelative
        if((Test-Path -LiteralPath $outputPath) -and -not $Force){throw "Output exists: $outputPath (use -Force)"}
        [System.IO.Directory]::CreateDirectory((Split-Path -Parent $outputPath))|Out-Null
        $key=[System.Drawing.Image]::FromFile($inputPath)
        $canvas=[System.Drawing.Bitmap]::new(1920,1080,[System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        $g=[System.Drawing.Graphics]::FromImage($canvas)
        try {
            $g.SmoothingMode=[System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
            $g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $g.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
            $g.TextRenderingHint=[System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
            $background=[System.Drawing.Drawing2D.LinearGradientBrush]::new([System.Drawing.Rectangle]::new(0,0,1920,1080),(Color '#07111F'),(Color '#102333'),22)
            try{$g.FillRectangle($background,0,0,1920,1080)}finally{$background.Dispose()}
            Draw-Text $g ($character.Id.ToUpper()+' / POSE + HAIR + LAYER PLAN') $titleFont '#F5FAFD' 42 24 1250 48
            Draw-Text $g 'A2 COMPLETION EVIDENCE / deterministic blockout specification' $subtitleFont '#8FA7B9' 44 72 1050 28
            Draw-Text $g 'REVIEW v001' $poseFont $character.Accent 1600 34 260 32 Far

            Draw-Panel $g 38 112 420 798 '#0F1C2A' '#29445B'
            Draw-Text $g 'SELECTED KEY ART' $sectionFont $character.Accent 58 132 380 30
            Draw-ImageContain $g $key ([System.Drawing.RectangleF]::new(62,180,372,650))
            Draw-Text $g 'Thumbnail is identity reference, not a pose deliverable.' $smallFont '#9BB0C0' 64 844 366 48 Center

            $poseX=482; for($i=0;$i -lt 3;$i++){Draw-PoseDiagram $g ([System.Drawing.RectangleF]::new($poseX+$i*292,112,270,562)) $character.Poses[$i] $character $i $poseFont $smallFont}

            Draw-Panel $g 1378 112 504 294 '#0F1C2A' '#29445B'; Draw-Text $g 'HAIR STRUCTURE / PHYSICS GROUPS' $sectionFont $character.Accent 1400 134 460 32
            $y=180; foreach($line in $character.Hair){Draw-Text $g ('- '+$line) $bodyFont '#C6D3DD' 1404 $y 450 32;$y+=38}

            Draw-Panel $g 1378 428 504 414 '#0F1C2A' '#29445B'; Draw-Text $g 'FASHION / FUNCTION LAYER STACK' $sectionFont $character.Accent 1400 450 460 32
            $y=498; $layerColors=@('#6B8394','#8499A7','#AAB9C2',$character.Accent,'#FFFFFF'); for($i=0;$i -lt $character.Layers.Count;$i++){$brush=[System.Drawing.SolidBrush]::new((Color $layerColors[$i]));try{$g.FillRectangle($brush,1404,$y+4,10,26)}finally{$brush.Dispose()};Draw-Text $g $character.Layers[$i] $bodyFont '#D4DFE6' 1426 $y 430 52;$y+=66}

            Draw-Panel $g 482 702 868 140 '#0F1C2A' $character.Accent; Draw-Text $g 'IDENTITY HOOK' $sectionFont $character.Accent 506 724 250 30; Draw-Text $g $character.Hook $bodyFont '#DCE8EF' 506 766 816 58
            Draw-Panel $g 38 932 1844 104 '#111C28' '#5A3A2B'; Draw-Text $g 'BLOCKOUT DIAGRAM / HUMAN APPROVAL PENDING / NOT GRANTED' $statusFont '#F1A85A' 64 956 1792 34 Center; Draw-Text $g 'Pose anatomy, cloth clearance, hair dynamics, equipment sockets and runtime camera read require model/rig proof.' $smallFont '#AAB9C3' 64 994 1792 28 Center
            $canvas.Save($outputPath,[System.Drawing.Imaging.ImageFormat]::Png)
            Write-Output "Created $outputRelative (1920x1080)"
        } finally {$g.Dispose();$canvas.Dispose();$key.Dispose()}
    }
} finally {$titleFont.Dispose();$subtitleFont.Dispose();$sectionFont.Dispose();$poseFont.Dispose();$bodyFont.Dispose();$smallFont.Dispose();$statusFont.Dispose()}
