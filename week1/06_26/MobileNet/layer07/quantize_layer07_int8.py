#!/usr/bin/env python3
"""Run official PyTorch static PTQ for folded MobileNetV2 Layer 07.

Primary result:
  * PyTorch PTQ: qint8 per-output-channel weights, x86-safe reduced-range
    quint8 per-tensor affine activations, and oneDNN QuantizedConv2d.

Diagnostic result:
  * Weight-only: the exact PyTorch-quantized weights are dequantized while
    activations and biases remain float32.  This isolates weight error from
    activation/requantization error.
"""

from __future__ import annotations

import argparse
import json
import math
import struct
import warnings
from pathlib import Path
from typing import Any

import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.ao.quantization import (
    DeQuantStub,
    MinMaxObserver,
    PerChannelMinMaxObserver,
    QConfig,
    QuantStub,
    convert,
    prepare,
)

import fold_layer07_bn as folding


SCRIPT_DIR = Path(__file__).resolve().parent
FOLDED_PT = SCRIPT_DIR / "folded/layer07_folded.pt"
OUT_DIR = SCRIPT_DIR / "quantized_int8"

WEIGHT_QMIN = -127
WEIGHT_QMAX = 127
ACTIVATION_QMIN = 0
# oneDNN/x86 needs the reduced uint8 range to avoid saturating SIMD partial
# sums (the same policy used by PyTorch's default x86 qconfig).
ACTIVATION_QMAX = 127
INT32_MIN = -(2**31)
INT32_MAX = 2**31 - 1
BACKEND = "onednn"

WEIGHT_KEYS = {
    "expand": "features_7_conv_0_0_weight_folded",
    "depthwise": "features_7_conv_1_0_weight_folded",
    "project": "features_7_conv_2_weight_folded",
}
BIAS_KEYS = {
    "expand": "features_7_conv_0_0_bias_folded",
    "depthwise": "features_7_conv_1_0_bias_folded",
    "project": "features_7_conv_2_bias_folded",
}
EXPECTED_SHAPES = {
    WEIGHT_KEYS["expand"]: (192, 32, 1, 1),
    BIAS_KEYS["expand"]: (192,),
    WEIGHT_KEYS["depthwise"]: (192, 1, 3, 3),
    BIAS_KEYS["depthwise"]: (192,),
    WEIGHT_KEYS["project"]: (64, 192, 1, 1),
    BIAS_KEYS["project"]: (64,),
}


class Layer07PTQ(nn.Module):
    """Folded Layer 07 with explicit quantize/dequantize boundaries."""

    def __init__(self, folded: dict[str, torch.Tensor]) -> None:
        super().__init__()
        self.quant = QuantStub()
        self.expand = nn.Conv2d(32, 192, kernel_size=1, bias=True)
        self.expand_relu6 = nn.ReLU6()
        self.depthwise = nn.Conv2d(
            192,
            192,
            kernel_size=3,
            stride=2,
            padding=1,
            groups=192,
            bias=True,
        )
        self.depthwise_relu6 = nn.ReLU6()
        self.project = nn.Conv2d(192, 64, kernel_size=1, bias=True)
        self.dequant = DeQuantStub()

        with torch.no_grad():
            self.expand.weight.copy_(folded[WEIGHT_KEYS["expand"]])
            self.expand.bias.copy_(folded[BIAS_KEYS["expand"]])
            self.depthwise.weight.copy_(folded[WEIGHT_KEYS["depthwise"]])
            self.depthwise.bias.copy_(folded[BIAS_KEYS["depthwise"]])
            self.project.weight.copy_(folded[WEIGHT_KEYS["project"]])
            self.project.bias.copy_(folded[BIAS_KEYS["project"]])

    def forward(self, value: torch.Tensor) -> torch.Tensor:
        value = self.quant(value)
        value = self.expand_relu6(self.expand(value))
        value = self.depthwise_relu6(self.depthwise(value))
        value = self.project(value)
        return self.dequant(value)


