# Generate the assignment diagram; this script does not run the game or tests.
Add-Type -AssemblyName System.Drawing
$taskOutput = Join-Path $PSScriptRoot '../docs/state-diagram.png'
$taskBitmap = [System.Drawing.Bitmap]::new(1600, 1120)
$taskGraphics = [System.Drawing.Graphics]::FromImage($taskBitmap)
$taskGraphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$taskGraphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$taskGraphics.Clear([System.Drawing.Color]::FromArgb(245,248,252))
$taskTitleFont = [System.Drawing.Font]::new('Malgun Gothic', 27, [System.Drawing.FontStyle]::Bold)
$taskHeadingFont = [System.Drawing.Font]::new('Malgun Gothic', 19, [System.Drawing.FontStyle]::Bold)
$taskFont = [System.Drawing.Font]::new('Malgun Gothic', 14)
$taskSmallFont = [System.Drawing.Font]::new('Malgun Gothic', 12)
$taskInk = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(27,43,67))
$taskLine = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(57,89,124), 3)
$taskArrow = [System.Drawing.Drawing2D.AdjustableArrowCap]::new(5,6)
$taskLine.CustomEndCap = $taskArrow
$taskBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(192,207,225), 2)
$taskFormat = [System.Drawing.StringFormat]::new()
$taskFormat.Alignment = [System.Drawing.StringAlignment]::Center
$taskFormat.LineAlignment = [System.Drawing.StringAlignment]::Center
function Label([string]$text, [int]$x, [int]$y, [int]$w=300, [int]$h=45) {
    $taskGraphics.DrawString($text, $taskFont, $taskInk, [System.Drawing.RectangleF]::new($x,$y,$w,$h), $taskFormat)
}
function Box([string]$title,[string]$body,[int]$x,[int]$y,[int]$w=320,[int]$h=110,[bool]$accent=$false) {
    $color = if ($accent) { [System.Drawing.Color]::FromArgb(216,242,237) } else { [System.Drawing.Color]::White }
    $brush = [System.Drawing.SolidBrush]::new($color)
    $taskGraphics.FillRectangle($brush,$x,$y,$w,$h)
    $taskGraphics.DrawRectangle($taskBorder,$x,$y,$w,$h)
    $taskGraphics.DrawString($title,$taskHeadingFont,$taskInk,[System.Drawing.RectangleF]::new($x,$y+8,$w,40),$taskFormat)
    $taskGraphics.DrawString($body,$taskSmallFont,$taskInk,[System.Drawing.RectangleF]::new($x+5,$y+47,$w-10,$h-50),$taskFormat)
    $brush.Dispose()
}
function Arrow([int[]]$coords) {
    for ($i=0; $i -lt $coords.Length-4; $i+=2) {
        $taskLine.EndCap = [System.Drawing.Drawing2D.LineCap]::Flat
        $taskGraphics.DrawLine($taskLine,$coords[$i],$coords[$i+1],$coords[$i+2],$coords[$i+3])
    }
    $taskLine.CustomEndCap = $taskArrow
    $n=$coords.Length
    $taskGraphics.DrawLine($taskLine,$coords[$n-4],$coords[$n-3],$coords[$n-2],$coords[$n-1])
}
$taskGraphics.DrawString('Drill #11 | 소년 상태 다이어그램', $taskTitleFont, $taskInk, 55, 25)
$taskGraphics.DrawString('AutoRun 요구사항 · 별도 파일: states/auto_run.py', $taskHeadingFont, $taskInk, 55, 95)
Box 'IDLE' 'A 입력 대기 / 진입 시 타이머 초기화' 70 245
Box 'AutoRun' '800 px/s · 1.5배 · 자동 이동' 630 245 340 110 $true
Box 'RUN' '500 px/s · 원래 크기' 1210 245
Arrow @(390,275,630,275)
Label 'A 누름' 410 225 195
Arrow @(970,275,1210,275)
Label '← / → 누름' 990 213 195
Label 'Shift 없이 해당 방향 RUN' 975 285 235 65
Arrow @(700,355,700,410,230,410,230,355)
Label '5초 경과 → IDLE / 크기 복구' 245 365 435
Arrow @(970,330,1080,330,1080,465,800,465,800,355)
Label '좌우 경계 → 방향 반전' 770 477 370
Label '(AutoRun 상태 유지)' 790 510 330
Arrow @(1370,245,1370,180,240,180,240,245)
Label '방향키 이동 중지 → IDLE' 630 135 395
$taskGraphics.DrawLine($taskBorder,55,575,1545,575)
$taskGraphics.DrawString('기존 상태 전이 (위와 동일한 IDLE / RUN)', $taskHeadingFont, $taskInk, 55, 595)
Box 'IDLE' '5초 대기 → SLEEP' 70 740 270
Box 'WALK' '200 px/s' 460 740 270
Box 'RUN' '500 px/s' 850 740 270
Box 'SLEEP' '방향에 맞춰 눕기 / 기상' 1240 740 290
Arrow @(340,770,460,770)
Label '방향키' 340 721 120
Arrow @(730,770,850,770)
Label 'Shift 누름' 730 721 120
Arrow @(850,825,730,825)
Label 'Shift 해제' 730 845 120
Arrow @(595,850,595,920,200,920,200,850)
Label '이동 중지 → IDLE (WALK / RUN)' 220 929 490
Arrow @(985,850,985,920,595,920)
Arrow @(205,740,205,690,985,690,985,740)
Label 'Shift + 방향키 → RUN' 480 645 350
Arrow @(290,850,290,1005,1385,1005,1385,850)
Label 'IDLE 5초 → SLEEP' 400 1006 320
Arrow @(1290,740,1290,650,300,650,300,740)
Label 'Space → 기상 완료 → IDLE' 890 605 390
Arrow @(1450,850,1450,965,650,965,650,850)
Label '방향키 → 즉시 WALK (회전 중에도 적용)' 850 966 570
$taskGraphics.DrawString('입력 기준: ←/→ 이동 · Shift 달리기 · A 자동 무적 런 · Space 기상 · Esc 종료', $taskSmallFont, $taskInk, 65, 1080)
$taskBitmap.Save($taskOutput,[System.Drawing.Imaging.ImageFormat]::Png)
$taskGraphics.Dispose()
$taskBitmap.Dispose()
$taskTitleFont.Dispose()
$taskHeadingFont.Dispose()
$taskFont.Dispose()
$taskSmallFont.Dispose()
$taskInk.Dispose()
$taskLine.Dispose()
$taskBorder.Dispose()
$taskFormat.Dispose()
$taskArrow.Dispose()
