from __future__ import annotations

import unittest

import torch

import fold_layer07_bn as folding


class Layer07BatchNormFoldingTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        torch.set_grad_enabled(False)
        cls.params = folding.reshape_parameters(
            folding.parse_c_float_arrays(folding.PARAMS_H)
        )
        cls.folded = folding.fold_layer07(cls.params)

    def test_parameter_shapes(self) -> None:
        expected = {
            "features_7_conv_0_0_weight_folded": (192, 32, 1, 1),
            "features_7_conv_0_0_bias_folded": (192,),
            "features_7_conv_1_0_weight_folded": (192, 1, 3, 3),
            "features_7_conv_1_0_bias_folded": (192,),
            "features_7_conv_2_weight_folded": (64, 192, 1, 1),
            "features_7_conv_2_bias_folded": (64,),
        }
        self.assertEqual(
            {name: tuple(tensor.shape) for name, tensor in self.folded.items()},
            expected,
        )

    def test_manual_formula_matches_pytorch_fuser(self) -> None:
        weight = self.params["features_7_conv_0_0_weight"]
        gamma = self.params["features_7_conv_0_1_weight"]
        beta = self.params["features_7_conv_0_1_bias"]
        mean = self.params["features_7_conv_0_1_running_mean"]
        variance = self.params["features_7_conv_0_1_running_var"]
        scale = gamma * torch.rsqrt(variance + folding.EPS)
        expected_weight = weight * scale.reshape(-1, 1, 1, 1)
        expected_bias = beta - mean * scale
        torch.testing.assert_close(
            self.folded["features_7_conv_0_0_weight_folded"],
            expected_weight,
            rtol=0.0,
            atol=0.0,
        )
        torch.testing.assert_close(
            self.folded["features_7_conv_0_0_bias_folded"],
            expected_bias,
            rtol=0.0,
            atol=0.0,
        )

    def test_real_input_folded_matches_original(self) -> None:
        input_tensor = folding.load_f32_bin(folding.INPUT_BIN, folding.INPUT_SHAPE)
        original, _ = folding.run_reference(input_tensor, self.params)
        fused, _ = folding.run_folded(input_tensor, self.folded)
        stats = folding.error_stats(fused, original, 1.0e-4)
        self.assertTrue(stats["pass"], stats)


if __name__ == "__main__":
    unittest.main()
