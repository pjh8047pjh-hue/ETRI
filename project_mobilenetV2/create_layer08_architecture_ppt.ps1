$ErrorActionPreference = 'Stop'

function Get-Rgb([string]$hex) {
    $h = $hex.TrimStart('#')
    $r = [Convert]::ToInt32($h.Substring(0, 2), 16)
    $g = [Convert]::ToInt32($h.Substring(2, 2), 16)
    $b = [Convert]::ToInt32($h.Substring(4, 2), 16)
    return $r + (256 * $g) + (65536 * $b)
}

function Add-Rect($slide, [double]$x, [double]$y, [double]$w, [double]$h,
                  [string]$fill, [string]$line = '#172027', [double]$lineWidth = 1.4) {
    $shape = $slide.Shapes.AddShape(1, $x, $y, $w, $h)
    $shape.Fill.ForeColor.RGB = Get-Rgb $fill
    $shape.Line.ForeColor.RGB = Get-Rgb $line
    $shape.Line.Weight = $lineWidth
    return $shape
}

function Add-Text($slide, [double]$x, [double]$y, [double]$w, [double]$h,
                  [string]$text, [double]$size, [bool]$bold,
                  [string]$color = '#202124', [int]$align = 2,
                  [string]$font = 'Arial') {
    $shape = $slide.Shapes.AddTextbox(1, $x, $y, $w, $h)
    $shape.Line.Visible = 0
    $shape.Fill.Visible = 0
    $shape.TextFrame.MarginLeft = 0
    $shape.TextFrame.MarginRight = 0
    $shape.TextFrame.MarginTop = 0
    $shape.TextFrame.MarginBottom = 0
    $shape.TextFrame.VerticalAnchor = 3
    $shape.TextFrame.TextRange.Text = $text
    $shape.TextFrame.TextRange.Font.Name = $font
    $shape.TextFrame.TextRange.Font.Size = [single]$size
    $shape.TextFrame.TextRange.Font.Bold = $(if ($bold) { -1 } else { 0 })
    $shape.TextFrame.TextRange.Font.Color.RGB = Get-Rgb $color
    $shape.TextFrame.TextRange.ParagraphFormat.Alignment = $align
    return $shape
}

function Add-Arrow($slide, [double]$x, [double]$y, [double]$w, [double]$h) {
    $shape = $slide.Shapes.AddShape(33, $x, $y, $w, $h)
    $shape.Fill.ForeColor.RGB = Get-Rgb '#9dc5e5'
    $shape.Line.ForeColor.RGB = Get-Rgb '#142531'
    $shape.Line.Weight = 1.4
    return $shape
}

function Add-Line($slide, [double]$x1, [double]$y1, [double]$x2, [double]$y2,
                  [string]$color, [double]$weight = 1.0, [bool]$dashed = $false) {
    $line = $slide.Shapes.AddLine($x1, $y1, $x2, $y2)
    $line.Line.ForeColor.RGB = Get-Rgb $color
    $line.Line.Weight = $weight
    if ($dashed) { $line.Line.DashStyle = 4 }
    return $line
}

$ppt = $null
$presentation = $null
$slide = $null

