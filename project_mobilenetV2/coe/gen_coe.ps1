# =============================================================================
# pointwise/depthwise 디버깅용 .coe 생성 스크립트
#
#   input_pointwise_ramp.coe      1024-bit x 196  (입력 feature map)
#   weight_pointwise_identity.coe 1024-bit x 384  (pointwise weight, 항등)
#
# 설계 의도
#   x[p][ic] = 2 * (p*64 + ic)                     ... 짝수 램프
#   w[oc][ic] = 0.5(0x4000) if ic == oc%64 else 0  ... 항등 + 1/2
#   => out[p][oc] = (x[p][oc%64] * 0x4000) >>> 15 = p*64 + (oc%64)
#
#   p = r*14 + c 이므로 out = 896*r + 64*c + k (k = oc%64).
#   r, c에 대해 선형이라 depthwise 3x3 all-1 결과는 내부 픽셀에서
#   정확히 9 * (중심값)이 된다. 가장자리는 빠진 padding 개수가 바로 보인다.
#
# 비트 순서
#   RTL이 data[ic*16 +: 16]로 채널을 뽑으므로 ic=0이 LSB다.
#   .coe 한 줄은 MSB가 왼쪽이므로 ch63 ... ch0 순으로 적는다.
# =============================================================================

$ErrorActionPreference = 'Stop'
$outDir = $PSScriptRoot

# PowerShell 변수는 대소문자를 구분하지 않는다. 루프 변수 $oc 와 겹치지 않도록
# 출력 채널 수는 $OUT_CH 로 둔다.
$IN_CH  = 64     # pointwise_pkg::IN_CH
$PIX    = 196    # pointwise_pkg::CHANNEL_WIDTH (14 x 14)
$OUT_CH = 384    # pointwise_pkg::WEIGHT_WIDTH

# ---------------- input feature map ----------------
$lines = New-Object System.Collections.Generic.List[string]
$lines.Add('memory_initialization_radix=16;')
$lines.Add('memory_initialization_vector=')

for ($p = 0; $p -lt $PIX; $p++) {
    $sb = New-Object System.Text.StringBuilder
    # ch63 -> ch0 (MSB first)
    for ($ic = $IN_CH - 1; $ic -ge 0; $ic--) {
        $val = 2 * ($p * $IN_CH + $ic)     # 최대 2*12543 = 25086, 16-bit 부호 안전
        [void]$sb.Append('{0:X4}' -f $val)
    }
    $term = if ($p -eq $PIX - 1) { ';' } else { ',' }
    $lines.Add($sb.ToString() + $term)
}
Set-Content -Path (Join-Path $outDir 'input_pointwise_ramp.coe') -Value $lines -Encoding ascii

# ---------------- pointwise weight (identity x 0.5) ----------------
$lines = New-Object System.Collections.Generic.List[string]
$lines.Add('memory_initialization_radix=16;')
$lines.Add('memory_initialization_vector=')

for ($oc = 0; $oc -lt $OUT_CH; $oc++) {
    $hot = $oc % $IN_CH
    $sb = New-Object System.Text.StringBuilder
    for ($ic = $IN_CH - 1; $ic -ge 0; $ic--) {
        if ($ic -eq $hot) { [void]$sb.Append('0800') }   # Q3.12의 0.5
        else              { [void]$sb.Append('0000') }
    }
    $term = if ($oc -eq $OUT_CH - 1) { ';' } else { ',' }
    $lines.Add($sb.ToString() + $term)
}
Set-Content -Path (Join-Path $outDir 'weight_pointwise_identity.coe') -Value $lines -Encoding ascii

# ---------------- depthwise weight (3x3 all +1.0, Q3.12) ----------------
$lines = New-Object System.Collections.Generic.List[string]
$lines.Add('memory_initialization_radix=16;')
$lines.Add('memory_initialization_vector=')
$depthRow = '1000' * 9
for ($ch = 0; $ch -lt 384; $ch++) {
    $term = if ($ch -eq 383) { ';' } else { ',' }
    $lines.Add($depthRow + $term)
}
Set-Content -Path (Join-Path $outDir 'weight_depthwise_all1.coe') -Value $lines -Encoding ascii

# ---------------- depthwise bias (Q3.12 debug pattern) ----------------
# 채널마다 0, 1, 2, ... 6, -1을 반복한다.
$lines = New-Object System.Collections.Generic.List[string]
$lines.Add('memory_initialization_radix=16;')
$lines.Add('memory_initialization_vector=')
for ($ch = 0; $ch -lt 384; $ch++) {
    $biasReal = $ch % 8
    if ($biasReal -eq 7) { $biasReal = -1 }
    $biasRaw = $biasReal * 4096
    $term = if ($ch -eq 383) { ';' } else { ',' }
    $lines.Add(('{0:X8}' -f ($biasRaw -band 0xFFFFFFFF)) + $term)
}
Set-Content -Path (Join-Path $outDir 'depth_bias_debug.coe') -Value $lines -Encoding ascii

Write-Host "generated in $outDir"
