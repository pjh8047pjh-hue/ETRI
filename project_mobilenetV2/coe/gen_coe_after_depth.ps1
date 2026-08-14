# =============================================================================
# pointwise_after_depth 디버깅용 .coe / .mem 생성 스크립트
#
#   input_after_depth.coe          512-bit x 1176  (depthwise 출력 feature map)
#   weight_after_depth_onehot.coe  512-bit x  384  (one-hot, 값 확인용)
#   weight_after_depth_all1.coe    512-bit x  384  (전부 +1, 64-MAC 합 확인용)
#
#   같은 내용을 .mem 으로도 뽑는다. .coe는 BRAM IP 초기화용이고
#   (헤더/쉼표 때문에 $readmemh로 못 읽는다), .mem은 TB에서
#   $readmemh("input_after_depth.mem", mem) 으로 바로 읽는 용도다.
#
# 데이터 폭
#   pointwise_after_depth는 512-bit를 data[i*8 +: 8]로 뽑아 쓰므로
#   int8 x 64 lane, lane0이 LSB다. .coe 한 줄은 MSB가 왼쪽이므로
#   lane63 ... lane0 순서(2 hex digit씩)로 적는다. 음수는 2의 보수.
#
# 채널/주소 구조
#   IN_CH = 384 = 64 lane x 6 chunk  -> 한 픽셀이 6 줄을 차지한다.
#   input  주소 = p*6 + g            (p = 0..195 픽셀, g = 0..5 chunk)
#   weight 주소 = ic_cnt*64 + cnt    (RTL 카운터와 동일: cnt=출력채널, ic_cnt=chunk)
#                = g*64 + oc         (oc = 0..63)
#
# 입력 값 정의
#   x[p][c] = ((c % 8) - 4) + (p % 8) + (c / 64)      , c = 0..383
#           = lane 성분(-4..3) + 픽셀 성분(0..7) + chunk 성분(0..5)  -> -4..15, int8 안전
#
# 기대값 (adder tree 출력 = 한 clk당 64-MAC 합)
#   all1  weight : sum = -32 + 64*(p%8) + 64*g
#                  (8*sum(k-4, k=0..7) = -32 이므로 lane 성분은 항상 -32로 상쇄)
#                  -> -32, 32, 96, ... 로 chunk/픽셀이 바뀔 때마다 64씩 증가
#   onehot weight: out[p][oc] = x[p][6*oc]  (hot 채널 c = 6*oc, 나머지 lane은 0)
#                  6*oc가 0..378이라 6개 chunk를 전부 훑는다.
# =============================================================================

$ErrorActionPreference = 'Stop'
$outDir = $PSScriptRoot

$LANES  = 64     # 512-bit / 8-bit
$CHUNK  = 6      # 384 / 64
$IN_CH  = $LANES * $CHUNK   # 384
$PIX    = 196    # 14 x 14
$OUT_CH = 64     # pointwise 출력 채널 수

# int8 -> 2의 보수 2자리 hex
function To-Hex8([int]$v) { '{0:X2}' -f ($v -band 0xFF) }

# 입력 feature map 값 정의
function Get-X([int]$p, [int]$c) {
    return (($c % 8) - 4) + ($p % 8) + [int][math]::Floor($c / $LANES)
}

# 줄 목록을 .coe(헤더+쉼표) 와 .mem(순수 hex) 두 형태로 저장
function Write-Both([string]$name, [System.Collections.Generic.List[string]]$rows) {
    $coe = New-Object System.Collections.Generic.List[string]
    $coe.Add('memory_initialization_radix=16;')
    $coe.Add('memory_initialization_vector=')
    for ($i = 0; $i -lt $rows.Count; $i++) {
        $term = if ($i -eq $rows.Count - 1) { ';' } else { ',' }
        $coe.Add($rows[$i] + $term)
    }
    Set-Content -Path (Join-Path $outDir "$name.coe") -Value $coe -Encoding ascii
    Set-Content -Path (Join-Path $outDir "$name.mem") -Value $rows -Encoding ascii
    Write-Host ("{0,-30} {1,5} lines x {2}-bit" -f $name, $rows.Count, ($rows[0].Length * 4))
}

