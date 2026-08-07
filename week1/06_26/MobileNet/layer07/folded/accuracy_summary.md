# Layer 07 BN Folding 정확도 요약

**한줄 결론:** Folding 자체 최대 오차는 `1.251698e-06`이고, Golden 대비 최대 오차는 `2.787709e-04` → `2.785921e-04`입니다.

| 비교 | Max abs error | Mean abs error | RMSE | Cosine similarity | 판정 |
|---|---:|---:|---:|---:|:---:|
| Folded vs Original | 1.251698e-06 | 1.762712e-07 | 2.333248e-07 | 1.0000000000 | PASS |
| Original vs Golden | 2.787709e-04 | 2.126220e-05 | 2.972580e-05 | 0.9999999978 | PASS |
| Folded vs Golden | 2.785921e-04 | 2.125916e-05 | 2.972479e-05 | 0.9999999978 | PASS |

- `Folded vs Original`: folding 자체가 만든 수치 차이
- `Original/Folded vs Golden`: 6자리 C 헤더 파라미터와 저장된 기준 출력의 차이
- 이 표는 Layer 07 출력 텐서의 수치 오차이며 ImageNet Top-1 분류 정확도가 아닙니다.
