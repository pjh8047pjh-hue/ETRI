#!/usr/bin/env python3
"""Fold all three Conv-BN pairs in MobileNetV2 features_7 with PyTorch.

The source parameters are parsed from mobilenetv2_parameters.h.  Generated
weights and biases remain float32; fixed-point quantization is intentionally
left to the downstream hardware export flow.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import re
import struct
from pathlib import Path
from typing import Any

import torch
import torch.nn.functional as F
from torch.nn.utils.fusion import fuse_conv_bn_weights


SCRIPT_DIR = Path(__file__).resolve().parent
MOBILENET_DIR = SCRIPT_DIR.parent
PARAMS_H = MOBILENET_DIR / "mobilenetv2_parameters.h"
INPUT_BIN = MOBILENET_DIR / "MobileNet_v2/mobilenetv2_result_layer06.bin"
GOLDEN_BIN = MOBILENET_DIR / "MobileNet_v2/mobilenetv2_result_layer07.bin"
OUT_DIR = SCRIPT_DIR / "folded"

EPS = 1.0e-5
INPUT_SHAPE = (1, 32, 28, 28)
OUTPUT_SHAPE = (1, 64, 14, 14)

ARRAY_COUNTS = {
    "features_7_conv_0_0_weight": 192 * 32,
    "features_7_conv_0_1_weight": 192,
    "features_7_conv_0_1_bias": 192,
    "features_7_conv_0_1_running_mean": 192,
    "features_7_conv_0_1_running_var": 192,
    "features_7_conv_1_0_weight": 192 * 3 * 3,
    "features_7_conv_1_1_weight": 192,
    "features_7_conv_1_1_bias": 192,
    "features_7_conv_1_1_running_mean": 192,
    "features_7_conv_1_1_running_var": 192,
    "features_7_conv_2_weight": 64 * 192,
    "features_7_conv_3_weight": 64,
    "features_7_conv_3_bias": 64,
    "features_7_conv_3_running_mean": 64,
    "features_7_conv_3_running_var": 64,
}

NUMBER_RE = re.compile(
    r"[-+]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][-+]?\d+)?"
)


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def parse_c_float_arrays(path: Path) -> dict[str, torch.Tensor]:
    text = path.read_text(encoding="utf-8")
    arrays: dict[str, torch.Tensor] = {}

    for name, expected_count in ARRAY_COUNTS.items():
        pattern = re.compile(
            rf"const\s+float\s+{re.escape(name)}\s*\[(\d+)\]\s*=\s*"
            rf"\{{(.*?)\}}\s*;",
            re.DOTALL,
        )
        match = pattern.search(text)
        if match is None:
            raise ValueError(f"missing array {name} in {path}")

        declared_count = int(match.group(1))
        values = [float(token) for token in NUMBER_RE.findall(match.group(2))]
        if declared_count != expected_count or len(values) != expected_count:
            raise ValueError(
                f"{name}: expected {expected_count}, declaration says "
                f"{declared_count}, parsed {len(values)}"
            )

        tensor = torch.tensor(values, dtype=torch.float32)
        if not torch.isfinite(tensor).all():
            raise ValueError(f"{name}: NaN or Inf found")
        arrays[name] = tensor

    for name in (
        "features_7_conv_0_1_running_var",
        "features_7_conv_1_1_running_var",
        "features_7_conv_3_running_var",
    ):
        if torch.any(arrays[name] + EPS <= 0):
            raise ValueError(f"{name}: running_var + eps must be positive")

    return arrays


def reshape_parameters(flat: dict[str, torch.Tensor]) -> dict[str, torch.Tensor]:
    params = dict(flat)
    params["features_7_conv_0_0_weight"] = flat[
        "features_7_conv_0_0_weight"
    ].reshape(192, 32, 1, 1)
    params["features_7_conv_1_0_weight"] = flat[
        "features_7_conv_1_0_weight"
    ].reshape(192, 1, 3, 3)
    params["features_7_conv_2_weight"] = flat[
        "features_7_conv_2_weight"
    ].reshape(64, 192, 1, 1)
    return params


def fold_pair(
    conv_weight: torch.Tensor,
    bn_mean: torch.Tensor,
    bn_var: torch.Tensor,
    bn_weight: torch.Tensor,
    bn_bias: torch.Tensor,
) -> tuple[torch.Tensor, torch.Tensor]:
    folded_weight, folded_bias = fuse_conv_bn_weights(
        conv_weight,
        None,
        bn_mean,
        bn_var,
        EPS,
        bn_weight,
        bn_bias,
    )
    return folded_weight.detach().contiguous(), folded_bias.detach().contiguous()


def fold_layer07(params: dict[str, torch.Tensor]) -> dict[str, torch.Tensor]:
    expand_w, expand_b = fold_pair(
        params["features_7_conv_0_0_weight"],
        params["features_7_conv_0_1_running_mean"],
        params["features_7_conv_0_1_running_var"],
        params["features_7_conv_0_1_weight"],
        params["features_7_conv_0_1_bias"],
    )
    depthwise_w, depthwise_b = fold_pair(
        params["features_7_conv_1_0_weight"],
        params["features_7_conv_1_1_running_mean"],
        params["features_7_conv_1_1_running_var"],
        params["features_7_conv_1_1_weight"],
        params["features_7_conv_1_1_bias"],
    )
    project_w, project_b = fold_pair(
        params["features_7_conv_2_weight"],
        params["features_7_conv_3_running_mean"],
        params["features_7_conv_3_running_var"],
        params["features_7_conv_3_weight"],
        params["features_7_conv_3_bias"],
    )
    return {
        "features_7_conv_0_0_weight_folded": expand_w,
        "features_7_conv_0_0_bias_folded": expand_b,
        "features_7_conv_1_0_weight_folded": depthwise_w,
        "features_7_conv_1_0_bias_folded": depthwise_b,
        "features_7_conv_2_weight_folded": project_w,
        "features_7_conv_2_bias_folded": project_b,
    }


def batch_norm_eval(
    value: torch.Tensor,
    params: dict[str, torch.Tensor],
    prefix: str,
) -> torch.Tensor:
    return F.batch_norm(
        value,
        params[f"{prefix}_running_mean"],
        params[f"{prefix}_running_var"],
        weight=params[f"{prefix}_weight"],
        bias=params[f"{prefix}_bias"],
        training=False,
        momentum=0.0,
        eps=EPS,
    )


def run_reference(
    input_tensor: torch.Tensor,
    params: dict[str, torch.Tensor],
) -> tuple[torch.Tensor, dict[str, torch.Tensor]]:
    expand = F.conv2d(input_tensor, params["features_7_conv_0_0_weight"])
    expand = F.relu6(batch_norm_eval(expand, params, "features_7_conv_0_1"))

    depthwise = F.conv2d(
        expand,
        params["features_7_conv_1_0_weight"],
        stride=2,
        padding=1,
        groups=192,
    )
    depthwise = F.relu6(
        batch_norm_eval(depthwise, params, "features_7_conv_1_1")
    )

    project = F.conv2d(depthwise, params["features_7_conv_2_weight"])
    project = batch_norm_eval(project, params, "features_7_conv_3")
    return project, {
        "expand": expand,
        "depthwise": depthwise,
        "project": project,
    }


def run_folded(
    input_tensor: torch.Tensor,
    folded: dict[str, torch.Tensor],
) -> tuple[torch.Tensor, dict[str, torch.Tensor]]:
    expand = F.relu6(
        F.conv2d(
            input_tensor,
            folded["features_7_conv_0_0_weight_folded"],
            folded["features_7_conv_0_0_bias_folded"],
        )
    )
    depthwise = F.relu6(
        F.conv2d(
            expand,
            folded["features_7_conv_1_0_weight_folded"],
            folded["features_7_conv_1_0_bias_folded"],
            stride=2,
            padding=1,
            groups=192,
        )
    )
    project = F.conv2d(
        depthwise,
        folded["features_7_conv_2_weight_folded"],
        folded["features_7_conv_2_bias_folded"],
    )
    return project, {
        "expand": expand,
        "depthwise": depthwise,
        "project": project,
    }


def load_f32_bin(path: Path, shape: tuple[int, ...]) -> torch.Tensor:
    count = math.prod(shape)
    raw = path.read_bytes()
    expected_bytes = count * 4
    if len(raw) != expected_bytes:
        raise ValueError(
            f"{path}: expected {expected_bytes} bytes ({count} float32), "
            f"found {len(raw)}"
        )
    values = struct.unpack(f"<{count}f", raw)
    tensor = torch.tensor(values, dtype=torch.float32).reshape(shape)
    if not torch.isfinite(tensor).all():
        raise ValueError(f"{path}: NaN or Inf found")
    return tensor


def write_f32_bin(path: Path, tensor: torch.Tensor) -> None:
    values = tensor.detach().cpu().contiguous().reshape(-1).tolist()
    path.write_bytes(struct.pack(f"<{len(values)}f", *values))


def error_stats(
    actual: torch.Tensor,
    expected: torch.Tensor,
    tolerance: float,
) -> dict[str, float | bool]:
    actual64 = actual.detach().to(torch.float64).reshape(-1)
    expected64 = expected.detach().to(torch.float64).reshape(-1)
    delta = actual64 - expected64
    absolute = delta.abs()
    rmse = torch.sqrt(torch.mean(delta.square())).item()
    denominator = torch.linalg.vector_norm(actual64) * torch.linalg.vector_norm(
        expected64
    )
    cosine = (
        torch.dot(actual64, expected64) / denominator
        if denominator.item() != 0.0
        else torch.tensor(float("nan"), dtype=torch.float64)
    )
    maximum = absolute.max().item()
    return {
        "max_abs_error": maximum,
        "mean_abs_error": absolute.mean().item(),
        "rmse": rmse,
        "cosine_similarity": cosine.item(),
        "tolerance": tolerance,
        "pass": maximum <= tolerance,
    }


def export_results(
    output_dir: Path,
    folded: dict[str, torch.Tensor],
    params_path: Path,
    input_path: Path,
    golden_path: Path,
    comparisons: dict[str, dict[str, float | bool]],
) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)

    bin_files: dict[str, str] = {}
    for name, tensor in folded.items():
        filename = f"{name}_f32.bin"
        write_f32_bin(output_dir / filename, tensor)
        bin_files[name] = filename

    checkpoint = {
        "format_version": 1,
        "dtype": "float32",
        "weight_layout": "OIHW",
        "bias_layout": "output-channel",
        "eps": EPS,
        "source_sha256": sha256_file(params_path),
        "tensors": folded,
    }
    checkpoint_path = output_dir / "layer07_folded.pt"
    torch.save(checkpoint, checkpoint_path)

    manifest: dict[str, Any] = {
        "format_version": 1,
        "dtype": "float32",
        "weight_layout": "OIHW",
        "bias_layout": "output-channel",
        "eps": EPS,
        "source": {
            "parameters": str(params_path.resolve()),
            "parameters_sha256": sha256_file(params_path),
            "input": str(input_path.resolve()),
            "input_sha256": sha256_file(input_path),
            "golden": str(golden_path.resolve()),
            "golden_sha256": sha256_file(golden_path),
        },
        "checkpoint": checkpoint_path.name,
        "tensors": {
            name: {
                "shape": list(tensor.shape),
                "elements": tensor.numel(),
                "file": bin_files[name],
                "sha256": sha256_file(output_dir / bin_files[name]),
            }
            for name, tensor in folded.items()
        },
        "comparisons": comparisons,
    }
    (output_dir / "layer07_folded_manifest.json").write_text(
        json.dumps(manifest, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )

    rows = [
        "# Layer 07 BN Folding 정확도 요약",
        "",
        (
            "**한줄 결론:** Folding 자체 최대 오차는 "
            f"`{comparisons['folded_vs_original']['max_abs_error']:.6e}`이고, "
            "Golden 대비 최대 오차는 "
            f"`{comparisons['original_vs_golden']['max_abs_error']:.6e}` → "
            f"`{comparisons['folded_vs_golden']['max_abs_error']:.6e}`입니다."
        ),
        "",
        "| 비교 | Max abs error | Mean abs error | RMSE | Cosine similarity | 판정 |",
        "|---|---:|---:|---:|---:|:---:|",
    ]
    labels = {
        "folded_vs_original": "Folded vs Original",
        "original_vs_golden": "Original vs Golden",
        "folded_vs_golden": "Folded vs Golden",
    }
    for key in labels:
        stats = comparisons[key]
        result = "PASS" if stats["pass"] else "FAIL"
        rows.append(
            f"| {labels[key]} | {stats['max_abs_error']:.6e} | "
            f"{stats['mean_abs_error']:.6e} | {stats['rmse']:.6e} | "
            f"{stats['cosine_similarity']:.10f} | {result} |"
        )
    rows.extend(
        [
            "",
            "- `Folded vs Original`: folding 자체가 만든 수치 차이",
            "- `Original/Folded vs Golden`: 6자리 C 헤더 파라미터와 저장된 기준 출력의 차이",
            "- 이 표는 Layer 07 출력 텐서의 수치 오차이며 ImageNet Top-1 분류 정확도가 아닙니다.",
            "",
        ]
    )
    (output_dir / "accuracy_summary.md").write_text(
        "\n".join(rows), encoding="utf-8"
    )


def print_summary(comparisons: dict[str, dict[str, float | bool]]) -> None:
    labels = {
        "folded_vs_original": "Folded vs Original",
        "original_vs_golden": "Original vs Golden",
        "folded_vs_golden": "Folded vs Golden",
    }
    print("\nLayer 07 BN Folding accuracy")
    print("=" * 103)
    print(
        f"{'comparison':22} {'max abs':>13} {'mean abs':>13} "
        f"{'RMSE':>13} {'cosine':>14} {'result':>8}"
    )
    print("-" * 103)
    for key, label in labels.items():
        stats = comparisons[key]
        result = "PASS" if stats["pass"] else "FAIL"
        print(
            f"{label:22} {stats['max_abs_error']:13.6e} "
            f"{stats['mean_abs_error']:13.6e} {stats['rmse']:13.6e} "
            f"{stats['cosine_similarity']:14.10f} {result:>8}"
        )
    print("=" * 103)
    golden_delta = (
        comparisons["folded_vs_golden"]["max_abs_error"]
        - comparisons["original_vs_golden"]["max_abs_error"]
    )
    print(
        "Folding-added max error: "
        f"{comparisons['folded_vs_original']['max_abs_error']:.6e}"
    )
    print(f"Golden max-error change: {golden_delta:+.6e}")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--params-h", type=Path, default=PARAMS_H)
    parser.add_argument("--input-bin", type=Path, default=INPUT_BIN)
    parser.add_argument("--golden-bin", type=Path, default=GOLDEN_BIN)
    parser.add_argument("--out-dir", type=Path, default=OUT_DIR)
    parser.add_argument("--fold-tol", type=float, default=1.0e-4)
    parser.add_argument("--golden-tol", type=float, default=1.0e-3)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    torch.set_grad_enabled(False)

    params = reshape_parameters(parse_c_float_arrays(args.params_h))
    folded = fold_layer07(params)
    input_tensor = load_f32_bin(args.input_bin, INPUT_SHAPE)
    golden = load_f32_bin(args.golden_bin, OUTPUT_SHAPE)

    original, original_stages = run_reference(input_tensor, params)
    folded_output, folded_stages = run_folded(input_tensor, folded)

    comparisons = {
        "folded_vs_original": error_stats(
            folded_output, original, args.fold_tol
        ),
        "original_vs_golden": error_stats(
            original, golden, args.golden_tol
        ),
        "folded_vs_golden": error_stats(
            folded_output, golden, args.golden_tol
        ),
    }
    for stage in ("expand", "depthwise", "project"):
        comparisons[f"stage_{stage}_folded_vs_original"] = error_stats(
            folded_stages[stage], original_stages[stage], args.fold_tol
        )

    export_results(
        args.out_dir,
        folded,
        args.params_h,
        args.input_bin,
        args.golden_bin,
        comparisons,
    )
    print_summary(comparisons)
    print(f"\nArtifacts: {args.out_dir.resolve()}")

    failed = [name for name, stats in comparisons.items() if not stats["pass"]]
    if failed:
        print("FAILED comparisons: " + ", ".join(failed))
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
