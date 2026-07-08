#include <stdio.h>

#define CIN 10
#define COUT 5
#define H 3
#define W 3

int main(void) {
    float input[CIN][H][W];
    float weight[COUT][CIN];
    float output[COUT][H][W];

    int v = 1;

    for (int ic = 0; ic < CIN; ic++)
        for (int h = 0; h < H; h++)
            for (int w = 0; w < W; w++)
                input[ic][h][w] = v++;

    v = 1;

    for (int oc = 0; oc < COUT; oc++)
        for (int ic = 0; ic < CIN; ic++)
            weight[oc][ic] = v++;

    for (int oc = 0; oc < COUT; oc++) {
        for (int h = 0; h < H; h++) {
            for (int w = 0; w < W; w++) {
                float sum = 0.0f;

                printf("\noutput[%d][%d][%d]\n", oc, h, w);

                for (int ic = 0; ic < CIN; ic++) {
                    float mul = input[ic][h][w] * weight[oc][ic];
                    sum += mul;

                    printf("input[%d][%d][%d](%.0f) * weight[%d][%d](%.0f) = %.0f, sum = %.0f\n",
                           ic, h, w, input[ic][h][w],
                           oc, ic, weight[oc][ic],
                           mul, sum);
                }

                output[oc][h][w] = sum;
                printf("=> output[%d][%d][%d] = %.0f\n", oc, h, w, output[oc][h][w]);
            }
        }
    }

    return 0;
}