# ---------------- input feature map (p*6 + g) ----------------
$rows = New-Object System.Collections.Generic.List[string]
for ($p = 0; $p -lt $PIX; $p++) {
    for ($g = 0; $g -lt $CHUNK; $g++) {
        $sb = New-Object System.Text.StringBuilder
        # lane63 -> lane0 (MSB first)
        for ($i = $LANES - 1; $i -ge 0; $i--) {
            [void]$sb.Append((To-Hex8 (Get-X $p ($g * $LANES + $i))))
        }
        [void]$rows.Add($sb.ToString())
    }
}
Write-Both 'input_after_depth' $rows

# ---------------- weight : one-hot (+1) ----------------
# addr = oc*6 + g (oc-major). 픽셀을 최상위 루프에 두면 weight 주소가
# 0~383 단순 증가가 되도록 하는 배치다.
# hot 채널 c = 6*oc -> chunk g_hot = c/64, lane = c%64
$rows = New-Object System.Collections.Generic.List[string]
for ($oc = 0; $oc -lt $OUT_CH; $oc++) {
    for ($g = 0; $g -lt $CHUNK; $g++) {
        $c     = 6 * $oc
        $gHot  = [int][math]::Floor($c / $LANES)
        $hot   = $c % $LANES
        $sb = New-Object System.Text.StringBuilder
        for ($i = $LANES - 1; $i -ge 0; $i--) {
            if (($g -eq $gHot) -and ($i -eq $hot)) { [void]$sb.Append('01') }
            else                                   { [void]$sb.Append('00') }
        }
        [void]$rows.Add($sb.ToString())
    }
}
Write-Both 'weight_after_depth_onehot' $rows

# ---------------- weight : all +1 ----------------
$rows = New-Object System.Collections.Generic.List[string]
$all1 = '01' * $LANES
for ($oc = 0; $oc -lt $OUT_CH; $oc++) {
    for ($g = 0; $g -lt $CHUNK; $g++) { [void]$rows.Add($all1) }
}
Write-Both 'weight_after_depth_all1' $rows

# ---------------- bias : 채널마다 다른 값 ----------------
# 출력채널당 1개, int32.
#
# bias[oc] = (oc+1) * 10000  으로 두면 십진수로 읽을 때 자릿수가 분리된다.
#   MAC 부분 최대값이 768 + 384*7 = 3456 (네 자리) 이므로
#   전체값 = (oc+1)"0000" + MAC  ->  앞자리가 채널, 뒤 네 자리가 MAC
#   예) oc=0,pix=0 -> 10768   (1 / 0768)
#       oc=63,pix=7 -> 643456 (64 / 3456)
#
# oc=0 을 0 으로 두면 bias 가 연결됐는지조차 안 보이므로 (oc+1) 로 시작한다.
$rows = New-Object System.Collections.Generic.List[string]
for ($oc = 0; $oc -lt $OUT_CH; $oc++) {
    $v = ($oc + 1) * 10000
    [void]$rows.Add('{0:X8}' -f ($v -band 0xFFFFFFFF))   # int32, 2의 보수
}
Write-Both 'bias_after_depth' $rows

# ---------------- bias : 부호 섞기 ----------------
# 홀수 채널을 음수로 만들어 signed 처리를 검증한다.
# bias_data 가 unsigned 로 선언돼 있으면 음수가 40억대 양수로 나와서 즉시 드러난다.
$rows = New-Object System.Collections.Generic.List[string]
for ($oc = 0; $oc -lt $OUT_CH; $oc++) {
    $v = ($oc + 1) * 10000
    if ($oc % 2 -eq 1) { $v = -$v }
    [void]$rows.Add('{0:X8}' -f ($v -band 0xFFFFFFFF))
}
Write-Both 'bias_after_depth_signed' $rows

Write-Host "generated in $outDir"
