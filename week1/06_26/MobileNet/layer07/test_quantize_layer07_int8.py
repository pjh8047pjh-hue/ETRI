from __future__ import annotations

import unittest

import torch

import fold_layer07_bn as folding
import quantize_layer07_int8 as quantization


class Layer07PytorchPTQTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        torch.set_grad_enabled(False)
        cls.folded = quantization.load_folded_checkpoint(quantization.FOLDED_PT)
        cls.input_tensor = folding.load_f32_bin(
            folding.INPUT_BIN, folding.INPUT_SHAPE
        )
        cls.float_output, cls.float_stages = folding.run_folded(
            cls.input_tensor, cls.folded
        )
        cls.model = quantization.build_pytorch_ptq_model(
            cls.folded, cls.input_tensor
        )

    def test_float_module_matches_folded_reference(self) -> None:
        model = quantization.Layer07PTQ(self.folded).eval()
        actual = model(self.input_tensor)
        torch.testing.assert_close(
            actual, self.float_output, rtol=0.0, atol=0.0
        )

    def test_real_quantized_modules_are_used(self) -> None:
        self.assertIsInstance(
            self.model.expand, torch.ao.nn.quantized.Conv2d
        )
        self.assertIsInstance(
            self.model.depthwise, torch.ao.nn.quantized.Conv2d
        )
        self.assertIsInstance(
            self.model.project, torch.ao.nn.quantized.Conv2d
        )
        self.assertIsInstance(
            self.model.expand_relu6, torch.ao.nn.quantized.ReLU6
        )
        self.assertIsInstance(
            self.model.depthwise_relu6, torch.ao.nn.quantized.ReLU6
        )

    def test_qint8_weights_and_quint8_activations(self) -> None:
        for module in quantization.quantized_conv_modules(self.model).values():
            weight = module.weight()
            self.assertEqual(weight.dtype, torch.qint8)
            self.assertEqual(weight.qscheme(), torch.per_channel_affine)
            self.assertTrue(torch.all(weight.q_per_channel_zero_points() == 0))

        _, _, quantized_stages = quantization.run_pytorch_ptq(
            self.model, self.input_tensor
        )
        for tensor in quantized_stages.values():
            self.assertEqual(tensor.dtype, torch.quint8)
            integers = tensor.int_repr()
            self.assertGreaterEqual(
                int(integers.min().item()), torch.iinfo(torch.uint8).min
            )
            self.assertLessEqual(
                int(integers.max().item()), torch.iinfo(torch.uint8).max
            )

    def test_backend_matches_independent_int32_reference(self) -> None:
        quantized_input = self.model.quant(self.input_tensor)
        for name, relu in (
            ("expand", self.model.expand_relu6),
            ("depthwise", self.model.depthwise_relu6),
            ("project", None),
        ):
            module = quantization.quantized_conv_modules(self.model)[name]
            backend_output = module(quantized_input)
            reference_int = quantization.simulate_quantized_conv_int_repr(
                quantized_input, module
            )
            difference = (
                backend_output.int_repr().to(torch.int16)
                - reference_int.to(torch.int16)
            ).abs()
            self.assertLessEqual(int(difference.max().item()), 1)
            quantized_input = (
                relu(backend_output) if relu is not None else backend_output
            )

    def test_exported_bias_and_accumulator_bounds(self) -> None:
        weights, scales, zero_points, biases, diagnostics = (
            quantization.extract_integer_parameters(self.model)
        )
        for name in ("expand", "depthwise", "project"):
            self.assertEqual(weights[name].dtype, torch.int8)
            self.assertEqual(scales[name].dtype, torch.float64)
            self.assertTrue(torch.all(zero_points[name] == 0))
            self.assertEqual(biases[name].dtype, torch.int32)
            self.assertLessEqual(
                diagnostics[name]["accumulator_bound"],
                quantization.INT32_MAX,
            )

    def test_ptq_and_weight_only_outputs_are_deterministic(self) -> None:
        first, _, _ = quantization.run_pytorch_ptq(
            self.model, self.input_tensor
        )
        second, _, _ = quantization.run_pytorch_ptq(
            self.model, self.input_tensor
        )
        torch.testing.assert_close(first, second, rtol=0.0, atol=0.0)

        first_weight, _ = quantization.run_weight_only(
            self.input_tensor, self.folded, self.model
        )
        second_weight, _ = quantization.run_weight_only(
            self.input_tensor, self.folded, self.model
        )
        torch.testing.assert_close(
            first_weight, second_weight, rtol=0.0, atol=0.0
        )


if __name__ == "__main__":
    unittest.main()
