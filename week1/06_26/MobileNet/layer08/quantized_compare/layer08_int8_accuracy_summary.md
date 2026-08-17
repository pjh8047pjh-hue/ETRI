# Layer 08 INT8 fixed-point accuracy

**Recommendation:** calibrated INT8. Selection uses lower final RMSE, with cosine similarity reported alongside it.

This is a single-sample Layer 08 numeric comparison, not ImageNet Top-1 accuracy.

## Accuracy

| Comparison | Max abs | Mean abs | RMSE | Cosine | Worst channel/pixel |
|---|---:|---:|---:|---:|---:|
| Float BN vs float folded | 1.31130219e-06 | 1.55486472e-07 | 2.09331826e-07 | 1.0000000000 | 51/135 |
| Float folded vs layer08 golden | 0.00095897913 | 0.00011047009 | 0.000150765063 | 0.9999999643 | 12/98 |
| Q3.4 expand vs folded | 0.597123235 | 0.0918268064 | 0.122336766 | 0.9127801580 | 341/32 |
| Q3.4 depthwise vs folded | 2.05606386 | 0.0774712319 | 0.152101297 | 0.6558647169 | 341/46 |
| Q3.4 project vs folded | 4.43972522 | 1.0676042 | 1.20856643 | 0.2695463863 | 31/142 |
| Q3.4 final vs folded | 4.4754957 | 1.09811055 | 1.23646267 | 0.4473290645 | 31/142 |
| Q3.4 final vs layer08 golden | 4.4755578 | 1.09812756 | 1.23647326 | 0.4473123607 | 31/142 |
| Calibrated expand vs folded | 0.00900044525 | 0.0013071757 | 0.00177117853 | 0.9999321186 | 316/19 |
| Calibrated depthwise vs folded | 0.0277572954 | 0.00193016517 | 0.00357093109 | 0.9996447947 | 167/77 |
| Calibrated project vs folded | 0.0386827569 | 0.00780461517 | 0.00985325544 | 0.9995483252 | 56/141 |
| Calibrated final vs folded | 0.0620053634 | 0.0100387539 | 0.0125657788 | 0.9997518983 | 56/141 |
| Calibrated final vs layer08 golden | 0.0616280288 | 0.0100364635 | 0.0125632146 | 0.9997520000 | 56/141 |

## Integer diagnostics

| Mode/stage | Acc min | Acc max | Saturations | INT32 overflows |
|---|---:|---:|---:|---:|
| Q3.4 expand | -183 | 245 | 8958 | 0 |
| Q3.4 depthwise | -734 | 577 | 42968 | 0 |
| Q3.4 project | -1496 | 531 | 0 | 0 |
| Q3.4 final | -87 | 34 | 0 | 0 |
| Calibrated expand | -71664 | 115012 | 15560 | 0 |
| Calibrated depthwise | -58302 | 19969 | 37261 | 0 |
| Calibrated project | -55418 | 51298 | 0 | 0 |
| Calibrated final | -121 | 127 | 0 | 0 |
