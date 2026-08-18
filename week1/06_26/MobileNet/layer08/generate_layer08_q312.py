"""Generate Layer 08 expand-pointwise Q3.12 BIN/COE initialization files.

The 64 input channels form one 1024-bit IFM word for each spatial position.
For the main weight image, each word contains one input channel's weights for
the 64 output channels in a chunk; address = chunk*64 + input_channel.  In both
formats lane j occupies word[16*j +: 16], so lane 0 is the least-significant
16 bits of the hexadecimal COE word.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import re
import struct
from pathlib import Path
from typing import Iterable, Sequence


CIN = 64
COUT = 384
HEIGHT = 14
WIDTH = 14
HW = HEIGHT * WIDTH
FRAC_BITS = 12
BIAS_FRAC_BITS = 24
RELU6_Q = 0x6000
BN_EPSILON = 1.0e-5


def round_half_away_from_zero(value: float) -> int:
    if value >= 0.0:
        return math.floor(value + 0.5)
    return math.ceil(value - 0.5)


def quantize(values: Iterable[float], bits: int, frac_bits: int) -> tuple[list[int], int]:
    lower = -(1 << (bits - 1))
    upper = (1 << (bits - 1)) - 1
    scale = 1 << frac_bits
    result: list[int] = []
    saturation_count = 0
    for value in values:
        raw = round_half_away_from_zero(value * scale)
        if raw < lower:
            raw = lower
            saturation_count += 1
        elif raw > upper:
            raw = upper
            saturation_count += 1
        result.append(raw)
    return result, saturation_count


def read_f32_le(path: Path, expected_count: int) -> list[float]:
    payload = path.read_bytes()
    expected_size = expected_count * 4
    if len(payload) != expected_size:
        raise ValueError(f"{path}: expected {expected_size} bytes, got {len(payload)}")
    return list(struct.unpack(f"<{expected_count}f", payload))


def parse_c_float_array(header: str, name: str, expected_count: int) -> list[float]:
    pattern = re.compile(
        rf"const\s+float\s+{re.escape(name)}\s*\[\s*(\d+)\s*\]\s*=\s*\{{(.*?)\}}\s*;",
        re.DOTALL,
    )
    match = pattern.search(header)
    if not match:
        raise ValueError(f"array {name!r} was not found")
    declared_count = int(match.group(1))
    values = [float(token) for token in match.group(2).replace("\n", " ").split(",") if token.strip()]
    if declared_count != expected_count or len(values) != expected_count:
        raise ValueError(
            f"{name}: declared={declared_count}, parsed={len(values)}, expected={expected_count}"
        )
    return values


def fold_expand_parameters(header_path: Path) -> tuple[list[float], list[float]]:
    header = header_path.read_text(encoding="utf-8")
    weight = parse_c_float_array(header, "features_8_conv_0_0_weight", COUT * CIN)
    gamma = parse_c_float_array(header, "features_8_conv_0_1_weight", COUT)
    beta = parse_c_float_array(header, "features_8_conv_0_1_bias", COUT)
    mean = parse_c_float_array(header, "features_8_conv_0_1_running_mean", COUT)
    variance = parse_c_float_array(header, "features_8_conv_0_1_running_var", COUT)

    folded_weight = [0.0] * (COUT * CIN)
    folded_bias = [0.0] * COUT
    for oc in range(COUT):
        bn_scale = gamma[oc] / math.sqrt(variance[oc] + BN_EPSILON)
        folded_bias[oc] = beta[oc] - mean[oc] * bn_scale
        row = oc * CIN
        for ic in range(CIN):
            folded_weight[row + ic] = weight[row + ic] * bn_scale
    return folded_weight, folded_bias


def fixed_expand(
    input_q: Sequence[int], weight_q: Sequence[int], bias_q: Sequence[int]
) -> tuple[list[int], int, int]:
    output_q = [0] * (COUT * HW)
    acc_min = (1 << 63) - 1
    acc_max = -(1 << 63)
    rounding = 1 << (FRAC_BITS - 1)
    for oc in range(COUT):
        weight_row = oc * CIN
        output_row = oc * HW
        for pos in range(HW):
            acc = bias_q[oc]
            for ic in range(CIN):
                acc += input_q[ic * HW + pos] * weight_q[weight_row + ic]
            acc_min = min(acc_min, acc)
            acc_max = max(acc_max, acc)
            if acc <= 0:
                output = 0
            else:
                output = (acc + rounding) >> FRAC_BITS
                output = min(output, RELU6_Q)
            output_q[output_row + pos] = output
    return output_q, acc_min, acc_max


def float_expand(
    input_f32: Sequence[float], weight_f32: Sequence[float], bias_f32: Sequence[float]
) -> list[float]:
    output = [0.0] * (COUT * HW)
    for oc in range(COUT):
        weight_row = oc * CIN
        output_row = oc * HW
        for pos in range(HW):
            acc = bias_f32[oc]
            for ic in range(CIN):
                acc += input_f32[ic * HW + pos] * weight_f32[weight_row + ic]
            output[output_row + pos] = min(max(acc, 0.0), 6.0)
    return output


def pack_unsigned(value: int, bits: int) -> int:
    return value & ((1 << bits) - 1)


def pack_lanes(lanes: Sequence[int], lane_bits: int) -> int:
    word = 0
    for lane, value in enumerate(lanes):
        word |= pack_unsigned(value, lane_bits) << (lane * lane_bits)
    return word


def input_words(input_q: Sequence[int]) -> list[int]:
    return [pack_lanes([input_q[ic * HW + pos] for ic in range(CIN)], 16) for pos in range(HW)]


def weight_words(weight_q: Sequence[int]) -> list[int]:
    words: list[int] = []
    for chunk in range(COUT // CIN):
        for ic in range(CIN):
            words.append(
                pack_lanes(
                    [weight_q[(chunk * CIN + lane) * CIN + ic] for lane in range(CIN)],
                    16,
                )
            )
    return words


def weight_oc_row_words(weight_q: Sequence[int]) -> list[int]:
    return [pack_lanes(weight_q[oc * CIN : (oc + 1) * CIN], 16) for oc in range(COUT)]


def chunk_bias_words(bias_q: Sequence[int]) -> list[int]:
    return [pack_lanes(bias_q[chunk * CIN : (chunk + 1) * CIN], 32) for chunk in range(COUT // CIN)]


def chunk_output_words(output_q: Sequence[int]) -> list[int]:
    words: list[int] = []
    for chunk in range(COUT // CIN):
        for pos in range(HW):
            words.append(
                pack_lanes([output_q[(chunk * CIN + lane) * HW + pos] for lane in range(CIN)], 16)
            )
    return words


def write_coe(path: Path, words: Sequence[int], width_bits: int) -> None:
    digits = (width_bits + 3) // 4
    lines = ["memory_initialization_radix=16;", "memory_initialization_vector="]
    for index, word in enumerate(words):
        terminator = ";" if index == len(words) - 1 else ","
        lines.append(f"{word:0{digits}x}{terminator}")
    path.write_text("\n".join(lines) + "\n", encoding="ascii")


def write_i16_bin(path: Path, values: Sequence[int]) -> None:
    path.write_bytes(struct.pack(f"<{len(values)}h", *values))


def write_i32_bin(path: Path, values: Sequence[int]) -> None:
    path.write_bytes(struct.pack(f"<{len(values)}i", *values))


def write_f32_bin(path: Path, values: Sequence[float]) -> None:
    path.write_bytes(struct.pack(f"<{len(values)}f", *values))


def write_wide_bin(path: Path, words: Sequence[int], width_bits: int) -> None:
    if width_bits % 8:
        raise ValueError("binary memory words must be byte-aligned")
    bytes_per_word = width_bits // 8
    path.write_bytes(b"".join(word.to_bytes(bytes_per_word, "little") for word in words))


def validate_wide_bin(path: Path, words: Sequence[int], width_bits: int) -> None:
    bytes_per_word = width_bits // 8
    payload = path.read_bytes()
    if len(payload) != len(words) * bytes_per_word:
        raise ValueError(f"{path}: invalid packed binary size")
    for index, expected in enumerate(words):
        begin = index * bytes_per_word
        actual = int.from_bytes(payload[begin : begin + bytes_per_word], "little")
        if actual != expected:
            raise ValueError(f"{path}: packed word {index} mismatch")


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def source_label(path: Path, base_dir: Path) -> str:
    try:
        return path.resolve().relative_to(base_dir.resolve()).as_posix()
    except ValueError:
        return path.name


def metrics(actual_q: Sequence[int], reference: Sequence[float]) -> dict[str, float]:
    scale = 1 << FRAC_BITS
    errors = [abs(value / scale - ref) for value, ref in zip(actual_q, reference)]
    squared = [(value / scale - ref) ** 2 for value, ref in zip(actual_q, reference)]
    return {
        "max_abs_error": max(errors),
        "mean_abs_error": sum(errors) / len(errors),
        "rmse": math.sqrt(sum(squared) / len(squared)),
    }


def validate_coe(path: Path, expected_words: int, width_bits: int) -> None:
    lines = path.read_text(encoding="ascii").splitlines()
    if lines[:2] != ["memory_initialization_radix=16;", "memory_initialization_vector="]:
        raise ValueError(f"{path}: invalid COE header")
    tokens = [line.rstrip(",;") for line in lines[2:]]
    expected_digits = width_bits // 4
    if len(tokens) != expected_words or any(len(token) != expected_digits for token in tokens):
        raise ValueError(f"{path}: invalid word count or width")
    if not lines[-1].endswith(";") or any(line.endswith(";") for line in lines[2:-1]):
        raise ValueError(f"{path}: invalid COE terminator")


def generate(input_path: Path, header_path: Path, output_dir: Path) -> dict[str, object]:
    output_dir.mkdir(parents=True, exist_ok=True)
    input_f32 = read_f32_le(input_path, CIN * HW)
    weight_f32, bias_f32 = fold_expand_parameters(header_path)

    input_q, input_saturation = quantize(input_f32, 16, FRAC_BITS)
    weight_q, weight_saturation = quantize(weight_f32, 16, FRAC_BITS)
    bias_q, bias_saturation = quantize(bias_f32, 32, BIAS_FRAC_BITS)
    output_q, acc_min, acc_max = fixed_expand(input_q, weight_q, bias_q)
    output_f32 = float_expand(input_f32, weight_f32, bias_f32)

    if not -(1 << 31) <= acc_min <= acc_max <= (1 << 31) - 1:
        raise OverflowError(f"Q7.24 accumulator exceeds INT32: [{acc_min}, {acc_max}]")

    binary_outputs = {
        "q312_input_chw_int16.bin": (write_i16_bin, input_q),
        "q312_expand_weight_oc_ic_int16.bin": (write_i16_bin, weight_q),
        "q312_expand_bias_int32.bin": (write_i32_bin, bias_q),
        "q312_expand_output_chw_int16.bin": (write_i16_bin, output_q),
        "expand_float_golden_chw_f32.bin": (write_f32_bin, output_f32),
    }
    for name, (writer, values) in binary_outputs.items():
        writer(output_dir / name, values)

    ifm_words = input_words(input_q)
    packed_weight_words = weight_words(weight_q)
    oc_row_weight_words = weight_oc_row_words(weight_q)
    packed_bias_words = chunk_bias_words(bias_q)
    packed_output_words = chunk_output_words(output_q)
    coe_outputs = {
        "q312_ifm_1024.coe": (ifm_words, 1024),
        "q312_weight_1024.coe": (packed_weight_words, 1024),
        "q312_weight_oc_rows_1024.coe": (oc_row_weight_words, 1024),
        "q312_bias_32.coe": ([pack_unsigned(value, 32) for value in bias_q], 32),
        "q312_bias_chunks_2048.coe": (packed_bias_words, 2048),
        "q312_golden_output_16.coe": ([pack_unsigned(value, 16) for value in output_q], 16),
        "q312_golden_output_chunks_1024.coe": (packed_output_words, 1024),
    }
    for name, (words, width_bits) in coe_outputs.items():
        path = output_dir / name
        write_coe(path, words, width_bits)
        validate_coe(path, len(words), width_bits)

    packed_binary_outputs = {
        "q312_ifm_1024.bin": (ifm_words, 1024),
        "q312_weight_1024.bin": (packed_weight_words, 1024),
        "q312_weight_oc_rows_1024.bin": (oc_row_weight_words, 1024),
        "q312_bias_chunks_2048.bin": (packed_bias_words, 2048),
        "q312_golden_output_chunks_1024.bin": (packed_output_words, 1024),
    }
    for name, (words, width_bits) in packed_binary_outputs.items():
        path = output_dir / name
        write_wide_bin(path, words, width_bits)
        validate_wide_bin(path, words, width_bits)

    file_names = list(binary_outputs) + list(coe_outputs) + list(packed_binary_outputs)
    manifest: dict[str, object] = {
        "format_version": 1,
        "scope": "MobileNetV2 features[8] expand 1x1 convolution + folded BN + ReLU6",
        "source": {
            "input": source_label(input_path, header_path.parent),
            "input_sha256": sha256(input_path),
            "parameters_header": source_label(header_path, header_path.parent),
            "parameters_header_sha256": sha256(header_path),
        },
        "shapes": {
            "input_chw": [CIN, HEIGHT, WIDTH],
            "weight_oc_ic": [COUT, CIN],
            "bias": [COUT],
            "output_chw": [COUT, HEIGHT, WIDTH],
        },
        "fixed_point": {
            "input": "signed Q3.12 int16",
            "weight": "signed Q3.12 int16 (BN-folded)",
            "product": "signed int32, 24 fractional bits",
            "bias": "signed int32, 24 fractional bits",
            "accumulator": "signed int32, 24 fractional bits",
            "output": "signed Q3.12 int16",
            "relu6_upper_raw": RELU6_Q,
            "relu6_upper_hex": "6000",
            "rounding": "nearest, ties away from zero for quantization; positive half-up for output shift",
        },
        "packing": {
            "lanes": CIN,
            "chunks": COUT // CIN,
            "lane_rule": "lane j = word[16*j +: 16]; lane 0 is LSB",
            "packed_bin_byte_order": "little-endian bytes per word; lane 0 is stored first",
            "ifm_word_address": "h*14+w; lanes are input channels 0..63",
            "weight_word_address": "chunk*64+ic; lanes are output channels chunk*64..chunk*64+63",
            "weight_oc_rows_alternative": "address=oc; lanes are input channels 0..63",
            "bias_chunk_word_address": "chunk; 64 signed int32 lanes, lane 0 is LSB",
            "output_chunk_word_address": "chunk*196+h*14+w; lanes are output channels in the chunk",
        },
        "diagnostics": {
            "input_saturation_count": input_saturation,
            "weight_saturation_count": weight_saturation,
            "bias_saturation_count": bias_saturation,
            "accumulator_raw_min": acc_min,
            "accumulator_raw_max": acc_max,
            "output_raw_min": min(output_q),
            "output_raw_max": max(output_q),
            **metrics(output_q, output_f32),
        },
        "files": {
            name: {"bytes": (output_dir / name).stat().st_size, "sha256": sha256(output_dir / name)}
            for name in file_names
        },
    }
    (output_dir / "q312_manifest.json").write_text(
        json.dumps(manifest, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
    )
    return manifest


def main() -> None:
    script_dir = Path(__file__).resolve().parent
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--input",
        type=Path,
        default=script_dir.parent / "MobileNet_v2" / "mobilenetv2_result_layer07.bin",
    )
    parser.add_argument(
        "--header", type=Path, default=script_dir.parent / "mobilenetv2_parameters.h"
    )
    parser.add_argument("--out-dir", type=Path, default=script_dir / "q312_hw")
    args = parser.parse_args()

    manifest = generate(args.input, args.header, args.out_dir)
    diagnostics = manifest["diagnostics"]
    print(f"Generated Q3.12 files in {args.out_dir.resolve()}")
    print(
        "acc=[{accumulator_raw_min}, {accumulator_raw_max}], "
        "max_abs_error={max_abs_error:.9g}, RMSE={rmse:.9g}".format(**diagnostics)
    )


if __name__ == "__main__":
    main()
