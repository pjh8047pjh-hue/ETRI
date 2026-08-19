# Layer 08 waveform debug COE guide

## IP mapping

| Stage | IP | COE | Width x depth | Format |
|---|---|---|---:|---|
| Expand input | `input_bram_ip` | `input_pointwise_ramp.coe` | 1024 x 196 | 64 lanes, signed Q3.12 |
| Expand weight | `pointwise_before_depth_weight` | `weight_pointwise_identity.coe` | 1024 x 384 | 64 lanes, signed Q3.12 |
| Expand bias | `pointwise_before_depth_bias` | `bias_pointwise_before_zero.coe` | 32 x 384 | signed Q24 |
| Expand bias test | same IP, optional | `bias_pointwise_before_debug.coe` | 32 x 384 | signed Q24 |
| Depthwise weight | `blk_mem_gen_0` | `weight_depthwise_all1.coe` | 144 x 384 | 9 lanes, signed Q3.12 |
| Depthwise bias | `depth_bias` | `depth_bias_debug.coe` | 32 x 384 | signed Q3.12 in INT32 |
| Project input test | optional standalone ROM | `input_after_depth.coe` | 1024 x 1176 | 64 lanes, signed Q3.12 |
| Project weight | `pointwise_after_depth_weight` | `weight_after_depth_onehot.coe` | 1024 x 384 | 64 lanes, signed Q3.12 |
| Project bias | `pointwise_after_depth_bias` | `bias_after_depth.coe` | 32 x 64 | signed Q24, all zero |
| Project bias test | same IP, optional | `bias_after_depth_signed.coe` | 32 x 64 | signed Q24 |

The packed lane order is `lane63 ... lane0` in a COE row. In RTL, lane 0 is
the least-significant 16 bits (`bus[0 +: 16]`).

## Expected waveform values

### Expand Pointwise

- Input raw value: `x[p][ic] = 2 * (p*64 + ic)`.
- Weight output channel `oc`: only lane `oc % 64` is `16'h0800` (=0.5), all other lanes are zero.
- With `bias_pointwise_before_zero.coe`:

```text
output_raw[oc][p] = p*64 + (oc % 64)
```

Examples in channel-major output order:

| output channel | pixel | expected decimal | expected hex |
|---:|---:|---:|---:|
| 0 | 0 | 0 | `0000` |
| 0 | 1 | 64 | `0040` |
| 0 | 2 | 128 | `0080` |
| 1 | 0 | 1 | `0001` |

The optional signed Expand bias pattern repeats:

```text
0, +0.25, +0.5, +0.75, +1, -0.25, -0.5, -1
```

Its Q24 hex values are `00000000, 00400000, 00800000, 00C00000,
01000000, FFC00000, FF800000, FF000000`.

### Depthwise

- All nine weights are `16'h1000` (=1.0).
- Bias repeats `0,1,2,3,4,5,6,-1`; the ROM stores sign-extended Q3.12.
- Channel 0, pixel 0 sums the valid 2x2 input positions, so the first expected
  output is decimal `1920` (`16'h0780`).
- ReLU6 clamps the output to `0 ... 16'h6000`.

### Project Pointwise standalone pattern

- Input ROM address is `pixel*6 + chunk`.
- Input raw value is `(pixel % 8)*256 + lane*16 + chunk`.
- One-hot weight output channel `oc` selects input channel `6*oc` with
  `16'h1000` (=1.0).
- With zero bias and correct Q24-to-Q3.12 post-processing:

```text
output_raw[p][oc] = input_raw[p][6*oc]
```

For the integrated design, the Project input comes from the depthwise
interconnect BRAM rather than `input_after_depth.coe`.

## Two-way parallel integrated example

With the current debug COEs (`bias_pointwise_before_debug.coe`,
`depth_bias_debug.coe`, and `bias_after_depth_signed.coe`), follow pair 0 in
the `00A SAMPLE PAIR0 TRACE` waveform group.

| Stage | Expected decimal | Expected hex |
|---|---:|---:|
| PW-before channel 0, pixel 0 | 0 | `0000` |
| PW-before channel 1, pixel 0 | 1025 | `0401` |
| PW-before pair word | `{1025, 0}` | `04010000` |
| Depth channel 0, output pixel 0 | 1920 | `0780` |
| Depth channel 1, output pixel 0 | 10116 | `2784` |
| Depth pair word | `{10116, 1920}` | `27840780` |
| PW-after channel 0, pixel 0 raw | 1984 | `07C0` |
| PW-after channel 0, pixel 1 raw | 3136 | `0C40` |
| Skip pixel 0 / pixel 1 | 0 / 128 | `0000` / `0080` |
| Final serialized output pixel 0 / pixel 1 | 1984 / 3264 | `07C0` / `0CC0` |

`pointwise_after_depth.sv` currently adds the signed 32-bit Q24 bias and applies
the arithmetic `>>>12` conversion before producing the 16-bit Q3.12 result.

## Vivado setup

1. Select the COE shown in the table for each Block Memory Generator.
2. Set the Expand input Port B, Expand weight Port A, and Expand bias Port A
   read latency to 2, matching `top_pointwise_before_depth`.
3. Regenerate Output Products before behavioral simulation.
4. Use `bias_pointwise_before_zero.coe` and `bias_after_depth.coe` first; switch
   to the signed test files only when checking bias sign extension/alignment.

Regenerate all files with:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\gen_coe.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\gen_coe_after_depth.ps1
```