def load_folded_checkpoint(path: Path) -> dict[str, torch.Tensor]:
    checkpoint = torch.load(path, map_location="cpu", weights_only=True)
    tensors = checkpoint.get("tensors")
    if not isinstance(tensors, dict):
        raise ValueError(f"{path}: checkpoint has no tensor dictionary")

    result: dict[str, torch.Tensor] = {}
    for name, expected_shape in EXPECTED_SHAPES.items():
        tensor = tensors.get(name)
        if not isinstance(tensor, torch.Tensor):
            raise ValueError(f"{path}: missing tensor {name}")
        if tuple(tensor.shape) != expected_shape:
            raise ValueError(
                f"{name}: expected shape {expected_shape}, got {tuple(tensor.shape)}"
            )
        tensor = tensor.detach().to(dtype=torch.float32, device="cpu").contiguous()
        if not torch.isfinite(tensor).all():
            raise ValueError(f"{name}: NaN or Inf found")
        result[name] = tensor
    return result


def x86_safe_qconfig() -> QConfig:
    """Preserve observed min/max while using the x86-safe activation range."""
    return QConfig(
        activation=MinMaxObserver.with_args(
            dtype=torch.quint8,
            qscheme=torch.per_tensor_affine,
            quant_min=ACTIVATION_QMIN,
            quant_max=ACTIVATION_QMAX,
            reduce_range=False,
        ),
        weight=PerChannelMinMaxObserver.with_args(
            dtype=torch.qint8,
            qscheme=torch.per_channel_symmetric,
            ch_axis=0,
            quant_min=WEIGHT_QMIN,
            quant_max=WEIGHT_QMAX,
        ),
    )


def build_pytorch_ptq_model(
    folded: dict[str, torch.Tensor],
    calibration_input: torch.Tensor,
) -> Layer07PTQ:
    if BACKEND not in torch.backends.quantized.supported_engines:
        raise RuntimeError(
            f"required quantized backend {BACKEND!r} is unavailable; "
            f"available={torch.backends.quantized.supported_engines}"
        )
    torch.backends.quantized.engine = BACKEND
    float_model = Layer07PTQ(folded).eval()
    float_model.qconfig = x86_safe_qconfig()

    # torch.ao remains the quantized-module implementation shipped with the
    # pinned PyTorch build.  Suppress only its migration/deprecation notices.
    with warnings.catch_warnings():
        warnings.simplefilter("ignore", DeprecationWarning)
        warnings.filterwarnings(
            "ignore",
            message=r"torch\.quantize_per_tensor.*deprecated.*",
            category=UserWarning,
        )
        prepared = prepare(float_model, inplace=False)
        with torch.no_grad():
            prepared(calibration_input)
        quantized = convert(prepared, inplace=False)

    if not isinstance(quantized.expand, torch.ao.nn.quantized.Conv2d):
        raise TypeError("expand was not converted to quantized Conv2d")
    if not isinstance(quantized.depthwise, torch.ao.nn.quantized.Conv2d):
        raise TypeError("depthwise was not converted to quantized Conv2d")
    if not isinstance(quantized.project, torch.ao.nn.quantized.Conv2d):
        raise TypeError("project was not converted to quantized Conv2d")
    if not isinstance(quantized.expand_relu6, torch.ao.nn.quantized.ReLU6):
        raise TypeError("expand ReLU6 was not converted")
    if not isinstance(quantized.depthwise_relu6, torch.ao.nn.quantized.ReLU6):
        raise TypeError("depthwise ReLU6 was not converted")
    return quantized


def quantized_conv_modules(model: Layer07PTQ) -> dict[str, nn.Module]:
    return {
        "expand": model.expand,
        "depthwise": model.depthwise,
        "project": model.project,
    }


