param(
    [string]$OutputPath = (Join-Path $PSScriptRoot 'depthwise_stride1_reuse.gif')
)

$ErrorActionPreference = 'Stop'

Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

function New-Brush([byte]$r, [byte]$g, [byte]$b) {
    $brush = [System.Windows.Media.SolidColorBrush]::new(
        [System.Windows.Media.Color]::FromRgb($r, $g, $b)
    )
    $brush.Freeze()
    return $brush
}

function New-Pen($brush, [double]$thickness) {
    $pen = [System.Windows.Media.Pen]::new($brush, $thickness)
    $pen.Freeze()
    return $pen
}

function Draw-Text(
    [System.Windows.Media.DrawingContext]$dc,
    [string]$text,
    [double]$x,
    [double]$y,
    [double]$size,
    $brush,
    [string]$font = 'Malgun Gothic'
) {
    $typeface = [System.Windows.Media.Typeface]::new($font)
    $formatted = [System.Windows.Media.FormattedText]::new(
        $text,
        [System.Globalization.CultureInfo]::GetCultureInfo('ko-KR'),
        [System.Windows.FlowDirection]::LeftToRight,
        $typeface,
        $size,
        $brush
    )
    $dc.DrawText($formatted, [System.Windows.Point]::new($x, $y))
}

function Cell-Key([int]$row, [int]$col) {
    return "$row,$col"
}

$canvasWidth = 960
$canvasHeight = 650
$gridSize = 5
$cellSize = 74
$gridX = 60
$gridY = 155

$white = New-Brush 255 255 255
$ink = New-Brush 31 41 55
$muted = New-Brush 94 105 122
$gridLine = New-Brush 112 124 143
$unused = New-Brush 244 247 251
$visited = New-Brush 232 238 246
$reused = New-Brush 190 164 255
$newData = New-Brush 106 210 255
$kernel = New-Brush 245 158 11
$panel = New-Brush 248 250 252
$accentBackground = New-Brush 255 247 224
$outputInactive = New-Brush 226 232 240
$outputActive = New-Brush 253 186 116

$gridPen = New-Pen $gridLine 1.5
$kernelPen = New-Pen $kernel 5
$panelPen = New-Pen (New-Brush 215 222 232) 1.5
$outputPen = New-Pen $gridLine 1

$positions = @(
    [pscustomobject]@{ Row = 0; Col = 0 },
    [pscustomobject]@{ Row = 0; Col = 1 },
    [pscustomobject]@{ Row = 0; Col = 2 },
    [pscustomobject]@{ Row = 1; Col = 0 },
    [pscustomobject]@{ Row = 1; Col = 1 },
    [pscustomobject]@{ Row = 1; Col = 2 },
    [pscustomobject]@{ Row = 2; Col = 0 },
    [pscustomobject]@{ Row = 2; Col = 1 },
    [pscustomobject]@{ Row = 2; Col = 2 }
)

$encoder = [System.Windows.Media.Imaging.GifBitmapEncoder]::new()

