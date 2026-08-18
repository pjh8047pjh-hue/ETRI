# Layer 08 Expand Pointwise / Depthwise waveform-debug COE generator.
#
# Current RTL formats:
#   Expand input/weight : signed Q3.12, 16-bit
#   Expand bias         : signed Q24,    32-bit (before >>> 12)
#   Depthwise weight    : signed Q3.12, 16-bit x 9
#   Depthwise bias      : signed Q3.12, 32-bit container (after MAC >>> 12)
#
# COE words are MSB first. RTL lane 0 is the rightmost 16-bit value.

$ErrorActionPreference = 'Stop'
$outDir = $PSScriptRoot

function Write-CoeAndMem(
    [string]$Name,
    [System.Collections.Generic.List[string]]$Rows
) {
    $coe = New-Object System.Collections.Generic.List[string]
    $coe.Add('memory_initialization_radix=16;')
    $coe.Add('memory_initialization_vector=')
    for ($i = 0; $i -lt $Rows.Count; $i++) {
        $term = if ($i -eq $Rows.Count - 1) { ';' } else { ',' }
        $coe.Add($Rows[$i] + $term)
    }

    Set-Content -LiteralPath (Join-Path $outDir "$Name.coe") -Value $coe -Encoding ascii
    Set-Content -LiteralPath (Join-Path $outDir "$Name.mem") -Value $Rows -Encoding ascii
    Write-Host ("{0,-36} {1,6} rows x {2,4} bits" -f $Name, $Rows.Count, ($Rows[0].Length * 4))
}

function Hex16([int]$Value) {
    return '{0:X4}' -f ($Value -band 0xFFFF)
}

function Hex32([long]$Value) {
    return '{0:X8}' -f ($Value -band 0xFFFFFFFFL)
}

$IN_CH  = 64
$PIX    = 196
$OUT_CH = 384

# x_raw[p][ic] = 2*(p*64+ic). With the 0.5 identity weight below,
# the result after >>>12 is exactly p*64+(oc mod 64).
$rows = New-Object System.Collections.Generic.List[string]
for ($p = 0; $p -lt $PIX; $p++) {
    $sb = New-Object System.Text.StringBuilder
    for ($ic = $IN_CH - 1; $ic -ge 0; $ic--) {
        [void]$sb.Append((Hex16 (2 * ($p * $IN_CH + $ic))))
    }
    [void]$rows.Add($sb.ToString())
}
Write-CoeAndMem 'input_pointwise_ramp' $rows

# One 0.5(Q3.12=0x0800) lane per output channel.
$rows = New-Object System.Collections.Generic.List[string]
for ($oc = 0; $oc -lt $OUT_CH; $oc++) {
    $hot = $oc % $IN_CH
    $sb = New-Object System.Text.StringBuilder
    for ($ic = $IN_CH - 1; $ic -ge 0; $ic--) {
        [void]$sb.Append($(if ($ic -eq $hot) { '0800' } else { '0000' }))
    }
    [void]$rows.Add($sb.ToString())
}
Write-CoeAndMem 'weight_pointwise_identity' $rows
Write-CoeAndMem 'weight_pointwise_copy' $rows

# Default zero Q24 bias keeps the end-to-end expected value simple.
$rows = New-Object System.Collections.Generic.List[string]
for ($oc = 0; $oc -lt $OUT_CH; $oc++) {
    [void]$rows.Add('00000000')
}
Write-CoeAndMem 'bias_pointwise_before_zero' $rows

# Optional signed Q24 test pattern: 0,+0.25,+0.5,+0.75,+1,-0.25,-0.5,-1.
$biasQ24 = @(0x00000000L, 0x00400000L, 0x00800000L, 0x00C00000L,
             0x01000000L, -0x00400000L, -0x00800000L, -0x01000000L)
$rows = New-Object System.Collections.Generic.List[string]
for ($oc = 0; $oc -lt $OUT_CH; $oc++) {
    [void]$rows.Add((Hex32 $biasQ24[$oc % $biasQ24.Count]))
}
Write-CoeAndMem 'bias_pointwise_before_debug' $rows

# All nine depthwise taps are +1.0 (Q3.12=0x1000).
$rows = New-Object System.Collections.Generic.List[string]
$depthRow = '1000' * 9
for ($ch = 0; $ch -lt $OUT_CH; $ch++) {
    [void]$rows.Add($depthRow)
}
Write-CoeAndMem 'weight_depthwise_all1' $rows

# Depthwise bias is added after MAC >>>12, hence sign-extended Q3.12.
# Values repeat 0,1,...,6,-1.
$rows = New-Object System.Collections.Generic.List[string]
for ($ch = 0; $ch -lt $OUT_CH; $ch++) {
    $integerBias = $ch % 8
    if ($integerBias -eq 7) { $integerBias = -1 }
    [void]$rows.Add((Hex32 ([long]$integerBias * 4096L)))
}
Write-CoeAndMem 'depth_bias_debug' $rows

Write-Host "Generated Layer 08 Expand/Depthwise debug files in $outDir"