def run_pytorch_ptq(
    model: Layer07PTQ,
    input_tensor: torch.Tensor,
) -> tuple[
    torch.Tensor,
    dict[str, torch.Tensor],
    dict[str, torch.Tensor],
]:
    quantized_input = model.quant(input_tensor)
    expand_q = model.expand_relu6(model.expand(quantized_input))
    depthwise_q = model.depthwise_relu6(model.depthwise(expand_q))
    project_q = model.project(depthwise_q)
    quantized_stages = {
        "input": quantized_input,
        "expand": expand_q,
        "depthwise": depthwise_q,
        "project": project_q,
    }
    float_stages = {
        name: value.dequantize() for name, value in quantized_stages.items()
        if name != "input"
    }
    return project_q.dequantize(), float_stages, quantized_stages


def simulate_quantized_conv_int_repr(
    quantized_input: torch.Tensor,
    module: nn.Module,
) -> torch.Tensor:
    """Independent INT32 reference for one PyTorch quantized Conv2d."""
    if quantized_input.dtype != torch.quint8:
        raise TypeError("quantized convolution input must be quint8")
    quantized_weight = module.weight()
    weight_int = quantized_weight.int_repr().to(torch.int32)
    weight_zero_points = quantized_weight.q_per_channel_zero_points().to(
        torch.int32
    )
    centered_weight = weight_int - weight_zero_points.reshape(
        (-1,) + (1,) * (weight_int.ndim - 1)
    )
    centered_input = (
        quantized_input.int_repr().to(torch.int32)
        - quantized_input.q_zero_point()
    )
    weight_scales = quantized_weight.q_per_channel_scales().to(torch.float64)
    input_scale = quantized_input.q_scale()
    bias_int32 = torch.round(
        module.bias().detach().to(torch.float64)
        / (input_scale * weight_scales)
    ).to(torch.int32)
    accumulator = F.conv2d(
        centered_input,
        centered_weight,
        bias=None,
        stride=module.stride,
        padding=module.padding,
        dilation=module.dilation,
        groups=module.groups,
    )
    accumulator = accumulator + bias_int32.reshape(1, -1, 1, 1)
    multiplier = (
        input_scale * weight_scales / float(module.scale)
    ).reshape(1, -1, 1, 1)
    raw = (
        torch.round(accumulator.to(torch.float64) * multiplier)
        + int(module.zero_point)
    )
    return torch.clamp(raw, 0, 255).to(torch.uint8)


def run_weight_only(
    input_tensor: torch.Tensor,
    folded: dict[str, torch.Tensor],
    model: Layer07PTQ,
) -> tuple[torch.Tensor, dict[str, torch.Tensor]]:
    modules = quantized_conv_modules(model)
    value = input_tensor
    outputs: dict[str, torch.Tensor] = {}
    for name, stride, padding, groups, relu6 in (
        ("expand", 1, 0, 1, True),
        ("depthwise", 2, 1, 192, True),
        ("project", 1, 0, 1, False),
    ):
        quantized_weight = modules[name].weight()
        if quantized_weight.dtype != torch.qint8:
            raise TypeError(f"{name}: expected qint8 weight")
        value = F.conv2d(
            value,
            quantized_weight.dequantize(),
            folded[BIAS_KEYS[name]],
            stride=stride,
            padding=padding,
            groups=groups,
        )
        if relu6:
            value = F.relu6(value)
        outputs[name] = value
    return value, outputs


def activation_qparams(
    model: Layer07PTQ,
) -> dict[str, dict[str, float | int]]:
    modules = quantized_conv_modules(model)
    return {
        "input": {
            "scale": float(model.quant.scale.item()),
            "zero_point": int(model.quant.zero_point.item()),
        },
        **{
            name: {
                "scale": float(module.scale),
                "zero_point": int(module.zero_point),
            }
            for name, module in modules.items()
        },
    }