for ($frameIndex = 0; $frameIndex -lt $positions.Count; $frameIndex++) {
    $current = $positions[$frameIndex]
    $previous = if ($frameIndex -gt 0) { $positions[$frameIndex - 1] } else { $null }

    $currentCells = @{}
    for ($kr = 0; $kr -lt 3; $kr++) {
        for ($kc = 0; $kc -lt 3; $kc++) {
            $currentCells[(Cell-Key ($current.Row + $kr) ($current.Col + $kc))] = $true
        }
    }

    $previousCells = @{}
    if ($null -ne $previous) {
        for ($kr = 0; $kr -lt 3; $kr++) {
            for ($kc = 0; $kc -lt 3; $kc++) {
                $previousCells[(Cell-Key ($previous.Row + $kr) ($previous.Col + $kc))] = $true
            }
        }
    }

    $useCounts = @{}
    for ($pastIndex = 0; $pastIndex -le $frameIndex; $pastIndex++) {
        $past = $positions[$pastIndex]
        for ($kr = 0; $kr -lt 3; $kr++) {
            for ($kc = 0; $kc -lt 3; $kc++) {
                $key = Cell-Key ($past.Row + $kr) ($past.Col + $kc)
                if (-not $useCounts.ContainsKey($key)) { $useCounts[$key] = 0 }
                $useCounts[$key]++
            }
        }
    }

    $visual = [System.Windows.Media.DrawingVisual]::new()
    $dc = $visual.RenderOpen()
    $dc.DrawRectangle($white, $null, [System.Windows.Rect]::new(0, 0, $canvasWidth, $canvasHeight))

    Draw-Text $dc 'Depthwise 3×3 · stride 1' 55 35 34 $ink 'Segoe UI'
    Draw-Text $dc '커널은 한 칸씩 이동하고, 입력 픽셀은 겹치는 창에서 다시 사용됩니다.' 57 82 20 $muted
    Draw-Text $dc '5×5 입력 예시 (실제 Layer 8 입력은 채널별 14×14)' 60 122 16 $muted

    for ($row = 0; $row -lt $gridSize; $row++) {
        for ($col = 0; $col -lt $gridSize; $col++) {
            $key = Cell-Key $row $col
            $isCurrent = $currentCells.ContainsKey($key)
            $isReused = $isCurrent -and $previousCells.ContainsKey($key)
            $wasVisited = $useCounts.ContainsKey($key)

            if ($isReused) {
                $fill = $reused
            } elseif ($isCurrent) {
                $fill = $newData
            } elseif ($wasVisited) {
                $fill = $visited
            } else {
                $fill = $unused
            }

            $x = $gridX + $col * $cellSize
            $y = $gridY + $row * $cellSize
            $dc.DrawRectangle($fill, $gridPen, [System.Windows.Rect]::new($x, $y, $cellSize, $cellSize))
            Draw-Text $dc "x[$row,$col]" ($x + 12) ($y + 14) 16 $ink 'Consolas'

            $count = if ($wasVisited) { $useCounts[$key] } else { 0 }
            Draw-Text $dc "누적 $count 회" ($x + 12) ($y + 42) 12 $muted
        }
    }

    if ($null -ne $previous) {
        $previousBrush = New-Brush 148 163 184
        $previousPen = [System.Windows.Media.Pen]::new($previousBrush, 2)
        $previousPen.DashStyle = [System.Windows.Media.DashStyles]::Dash
        $previousPen.Freeze()
        $previousRect = [System.Windows.Rect]::new(
            $gridX + $previous.Col * $cellSize,
            $gridY + $previous.Row * $cellSize,
            3 * $cellSize,
            3 * $cellSize
        )
        $dc.DrawRectangle($null, $previousPen, $previousRect)
    }

    $kernelRect = [System.Windows.Rect]::new(
        $gridX + $current.Col * $cellSize,
        $gridY + $current.Row * $cellSize,
        3 * $cellSize,
        3 * $cellSize
    )
    $dc.DrawRectangle($null, $kernelPen, $kernelRect)

    $panelRect = [System.Windows.Rect]::new(485, 145, 415, 380)
    $dc.DrawRoundedRectangle($panel, $panelPen, $panelRect, 16, 16)
    Draw-Text $dc "Frame $($frameIndex + 1) / $($positions.Count)" 520 175 16 $muted 'Segoe UI'
    Draw-Text $dc '현재 계산하는 출력' 520 210 18 $muted
    Draw-Text $dc "y[$($current.Row),$($current.Col)]" 520 239 38 $kernel 'Consolas'

    Draw-Text $dc '출력 위치: 각각 한 번만 계산' 520 304 16 $ink
    $miniX = 735
    $miniY = 290
    $miniCell = 38
    for ($orow = 0; $orow -lt 3; $orow++) {
        for ($ocol = 0; $ocol -lt 3; $ocol++) {
            $fill = if (($orow -eq $current.Row) -and ($ocol -eq $current.Col)) {
                $outputActive
            } else {
                $outputInactive
            }
            $dc.DrawRectangle(
                $fill,
                $outputPen,
                [System.Windows.Rect]::new($miniX + $ocol * $miniCell, $miniY + $orow * $miniCell, $miniCell, $miniCell)
            )
        }
    }

    $overlapCount = 0
    foreach ($key in $currentCells.Keys) {
        if ($previousCells.ContainsKey($key)) { $overlapCount++ }
    }
    $newCount = 9 - $overlapCount

    $dc.DrawRectangle($reused, $null, [System.Windows.Rect]::new(520, 380, 28, 28))
    Draw-Text $dc "재사용: $overlapCount 개" 560 381 17 $ink
    $dc.DrawRectangle($newData, $null, [System.Windows.Rect]::new(520, 425, 28, 28))
    Draw-Text $dc "이번 창에 새로 포함: $newCount 개" 560 426 17 $ink
    $dc.DrawRectangle($visited, $null, [System.Windows.Rect]::new(520, 470, 28, 28))
    Draw-Text $dc '이전에 사용했고 현재 창 밖' 560 471 17 $ink

    $bannerRect = [System.Windows.Rect]::new(55, 560, 850, 58)
    $dc.DrawRoundedRectangle($accentBackground, $null, $bannerRect, 14, 14)
    Draw-Text $dc '핵심: 출력 위치는 1회 · 입력 픽셀은 여러 3×3 window에서 재사용' 86 574 22 $ink

    $dc.Close()

    $bitmap = [System.Windows.Media.Imaging.RenderTargetBitmap]::new(
        $canvasWidth,
        $canvasHeight,
        96,
        96,
        [System.Windows.Media.PixelFormats]::Pbgra32
    )
    $bitmap.Render($visual)
    $bitmap.Freeze()

    $metadata = [System.Windows.Media.Imaging.BitmapMetadata]::new('gif')
    $delay = if ($frameIndex -eq ($positions.Count - 1)) { [uint16]140 } else { [uint16]85 }
    $metadata.SetQuery('/grctlext/Disposal', [byte]2)
    $metadata.SetQuery('/grctlext/Delay', $delay)

    if ($frameIndex -eq 0) {
        try {
            $metadata.SetQuery('/appext/application', [System.Text.Encoding]::ASCII.GetBytes('NETSCAPE2.0'))
            $metadata.SetQuery('/appext/data', [byte[]](3, 1, 0, 0))
        } catch {
            # Some WPF codecs omit the loop extension; multi-frame animation still works.
        }
    }

    $frame = [System.Windows.Media.Imaging.BitmapFrame]::Create($bitmap, $null, $metadata, $null)
    $encoder.Frames.Add($frame)
}

