#!/usr/bin/env python3
"""Convert layer08 pointwise-conv weights and layer07 output activations to
fixed16 .coe files for blk_mem_gen_0 (weight ROM) and blk_mem_gen_input
(input activation BRAM), per week6/pointwise_conv/spec_pointwise.md.

Weight format:     Q1.15  (scale = 2**15), row = one output channel (oc), 384 rows
Activation format: Q2.13  (scale = 2**13), row = one pixel (pix),       196 rows
Each row packs IN_CH=64 int16 lanes into a 1024-bit word, ic=0 at bit[15:0].
"""
import re
import struct
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[3]
PARAMS_H = REPO_ROOT / "week1/06_25/06_26/MobileNet/mobilenetv2_parameters.h"
LAYER07_BIN = REPO_ROOT / "week1/06_25/06_26/MobileNet/MobileNet_v2/mobilenetv2_result_layer07.bin"
OUT_DIR = Path(__file__).resolve().parent.parent / "coe"

IN_CH = 64
WEIGHT_WIDTH = 384   # output channels
CHANNEL_WIDTH = 196  # pixels (14x14)

WEIGHT_SCALE = 2 ** 15  # Q1.15
ACT_SCALE = 2 ** 13     # Q2.13

INT16_MIN, INT16_MAX = -32768, 32767


def quantize(values, scale):
    fixed = []
    clamped = 0
    for v in values:
        q = round(v * scale)
        if q < INT16_MIN or q > INT16_MAX:
            clamped += 1
            q = max(INT16_MIN, min(INT16_MAX, q))
        fixed.append(q)
    return fixed, clamped


def load_weight_array(name, count):
    text = PARAMS_H.read_text()
    m = re.search(re.escape(name) + r"\s*\[\d+\]\s*=", text)
    if not m:
        raise ValueError(f"array {name} not found in {PARAMS_H}")
    start = m.end()
    end = text.index(";", start)
    nums = re.findall(r"-?\d+\.\d+(?:[eE][-+]?\d+)?", text[start:end])
    if len(nums) != count:
        raise ValueError(f"{name}: expected {count} values, found {len(nums)}")
    return [float(x) for x in nums]


def load_layer07_activations(count):
    data = LAYER07_BIN.read_bytes()
    expected_bytes = count * 4
    if len(data) != expected_bytes:
        raise ValueError(f"{LAYER07_BIN}: expected {expected_bytes} bytes, found {len(data)}")
    return list(struct.unpack(f"<{count}f", data))


def pack_row(lanes_fixed16):
    word = 0
    for ic, val in enumerate(lanes_fixed16):
        word |= (val & 0xFFFF) << (16 * ic)
    return word


def write_coe(path, rows_hex):
    with open(path, "w") as f:
        f.write("memory_initialization_radix=16;\n")
        f.write("memory_initialization_vector=\n")
        f.write(",\n".join(rows_hex))
        f.write(";\n")


def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    # ---- weights: features_8_conv_0_0_weight[24576], layout [oc(384)][ic(64)] ----
    weight_floats = load_weight_array("features_8_conv_0_0_weight", IN_CH * WEIGHT_WIDTH)
    weight_fixed, weight_clamped = quantize(weight_floats, WEIGHT_SCALE)

    weight_rows_hex = []
    for oc in range(WEIGHT_WIDTH):
        lanes = weight_fixed[oc * IN_CH:(oc + 1) * IN_CH]
        weight_rows_hex.append(format(pack_row(lanes), f"0{IN_CH * 4}X"))

    write_coe(OUT_DIR / "weight_layer08.coe", weight_rows_hex)

    # ---- activations: layer07 output, layout [ic(64)][pix(196)] (channel-major) ----
    act_floats = load_layer07_activations(IN_CH * CHANNEL_WIDTH)
    act_fixed, act_clamped = quantize(act_floats, ACT_SCALE)

    act_rows_hex = []
    for pix in range(CHANNEL_WIDTH):
        lanes = [act_fixed[ic * CHANNEL_WIDTH + pix] for ic in range(IN_CH)]
        act_rows_hex.append(format(pack_row(lanes), f"0{IN_CH * 4}X"))

    write_coe(OUT_DIR / "input_layer08.coe", act_rows_hex)

    # ---- summary ----
    def err_stats(floats, fixed, scale):
        errs = [abs(f - q / scale) for f, q in zip(floats, fixed)]
        return max(errs), (sum(e * e for e in errs) / len(errs)) ** 0.5

    w_max_err, w_rms = err_stats(weight_floats, weight_fixed, WEIGHT_SCALE)
    a_max_err, a_rms = err_stats(act_floats, act_fixed, ACT_SCALE)

    print("weight_layer08.coe:")
    print(f"  rows={len(weight_rows_hex)} (expect {WEIGHT_WIDTH}), row width={len(weight_rows_hex[0])} hex chars (expect {IN_CH*4})")
    print(f"  float range=[{min(weight_floats):.6f}, {max(weight_floats):.6f}]  scale=1/{WEIGHT_SCALE} (Q1.15)")
    print(f"  quant max_abs_err={w_max_err:.6e}  rms_err={w_rms:.6e}  clamped={weight_clamped}")

    print("input_layer08.coe:")
    print(f"  rows={len(act_rows_hex)} (expect {CHANNEL_WIDTH}), row width={len(act_rows_hex[0])} hex chars (expect {IN_CH*4})")
    print(f"  float range=[{min(act_floats):.6f}, {max(act_floats):.6f}]  scale=1/{ACT_SCALE} (Q2.13)")
    print(f"  quant max_abs_err={a_max_err:.6e}  rms_err={a_rms:.6e}  clamped={act_clamped}")


if __name__ == "__main__":
    main()