def extract_integer_parameters(
    model: Layer07PTQ,
) -> tuple[
    dict[str, torch.Tensor],
    dict[str, torch.Tensor],
    dict[str, torch.Tensor],
    dict[str, torch.Tensor],
    dict[str, dict[str, int]],
]:
    modules = quantized_conv_modules(model)
    qparams = activation_qparams(model)
    weights: dict[str, torch.Tensor] = {}
    weight_scales: dict[str, torch.Tensor] = {}
    weight_zero_points: dict[str, torch.Tensor] = {}
    biases: dict[str, torch.Tensor] = {}
    diagnostics: dict[str, dict[str, int]] = {}

    previous_activation = "input"
    for name in ("expand", "depthwise", "project"):
        module = modules[name]
        quantized_weight = module.weight()
        if quantized_weight.qscheme() not in (
            torch.per_channel_affine,
            torch.per_channel_symmetric,
        ):
            raise TypeError(f"{name}: weight is not per-channel quantized")
        weight_int8 = quantized_weight.int_repr().to(torch.int8).contiguous()
        scales = quantized_weight.q_per_channel_scales().to(torch.float64)
        zero_points = quantized_weight.q_per_channel_zero_points().to(torch.int64)
        if torch.any(zero_points != 0):
            raise ValueError(f"{name}: expected symmetric weight zero points")

        input_scale = qparams[previous_activation]["scale"]
        float_bias = module.bias().detach().to(torch.float64)
        bias_raw = torch.round(float_bias / (input_scale * scales))
        if torch.any(bias_raw < INT32_MIN) or torch.any(bias_raw > INT32_MAX):
            raise OverflowError(f"{name}: quantized bias does not fit int32")
        bias_int32 = bias_raw.to(torch.int32).contiguous()

        input_zero_point = int(qparams[previous_activation]["zero_point"])
        centered_input_max = max(
            input_zero_point - ACTIVATION_QMIN,
            ACTIVATION_QMAX - input_zero_point,
        )
        centered_weight_max = int(
            weight_int8.to(torch.int16).abs().max().item()
        )
        terms = math.prod(weight_int8.shape[1:])
        bound = (
            terms * centered_input_max * centered_weight_max
            + int(bias_int32.to(torch.int64).abs().max().item())
        )
        if bound > INT32_MAX:
            raise OverflowError(f"{name}: accumulator bound {bound} exceeds int32")

        weights[name] = weight_int8
        weight_scales[name] = scales.contiguous()
        weight_zero_points[name] = zero_points.contiguous()
        biases[name] = bias_int32
        diagnostics[name] = {
            "accumulator_bound": bound,
            "weight_qmin_count": int((weight_int8 == WEIGHT_QMIN).sum().item()),
            "weight_qmax_count": int((weight_int8 == WEIGHT_QMAX).sum().item()),
        }
        previous_activation = name

    return weights, weight_scales, weight_zero_points, biases, diagnostics


def activation_endpoint_counts(
    quantized_stages: dict[str, torch.Tensor],
) -> dict[str, dict[str, int]]:
    result: dict[str, dict[str, int]] = {}
    for name, tensor in quantized_stages.items():
        if tensor.dtype != torch.quint8:
            raise TypeError(f"{name}: expected quint8 activation, got {tensor.dtype}")
        integers = tensor.int_repr()
        result[name] = {
            "qmin_count": int((integers == ACTIVATION_QMIN).sum().item()),
            "qmax_count": int((integers == ACTIVATION_QMAX).sum().item()),
            "elements": tensor.numel(),
        }
    return result


def numerical_error(
    actual: torch.Tensor,
    expected: torch.Tensor,
) -> dict[str, float]:
    actual64 = actual.detach().to(torch.float64).reshape(-1)
    expected64 = expected.detach().to(torch.float64).reshape(-1)
    difference = actual64 - expected64
    absolute = difference.abs()
    denominator = torch.linalg.vector_norm(actual64) * torch.linalg.vector_norm(
        expected64
    )
    cosine = (
        torch.dot(actual64, expected64) / denominator
        if denominator.item() != 0.0
        else torch.tensor(float("nan"), dtype=torch.float64)
    )
    return {
        "max_abs_error": absolute.max().item(),
        "mean_abs_error": absolute.mean().item(),
        "rmse": torch.sqrt(torch.mean(difference.square())).item(),
        "cosine_similarity": cosine.item(),
    }