try {
    $ppt = New-Object -ComObject PowerPoint.Application
    $presentation = $ppt.Presentations.Add(0)
    $presentation.PageSetup.SlideWidth = 960
    $presentation.PageSetup.SlideHeight = 540
    $slide = $presentation.Slides.Add(1, 12)

    # Header
    Add-Text $slide 37 18 40 40 '02' 28 $true '#08648a' 1 | Out-Null
    Add-Text $slide 78 17 275 42 'System architecture' 27 $true '#202124' 1 | Out-Null
    Add-Text $slide 365 18 150 35 '시스템 구성도' 16 $false '#7b8a96' 1 'Malgun Gothic' | Out-Null
    Add-Text $slide 42 66 600 24 'Layer08 Pointwise Conv: 14×14 pixels, 64 input channels → 384 output channels' 12 $true '#465461' 1 | Out-Null

    # Outer frame and controller
    $frame = Add-Rect $slide 33 102 894 402 '#ffffff' '#172027' 1.4
    $frame.Fill.Transparency = 1
    Add-Rect $slide 72 132 816 63 '#f2b7b7' | Out-Null
    Add-Text $slide 72 145 816 25 'FSM Controller' 16 $true '#16191c' | Out-Null
    Add-Text $slide 72 172 816 16 'Address sequencing · valid timing · read/write control' 9 $true '#33485c' | Out-Null

    Add-Line $slide 234 195 234 219 '#df7777' 1.2 $true | Out-Null
    Add-Line $slide 474 195 474 219 '#df7777' 1.2 $true | Out-Null
    Add-Line $slide 723 195 723 219 '#df7777' 1.2 $true | Out-Null

    # Input and weight memories
    Add-Rect $slide 72 228 180 81 '#cfe0f2' | Out-Null
    Add-Text $slide 78 241 168 22 'Weight ROM' 15 $true '#16191c' | Out-Null
    Add-Text $slide 78 266 168 17 '384 rows × 1024 bits' 10 $true '#344554' | Out-Null
    Add-Text $slide 78 287 168 14 '64 weights/row · Signed Q3.12' 8 $false '#566672' | Out-Null

    Add-Rect $slide 72 357 180 81 '#cfe0f2' | Out-Null
    Add-Text $slide 78 370 168 22 'Input Feature RAM' 14 $true '#16191c' | Out-Null
    Add-Text $slide 78 395 168 17 '196 rows × 1024 bits' 10 $true '#344554' | Out-Null
    Add-Text $slide 78 416 168 14 '64 channels/row · Signed Q3.12' 8 $false '#566672' | Out-Null

    Add-Arrow $slide 252 255 75 38 | Out-Null
    Add-Arrow $slide 252 384 75 38 | Out-Null

    # MAC module
    Add-Rect $slide 327 219 246 243 '#fff0a8' | Out-Null
    Add-Text $slide 327 229 246 24 'Pointwise MAC Module' 15 $true '#16191c' | Out-Null

    $stageY = @(263, 304, 345, 386)
    $stageText = @(
        'Index / Address Calculator',
        '64 × 16-bit Multiplier IP',
        'Adder Tree / Product Sum',
        '38-bit Accumulator'
    )
    for ($i = 0; $i -lt $stageY.Count; $i++) {
        Add-Rect $slide 363 $stageY[$i] 174 29 '#ffe1a0' | Out-Null
        Add-Text $slide 367 ($stageY[$i] + 5) 166 18 $stageText[$i] 9 $true '#344554' | Out-Null
    }
    Add-Rect $slide 363 427 174 19 '#f9cd78' | Out-Null
    Add-Text $slide 367 429 166 14 'Quantize: arithmetic >>> 12' 8 $true '#33485c' | Out-Null

    # Output stages
    Add-Arrow $slide 573 320 64 40 | Out-Null
    Add-Text $slide 576 293 58 18 '16-bit Q3.12' 8 $false '#566672' | Out-Null

    Add-Rect $slide 637 258 153 153 '#cfe0f2' | Out-Null
    Add-Text $slide 643 278 141 24 'Output BRAM' 15 $true '#16191c' | Out-Null
    Add-Text $slide 643 310 141 18 '75,264 rows × 16 bits' 10 $true '#344554' | Out-Null
    Add-Line $slide 659 333 768 333 '#8298aa' 0.8 $false | Out-Null
    Add-Text $slide 643 344 141 16 '384 × 14 × 14' 9 $true '#33485c' | Out-Null
    Add-Text $slide 643 369 141 14 '16-bit saturation' 8 $false '#566672' | Out-Null
    Add-Text $slide 643 390 141 14 'Channel-major storage' 8 $false '#566672' | Out-Null

    Add-Arrow $slide 790 320 40 40 | Out-Null
    Add-Rect $slide 830 258 78 153 '#d9ead3' | Out-Null
    Add-Text $slide 834 273 70 22 '16×16' 14 $true '#16191c' | Out-Null
    Add-Text $slide 834 298 70 18 'Zero Padding' 9 $true '#33485c' | Out-Null
    Add-Line $slide 842 333 896 333 '#829b84' 0.8 $false | Out-Null
    Add-Text $slide 834 345 70 22 'ReLU6' 14 $true '#16191c' | Out-Null
    Add-Text $slide 834 371 70 17 '0 ~ 0x6000' 8 $true '#33485c' | Out-Null
    Add-Text $slide 834 394 70 14 '98,304 samples' 7 $false '#566672' | Out-Null

    Add-Text $slide 42 478 500 18 'Total computation: 64 × 384 × 14 × 14 = 4,816,896 MACs' 9 $false '#566672' 1 | Out-Null

    $outputPath = Join-Path $PSScriptRoot 'layer08_system_architecture_editable.pptx'
    $presentation.SaveAs($outputPath, 24)
    Write-Output $outputPath
}
finally {
    if ($presentation) { $presentation.Close() }
    if ($ppt) { $ppt.Quit() }
    if ($slide) { [void][Runtime.InteropServices.Marshal]::ReleaseComObject($slide) }
    if ($presentation) { [void][Runtime.InteropServices.Marshal]::ReleaseComObject($presentation) }
    if ($ppt) { [void][Runtime.InteropServices.Marshal]::ReleaseComObject($ppt) }
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()
}
