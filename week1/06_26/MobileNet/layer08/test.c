#include <stdio.h>
#include <math.h>

#define CIN 10
#define COUT 5
#define H 3
#define W 3

int main(void) {
    float input[CIN][H][W];
    float weight[COUT][CIN];
    float output[COUT][H][W];
    float golden[COUT][H][W];
    int err = 0;

    int v = 1;
    for (int ic = 0; ic < CIN; ic++) {
        for (int h = 0; h < H; h++) {
            for (int w = 0; w < W; w++) {
                input[ic][h][w] = (float)v++;
            }
        }
    }

    v = 1;
    for (int oc = 0; oc < COUT; oc++) {
        for (int ic = 0; ic < CIN; ic++) {
            weight[oc][ic] = (float)v++;
        }
    }

    for (int oc = 0; oc < COUT; oc++) {
        for (int h = 0; h < H; h++) {
            for (int w = 0; w < W; w++) {
                float sum = 0.0f;

                for (int ic = 0; ic < CIN; ic++) {
                    sum += input[ic][h][w] * weight[oc][ic];
                }

                output[oc][h][w] = sum;
            }
        }
    }

    for (int oc = 0; oc < COUT; oc++) {
        for (int h = 0; h < H; h++) {
            for (int w = 0; w < W; w++) {
                golden[oc][h][w] =
                    input[0][h][w] * weight[oc][0] +
                    input[1][h][w] * weight[oc][1] +
                    input[2][h][w] * weight[oc][2] +
                    input[3][h][w] * weight[oc][3] +
                    input[4][h][w] * weight[oc][4] +
                    input[5][h][w] * weight[oc][5] +
                    input[6][h][w] * weight[oc][6] +
                    input[7][h][w] * weight[oc][7] +
                    input[8][h][w] * weight[oc][8] +
                    input[9][h][w] * weight[oc][9];
            }
        }
    }

    printf("calculation for output[0][0][0]\n");
    for (int ic = 0; ic < CIN; ic++) {
        float mul = input[ic][0][0] * weight[0][ic];
        printf("input[%d][0][0](%.0f) * weight[0][%d](%.0f) = %.0f\n",
               ic, input[ic][0][0], ic, weight[0][ic], mul);
    }
    printf("output[0][0][0] = %.0f\n", output[0][0][0]);
    printf("golden[0][0][0] = %.0f\n", golden[0][0][0]);

    printf("\ncompare all outputs\n");
    for (int oc = 0; oc < COUT; oc++) {
        printf("\noutput channel %d\n", oc);
        for (int h = 0; h < H; h++) {
            for (int w = 0; w < W; w++) {
                float diff = fabsf(output[oc][h][w] - golden[oc][h][w]);

                printf("oc=%d h=%d w=%d | output=%8.0f golden=%8.0f diff=%f\n",
                       oc, h, w, output[oc][h][w], golden[oc][h][w], diff);

                if (diff > 1e-5f) {
                    err++;
                }
            }
        }
    }

    if (err == 0) {
        printf("\nPASS\n");
    } else {
        printf("\nFAIL err=%d\n", err);
    }

    return 0;
}