def build_comparisons(
    float_output: torch.Tensor,
    float_stages: dict[str, torch.Tensor],
    golden: torch.Tensor,
    mode_outputs: dict[str, torch.Tensor],
    mode_stages: dict[str, dict[str, torch.Tensor]],
) -> dict[str, dict[str, float]]:
    comparisons = {
        "float_folded_vs_golden": numerical_error(float_output, golden)
    }
    for mode, output in mode_outputs.items():
        comparisons[f"{mode}_vs_float_folded"] = numerical_error(
            output, float_output
        )
        comparisons[f"{mode}_vs_golden"] = numerical_error(output, golden)
        for stage in ("expand", "depthwise", "project"):
            comparisons[f"stage_{stage}_{mode}_vs_float"] = numerical_error(
                mode_stages[mode][stage], float_stages[stage]
            )
    return comparisons


def write_int8_bin(path: Path, tensor: torch.Tensor) -> None:
    values = tensor.detach().cpu().contiguous().reshape(-1).tolist()
    path.write_bytes(struct.pack(f"<{len(values)}b", *values))


def write_int32_bin(path: Path, tensor: torch.Tensor) -> None:
    values = tensor.detach().cpu().contiguous().reshape(-1).tolist()
    path.write_bytes(struct.pack(f"<{len(values)}i", *values))


def file_metadata(
    output_dir: Path,
    filename: str,
    tensor: torch.Tensor,
    dtype: str,
) -> dict[str, Any]:
    return {
        "shape": list(tensor.shape),
        "elements": tensor.numel(),
        "dtype": dtype,
        "file": filename,
        "sha256": folding.sha256_file(output_dir / filename),
    }


def report_label(mode: str) -> str:
    return {
        "weight_only": "Weight-only qint8",
        "pytorch_ptq": "PyTorch PTQ INT8",
    }[mode]


def write_accuracy_report(
    output_dir: Path,
    comparisons: dict[str, dict[str, float]],
    modes: list[str],
) -> None:
    baseline = comparisons["float_folded_vs_golden"]
    conclusions: list[str] = []
    for mode in modes:
        versus_float = comparisons[f"{mode}_vs_float_folded"]
        versus_golden = comparisons[f"{mode}_vs_golden"]
        increase = versus_golden["max_abs_error"] - baseline["max_abs_error"]
        conclusions.append(
            f"{report_label(mode)}의 float 대비 최대 오차 "
            f"`{versus_float['max_abs_error']:.6e}`, Golden 최대 오차 증가 "
            f"`{increase:+.6e}`"
        )

    rows = [
        "# Layer 07 PyTorch INT8 정확도 요약",
        "",
        "**한줄 결론:** " + "; ".join(conclusions) + ".",
        "",
        "- 실행 경로: PyTorch `QuantizedConv2d` + oneDNN backend",
        "- Weight: signed qint8 per-output-channel symmetric (`-127..127`)",
        "- Activation: quint8 storage, x86-safe observer range (`0..127`)",
        "- Calibration/Evaluation: 동일한 `layer06.bin` 한 샘플",
        "",
        "## 전체 출력",
        "",
        "| 비교 | Max abs error | Mean abs error | RMSE | Cosine similarity |",
        "|---|---:|---:|---:|---:|",
        (
            "| Float folded vs Golden | "
            f"{baseline['max_abs_error']:.6e} | "
            f"{baseline['mean_abs_error']:.6e} | {baseline['rmse']:.6e} | "
            f"{baseline['cosine_similarity']:.10f} |"
        ),
    ]
    for mode in modes:
        for suffix, reference in (
            ("vs_float_folded", "Float folded"),
            ("vs_golden", "Golden"),
        ):
            stats = comparisons[f"{mode}_{suffix}"]
            rows.append(
                f"| {report_label(mode)} vs {reference} | "
                f"{stats['max_abs_error']:.6e} | {stats['mean_abs_error']:.6e} | "
                f"{stats['rmse']:.6e} | {stats['cosine_similarity']:.10f} |"
            )

    rows.extend(
        [
            "",
            "## 단계별 Float 대비 오차",
            "",
            "| 방식 | 단계 | Max abs error | Mean abs error | RMSE | Cosine similarity |",
            "|---|---|---:|---:|---:|---:|",
        ]
    )
    for mode in modes:
        for stage in ("expand", "depthwise", "project"):
            stats = comparisons[f"stage_{stage}_{mode}_vs_float"]
            rows.append(
                f"| {report_label(mode)} | {stage} | "
                f"{stats['max_abs_error']:.6e} | {stats['mean_abs_error']:.6e} | "
                f"{stats['rmse']:.6e} | {stats['cosine_similarity']:.10f} |"
            )

    rows.extend(
        [
            "",
            "> 이 결과는 한 샘플의 Layer 07 출력 텐서 오차입니다. "
            "ImageNet Top-1 정확도를 의미하지 않습니다.",
            "",
        ]
    )
    (output_dir / "int8_accuracy_summary.md").write_text(
        "\n".join(rows), encoding="utf-8"
    )


