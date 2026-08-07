# Layer 07 PyTorch INT8 정확도 요약

**한줄 결론:** Weight-only qint8의 float 대비 최대 오차 `2.183080e-02`, Golden 최대 오차 증가 `+2.144250e-02`; PyTorch PTQ INT8의 float 대비 최대 오차 `9.452078e-02`, Golden 최대 오차 증가 `+9.421551e-02`.

- 실행 경로: PyTorch `QuantizedConv2d` + oneDNN backend
- Weight: signed qint8 per-output-channel symmetric (`-127..127`)
- Activation: quint8 storage, x86-safe observer range (`0..127`)
- Calibration/Evaluation: 동일한 `layer06.bin` 한 샘플

## 전체 출력

| 비교 | Max abs error | Mean abs error | RMSE | Cosine similarity |
|---|---:|---:|---:|---:|
| Float folded vs Golden | 2.785921e-04 | 2.125916e-05 | 2.972479e-05 | 0.9999999978 |
| Weight-only qint8 vs Float folded | 2.183080e-02 | 4.247877e-03 | 5.364234e-03 | 0.9999291045 |
| Weight-only qint8 vs Golden | 2.172109e-02 | 4.247597e-03 | 5.363300e-03 | 0.9999291301 |
| PyTorch PTQ INT8 vs Float folded | 9.452078e-02 | 1.695102e-02 | 2.121780e-02 | 0.9988919043 |
| PyTorch PTQ INT8 vs Golden | 9.449410e-02 | 1.695097e-02 | 2.121759e-02 | 0.9988919282 |

## 단계별 Float 대비 오차

| 방식 | 단계 | Max abs error | Mean abs error | RMSE | Cosine similarity |
|---|---|---:|---:|---:|---:|
| Weight-only qint8 | expand | 7.482335e-03 | 4.103074e-04 | 7.143100e-04 | 0.9999914421 |
| Weight-only qint8 | depthwise | 1.179361e-02 | 8.891045e-04 | 1.398931e-03 | 0.9999918467 |
| Weight-only qint8 | project | 2.183080e-02 | 4.247877e-03 | 5.364234e-03 | 0.9999291045 |
| PyTorch PTQ INT8 | expand | 2.563806e-02 | 3.830800e-03 | 5.792680e-03 | 0.9994378285 |
| PyTorch PTQ INT8 | depthwise | 7.100897e-02 | 7.232054e-03 | 9.833496e-03 | 0.9995968081 |
| PyTorch PTQ INT8 | project | 9.452078e-02 | 1.695102e-02 | 2.121780e-02 | 0.9988919043 |

> 이 결과는 한 샘플의 Layer 07 출력 텐서 오차입니다. ImageNet Top-1 정확도를 의미하지 않습니다.
