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
$taskGraphics.DrawString('IDLE ↔ AutoRun ↔ RUN ↔ IDLE · SLEEP 제거', $taskHeadingFont, $taskInk, 55, 95)
Box 'IDLE' '계속 서서 대기 / A 입력 가능' 90 280 330 120
Box 'AutoRun' '800 px/s · 1.5배 · 최대 5초' 630 280 340 120 $true
Box 'RUN' '500 px/s · 원래 크기' 1210 280 300 120
Arrow @(420,310,630,310)
Label 'A 누름' 430 260 185
Arrow @(630,375,420,375)
Label '5초 경과 / 크기 복구' 400 410 290
Arrow @(970,310,1210,310)
Label '← / → 누름' 990 240 195
Label '(Shift 불필요)' 995 275 190
Arrow @(1210,375,970,375)
Label 'A 누름' 995 410 180
Arrow @(250,280,250,210,1360,210,1360,280)
Label 'Shift + 방향키 → RUN' 610 160 395
Arrow @(1380,400,1380,530,250,530,250,400)
Label '방향키 이동 중지 → IDLE' 610 540 395
Arrow @(800,400,800,470,1100,470,1100,335,970,335)
Label '좌우 경계 → 방향 반전 (AutoRun 유지)' 830 480 490
$taskGraphics.DrawLine($taskBorder,55,625,1545,625)
$taskGraphics.DrawString('기존 WALK 유지 (위와 동일한 IDLE / RUN)', $taskHeadingFont, $taskInk, 55, 650)
Box 'IDLE' '일반 대기' 90 810 330
Box 'WALK' '200 px/s' 630 810 340
Box 'RUN' '500 px/s' 1210 810 300
Arrow @(420,840,630,840)
Label '방향키' 440 785 170
Arrow @(630,900,420,900)
Label '이동 중지' 440 920 170
Arrow @(970,840,1210,840)
Label 'Shift 누름' 995 785 195
Arrow @(1210,900,970,900)
Label 'Shift 해제' 995 920 195
$taskGraphics.DrawString('상태 전이 조건: 좌우 동시 입력은 이동 중지로 처리. IDLE은 시간이 지나도 눕지 않는다.', $taskFont, $taskInk, 65, 1020)
$taskGraphics.DrawString('입력: ←/→ 이동 · Shift 달리기 · A 자동 무적 런 (IDLE/RUN) · Esc 종료', $taskSmallFont, $taskInk, 65, 1080)
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