def export_results(
    output_dir: Path,
    folded_path: Path,
    input_path: Path,
    golden_path: Path,
    model: Layer07PTQ,
    modes: list[str],
    quantized_stages: dict[str, torch.Tensor],
    comparisons: dict[str, dict[str, float]],
) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    (
        weights,
        weight_scales,
        weight_zero_points,
        biases,
        integer_diagnostics,
    ) = extract_integer_parameters(model)
    qparams = activation_qparams(model)
    tensors: dict[str, Any] = {}

    for name in ("expand", "depthwise", "project"):
        weight_filename = (
            WEIGHT_KEYS[name].removesuffix("_folded") + "_int8.bin"
        )
        write_int8_bin(output_dir / weight_filename, weights[name])
        tensors[f"{name}_weight"] = file_metadata(
            output_dir, weight_filename, weights[name], "qint8 int_repr"
        )

        bias_filename = BIAS_KEYS[name].removesuffix("_folded") + "_int32.bin"
        write_int32_bin(output_dir / bias_filename, biases[name])
        tensors[f"{name}_bias"] = file_metadata(
            output_dir, bias_filename, biases[name], "int32"
        )

    checkpoint = {
        "format_version": 2,
        "backend": BACKEND,
        "modes": modes,
        "weight_dtype": "torch.qint8",
        "activation_dtype": "torch.quint8",
        "weights_int8": weights,
        "weight_scales_float64": weight_scales,
        "weight_zero_points_int64": weight_zero_points,
        "biases_int32": biases,
        "activation_qparams": qparams,
    }
    checkpoint_path = output_dir / "layer07_int8.pt"
    torch.save(checkpoint, checkpoint_path)

    manifest = {
        "format_version": 2,
        "implementation": "PyTorch static PTQ quantized modules",
        "torch_version": torch.__version__,
        "backend": BACKEND,
        "weight": {
            "dtype": "qint8",
            "qscheme": "per-output-channel symmetric",
            "range": [WEIGHT_QMIN, WEIGHT_QMAX],
        },
        "activation": {
            "dtype": "quint8",
            "qscheme": "per-tensor affine",
            "storage_range": [0, 255],
            "observer_quant_range": [ACTIVATION_QMIN, ACTIVATION_QMAX],
            "reason": "x86/oneDNN SIMD partial-sum saturation avoidance",
        },
        "calibration": "single mobilenetv2_result_layer06.bin sample",
        "modes": modes,
        "source": {
            "folded_checkpoint": str(folded_path.resolve()),
            "folded_checkpoint_sha256": folding.sha256_file(folded_path),
            "input": str(input_path.resolve()),
            "input_sha256": folding.sha256_file(input_path),
            "golden": str(golden_path.resolve()),
            "golden_sha256": folding.sha256_file(golden_path),
        },
        "checkpoint": checkpoint_path.name,
        "checkpoint_sha256": folding.sha256_file(checkpoint_path),
        "tensors": tensors,
        "weight_scales": {
            name: value.tolist() for name, value in weight_scales.items()
        },
        "weight_zero_points": {
            name: value.tolist() for name, value in weight_zero_points.items()
        },
        "activation_qparams": qparams,
        "endpoint_counts": {
            "weights_and_accumulator_bounds": integer_diagnostics,
            "activations": activation_endpoint_counts(quantized_stages),
        },
        "comparisons": comparisons,
    }
    (output_dir / "layer07_int8_manifest.json").write_text(
        json.dumps(manifest, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    write_accuracy_report(output_dir, comparisons, modes)


def print_summary(
    comparisons: dict[str, dict[str, float]], modes: list[str]
) -> None:
    baseline = comparisons["float_folded_vs_golden"]
    print("\nLayer 07 PyTorch INT8 accuracy")
    print("=" * 103)
    print(
        f"{'comparison':31} {'max abs':>13} {'mean abs':>13} "
        f"{'RMSE':>13} {'cosine':>14}"
    )
    print("-" * 103)
    print(
        f"{'Float folded vs Golden':31} {baseline['max_abs_error']:13.6e} "
        f"{baseline['mean_abs_error']:13.6e} {baseline['rmse']:13.6e} "
        f"{baseline['cosine_similarity']:14.10f}"
    )
    for mode in modes:
        for suffix, reference in (
            ("vs_float_folded", "Float"),
            ("vs_golden", "Golden"),
        ):
            stats = comparisons[f"{mode}_{suffix}"]
            label = f"{report_label(mode)} vs {reference}"
            print(
                f"{label:31} {stats['max_abs_error']:13.6e} "
                f"{stats['mean_abs_error']:13.6e} {stats['rmse']:13.6e} "
                f"{stats['cosine_similarity']:14.10f}"
            )
    print("=" * 103)
    for mode in modes:
        increase = (
            comparisons[f"{mode}_vs_golden"]["max_abs_error"]
            - baseline["max_abs_error"]
        )
        print(f"{report_label(mode)} Golden max-error increase: {increase:+.6e}")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--folded-pt", type=Path, default=FOLDED_PT)
    parser.add_argument("--input-bin", type=Path, default=folding.INPUT_BIN)
    parser.add_argument("--golden-bin", type=Path, default=folding.GOLDEN_BIN)
    parser.add_argument("--out-dir", type=Path, default=OUT_DIR)
    parser.add_argument(
        "--mode",
        choices=("both", "weight-only", "pytorch-ptq", "full-int8"),
        default="both",
        help="full-int8 is an alias for pytorch-ptq",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    torch.set_grad_enabled(False)
    folded = load_folded_checkpoint(args.folded_pt)
    input_tensor = folding.load_f32_bin(args.input_bin, folding.INPUT_SHAPE)
    golden = folding.load_f32_bin(args.golden_bin, folding.OUTPUT_SHAPE)
    float_output, float_stages = folding.run_folded(input_tensor, folded)
    model = build_pytorch_ptq_model(folded, input_tensor)

    modes = (
        ["weight_only", "pytorch_ptq"]
        if args.mode == "both"
        else [
            "weight_only"
            if args.mode == "weight-only"
            else "pytorch_ptq"
        ]
    )
    mode_outputs: dict[str, torch.Tensor] = {}
    mode_stages: dict[str, dict[str, torch.Tensor]] = {}

    ptq_output, ptq_stages, quantized_stages = run_pytorch_ptq(
        model, input_tensor
    )
    if "pytorch_ptq" in modes:
        mode_outputs["pytorch_ptq"] = ptq_output
        mode_stages["pytorch_ptq"] = ptq_stages
    if "weight_only" in modes:
        output, stages = run_weight_only(input_tensor, folded, model)
        mode_outputs["weight_only"] = output
        mode_stages["weight_only"] = stages

    comparisons = build_comparisons(
        float_output,
        float_stages,
        golden,
        mode_outputs,
        mode_stages,
    )
    export_results(
        args.out_dir,
        args.folded_pt,
        args.input_bin,
        args.golden_bin,
        model,
        modes,
        quantized_stages,
        comparisons,
    )
    print_summary(comparisons, modes)
    print(f"\nArtifacts: {args.out_dir.resolve()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
