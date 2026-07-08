#include <stdio.h>
#include <stdlib.h>

#define WIDTH 512
#define HEIGHT 512
#define KERNEL_SIZE 3
#define PADDING 1

int main() {
   // 파일 불러오기
	FILE *fpIn = fopen("lenna8bit.raw", "rb");
    if (fpIn == NULL) {
        printf("input file open error\n");
        return 1;
    }

	// 저장할 파일 열어두기
    FILE *fpOut = fopen("output_file.raw", "wb");
    if (fpOut == NULL) {
        printf("output file open error\n");
        fclose(fpIn);
        return 1;
    }

	// 이미지의 입력과 출력을 위한 동적 메모리 할당
    unsigned char *pI = (unsigned char *)malloc(sizeof(unsigned char) * WIDTH * HEIGHT);
    unsigned char *pO = (unsigned char *)malloc(sizeof(unsigned char) * WIDTH * HEIGHT);

    if (pI == NULL || pO == NULL) {
        printf("memory allocation error\n");
        fclose(fpIn);
        fclose(fpOut);
        free(pI);
        free(pO);
        return 1;
    }

    char kernel[KERNEL_SIZE][KERNEL_SIZE] = {
        {1, 0, -1},
        {1, 0, -1},
        {1, 0, -1}
    };

    fread(pI, sizeof(unsigned char), WIDTH * HEIGHT, fpIn);


	//i는 출력 열
	//j는 출력 행
	//k는 커널 열
	//h는 커널 행
	//x는 실제 입력 열
	//y는 실제 입력 행
    for (int j = 0; j < HEIGHT; j++) {          // output row
        for (int i = 0; i < WIDTH; i++) {       // output column
            // 픽셀에 대한 컨볼루션의 합 초기화하고 시작
			int sum = 0;

			// 커널과 패딩을 적용해서 컨볼루션 수행
            for (int h = 0; h < KERNEL_SIZE; h++) {      // kernel row
                for (int k = 0; k < KERNEL_SIZE; k++) {  // kernel column
                    int y = j + h - PADDING;
                    int x = i + k - PADDING;

					// 입력 이미지가 패딩 영역을 벗어나지 않도록 확인 후 컨볼루션 수행
                    if (y >= 0 && y < HEIGHT && x >= 0 && x < WIDTH) {
                        sum += pI[y * WIDTH + x] * kernel[h][k];
                    }
                }
            }

			// 컨볼루션 결과를 saturation 처리
            if (abs(sum) > 40) {
                pO[j * WIDTH + i] = 255;
            } else {
                pO[j * WIDTH + i] = 0;
            }
        }
    }

    fwrite(pO, sizeof(unsigned char), WIDTH * HEIGHT, fpOut);
	
    fclose(fpIn);
    fclose(fpOut);
    free(pI);
    free(pO);

	print("Output written to output_file.raw\n");

    return 0;
}
