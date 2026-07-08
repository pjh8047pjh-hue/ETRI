#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "C:\Users\user\Documents\JH\06_26\MobileNet\mobilenetv2_parameters.h"
#include "C:\Users\user\Documents\JH\06_26\MobileNet\imagenet_classes.h"   /* features_8_* weights (const float[]) */

/* ---- Layer 8 geometry -------------------------------------------------- */
#define CIN   64      /* block input / output channels                      */
#define CEXP  384     /* expanded channels (t = 6 -> 64*6)                   */
#define H     14
#define W     14
#define HW    (H * W) /* 196 spatial positions                              */
#define K     1       /* pointwise kernel                                   */
#define EPS   1e-5f

#define IN_BIN     "C:/Users/user/Documents/JH/06_26/MobileNet/MobileNet_v2/mobilenetv2_result_layer07.bin"
#define GOLDEN_BIN "C:/Users/user/Documents/JH/06_26/MobileNet/MobileNet_v2/mobilenetv2_result_layer08.bin"

int main() {
    
    // 파일 불러오기
    FILE *fpIn = fopen(IN_BIN, "rb");
    if (fpIn == NULL) {
        printf("input file open error\n");
        return 1;
    }
    
    FILE *fpOut = fopen(GOLDEN_BIN, "rb");
    if (fpOut == NULL) {
        printf("golden file open error\n");
        fclose(fpIn);
        return 1;
    }

    FILE *fpOutJH = fopen("JH_pointwise_output.bin", "wb");

    // 이미지의 입력과 출력을 위한 동적 메모리 할당
    float *pI = (float *)malloc(sizeof(float) * CIN * HW);
    float *pOgolden = (float *)malloc(sizeof(float) * CEXP * HW);
    float *pO = (float *)malloc(sizeof(float) * CEXP * HW);

    if (pI == NULL || pOgolden == NULL || pO == NULL) {
        printf("memory allocation error\n");
        fclose(fpIn);
        fclose(fpOut);
        free(pI);
        free(pOgolden);
        free(pO);
        return 1;
    }

    // 파일 읽기
    fread(pI, sizeof(float), CIN * HW, fpIn);
    fread(pOgolden, sizeof(float), CEXP * HW, fpOut);

    // -------------------------------- pointwise convolution ---------------------------------
    
    const float *Weight_point = features_8_conv_0_0_weight;  // pointwise weights
    
    // input[input channel][Height][Width]
    // output[output channel][Height][Width]
    // weight[0~63이 하나의 output channel에 대한 weight]
    for(int oc = 0; oc < 384;  oc++) {
        for(int h = 0; h < H; h++) {
            for(int w = 0; w < W; w++) {
                float sum = 0.0f;

                //pI[ic][h][w]  * Weight[oc][0~63]
                for (int ic = 0; ic < CIN; ic++){
                    sum += pI[ic * H * W + h * W + w] * Weight_point[oc * CIN + ic];
                }
                
                // 한 행에 원소가 W개 있기 때문에 h*W
                pO[oc * H * W + h * W + w] = sum;
            }
        }
    }
    //-----------------------------------------------------------------------------------------

    //---------------------------Batch normalization-------------------------------------------
    const float *gamma = features_8_conv_0_1_weight;  // Weights batch
    const float *bias_batch = features_8_conv_0_1_bias;  // Bias batch
    const float *running_mean_batch = features_8_conv_0_1_running_mean;  // running mean batch
    const float *running_var_batch = features_8_conv_0_1_running_var;  // running var batch

    for(int i = 0; i < i < CEXP * H * W; i++){
        // Batch normalization의 경우 채널 마다 한 개의 값을 가지기 때문에 인덱스 계산 필요
        int oc = i / (H * W);

            pO[i] = gamma[oc] * (pO[oc] - running_mean_batch[oc]) / sqrt(running_var_batch[oc] + EPS) + bias_batch[oc];
        }


    fwrite(pO, sizeof(float), CEXP*HW, fpOutJH);
    free(pI);
    free(pO);
    free(pOgolden);
}