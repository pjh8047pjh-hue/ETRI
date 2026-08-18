# Layer 08 Project Pointwise waveform-debug COE generator.
#
# Current data path:
#   input  : signed Q3.12, 16-bit x 64 = 1024-bit, depth 196*6 = 1176
#   weight : signed Q3.12, 16-bit x 64 = 1024-bit, depth 64*6  = 384
#   bias   : signed Q24 INT32, depth 64
#
# Rows are lane63 ... lane0 because RTL extracts data[i*16 +: 16].

$ErrorActionPreference = 'Stop'
$outDir = $PSScriptRoot

$LANES  = 64
$CHUNK  = 6
$PIX    = 196
$OUT_CH = 64

function Hex16([int]$Value) {
    return '{0:X4}' -f ($Value -band 0xFFFF)
}

function Hex32([long]$Value) {
    return '{0:X8}' -f ($Value -band 0xFFFFFFFFL)
}

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

# Standalone Project input at address pixel*6+chunk.
# Raw Q3.12 = (pixel mod 8)*256 + lane*16 + chunk, range 0..0x0AED.
function Get-InputRaw([int]$Pixel, [int]$Channel) {
    $chunk = [int][math]::Floor($Channel / $LANES)
    $lane  = $Channel % $LANES
    return (($Pixel % 8) * 256) + ($lane * 16) + $chunk
}

$rows = New-Object System.Collections.Generic.List[string]
for ($p = 0; $p -lt $PIX; $p++) {
    for ($g = 0; $g -lt $CHUNK; $g++) {
        $sb = New-Object System.Text.StringBuilder
        for ($lane = $LANES - 1; $lane -ge 0; $lane--) {
            [void]$sb.Append((Hex16 (Get-InputRaw $p ($g * $LANES + $lane))))
        }
        [void]$rows.Add($sb.ToString())
    }
}
Write-CoeAndMem 'input_after_depth' $rows

# One-hot +1.0 Q3.12. Output oc selects input channel 6*oc.
$rows = New-Object System.Collections.Generic.List[string]
for ($oc = 0; $oc -lt $OUT_CH; $oc++) {
    $selectedChannel = 6 * $oc
    $hotChunk = [int][math]::Floor($selectedChannel / $LANES)
    $hotLane  = $selectedChannel % $LANES
    for ($g = 0; $g -lt $CHUNK; $g++) {
        $sb = New-Object System.Text.StringBuilder
        for ($lane = $LANES - 1; $lane -ge 0; $lane--) {
            if (($g -eq $hotChunk) -and ($lane -eq $hotLane)) {
                [void]$sb.Append('1000')
            } else {
                [void]$sb.Append('0000')
            }
        }
        [void]$rows.Add($sb.ToString())
    }
}
Write-CoeAndMem 'weight_after_depth_onehot' $rows

# All +1.0 Q3.12 for checking each 64-lane group sum.
$rows = New-Object System.Collections.Generic.List[string]
$allOneRow = '1000' * $LANES
for ($oc = 0; $oc -lt $OUT_CH; $oc++) {
    for ($g = 0; $g -lt $CHUNK; $g++) {
        [void]$rows.Add($allOneRow)
    }
}
Write-CoeAndMem 'weight_after_depth_all1' $rows

# Default zero Q24 bias keeps the one-hot output transparent.
$rows = New-Object System.Collections.Generic.List[string]
for ($oc = 0; $oc -lt $OUT_CH; $oc++) {
    [void]$rows.Add('00000000')
}
Write-CoeAndMem 'bias_after_depth' $rows

# Optional signed Q24 bias: +/- (oc+1)/64. Q24 step = 2^18 = 0x40000.
$rows = New-Object System.Collections.Generic.List[string]
for ($oc = 0; $oc -lt $OUT_CH; $oc++) {
    $raw = [long]($oc + 1) * 0x00040000L
    if (($oc % 2) -eq 1) { $raw = -$raw }
    [void]$rows.Add((Hex32 $raw))
}
Write-CoeAndMem 'bias_after_depth_signed' $rows

Write-Host "Generated Layer 08 Project debug files in $outDir"