$outputDirectory = Split-Path -Parent $OutputPath
if ($outputDirectory -and -not (Test-Path -LiteralPath $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

$stream = [System.IO.File]::Open($OutputPath, [System.IO.FileMode]::Create)
try {
    $encoder.Save($stream)
} finally {
    $stream.Dispose()
}

# WPF writes the requested frames but can zero their GIF89a delay fields and
# omit the NETSCAPE loop extension. Patch those small control blocks so the
# result animates consistently in browsers and image viewers.
$gifBytes = [System.IO.File]::ReadAllBytes($OutputPath)
$graphicControlOffsets = [System.Collections.Generic.List[int]]::new()
for ($index = 0; $index -le $gifBytes.Length - 8; $index++) {
    if (($gifBytes[$index] -eq 0x21) -and
        ($gifBytes[$index + 1] -eq 0xF9) -and
        ($gifBytes[$index + 2] -eq 0x04)) {
        $graphicControlOffsets.Add($index)
    }
}

if ($graphicControlOffsets.Count -ne $positions.Count) {
    throw "Expected $($positions.Count) GIF control blocks, found $($graphicControlOffsets.Count)."
}

for ($frameIndex = 0; $frameIndex -lt $graphicControlOffsets.Count; $frameIndex++) {
    $delay = if ($frameIndex -eq ($graphicControlOffsets.Count - 1)) { 140 } else { 85 }
    $offset = $graphicControlOffsets[$frameIndex]
    $gifBytes[$offset + 4] = [byte]($delay -band 0xFF)
    $gifBytes[$offset + 5] = [byte](($delay -shr 8) -band 0xFF)
}

# GIF application extension: NETSCAPE2.0, loop count 0 means repeat forever.
$loopExtension = [byte[]](
    0x21, 0xFF, 0x0B,
    0x4E, 0x45, 0x54, 0x53, 0x43, 0x41, 0x50, 0x45, 0x32, 0x2E, 0x30,
    0x03, 0x01, 0x00, 0x00, 0x00
)

$insertOffset = 13 # Immediately after the GIF header and logical screen descriptor.
$animatedBytes = [byte[]]::new($gifBytes.Length + $loopExtension.Length)
[System.Array]::Copy($gifBytes, 0, $animatedBytes, 0, $insertOffset)
[System.Array]::Copy($loopExtension, 0, $animatedBytes, $insertOffset, $loopExtension.Length)
[System.Array]::Copy(
    $gifBytes,
    $insertOffset,
    $animatedBytes,
    $insertOffset + $loopExtension.Length,
    $gifBytes.Length - $insertOffset
)
[System.IO.File]::WriteAllBytes($OutputPath, $animatedBytes)

Write-Output (Resolve-Path -LiteralPath $OutputPath).Path
