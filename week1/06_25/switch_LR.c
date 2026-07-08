#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bitmap.h"

int main() {
	FILE *fpBmp;
	BITMAPFILEHEADER fileHeader;
	BITMAPINFOHEADER infoHeader;

	fpBmp = fopen("baboon.bmp", "rb");
	if (fpBmp == NULL) {
		printf("File open error\n");
		return 1;
	}

	fread(&fileHeader, sizeof(BITMAPFILEHEADER), 1, fpBmp);
	fread(&infoHeader, sizeof(BITMAPINFOHEADER), 1, fpBmp);

	printf("bfSize: %d\n", fileHeader.bfSize);
	printf("bfOffBits: %d\n", fileHeader.bfOffBits);
	printf("Width: %d\n", infoHeader.biWidth);
	printf("Height: %d\n", infoHeader.biHeight);
	printf("Bit Count: %d\n", infoHeader.biBitCount);	

	int width = infoHeader.biWidth;
	int height = infoHeader.biHeight;
	int bfOffBits = fileHeader.bfOffBits;
	int bytesPerPixel = infoHeader.biBitCount / 8;
	int rowSize = ((width * bytesPerPixel + 3) / 4) * 4;
	int paddingSize = rowSize - (width * bytesPerPixel);

	unsigned char *pIdata = (unsigned char *)malloc(sizeof(unsigned char) * rowSize * height);
	unsigned char *pOdata = (unsigned char *)malloc(sizeof(unsigned char) * rowSize * height);

	fseek(fpBmp, bfOffBits , SEEK_SET);
	fread(pIdata, sizeof(unsigned char), rowSize * height, fpBmp);
	memcpy(pOdata, pIdata, rowSize * height);

	printf("Row Size: %d\n", rowSize);
	printf("Padding Size: %d\n", paddingSize);

	// i는 행을 나타냄(세로) : 몇 번째 행인가?
	// j는 열을 나타냄(가로) : 몇 번째 열인가?
	for(int i=0; i<height; i++){
		for(int j=0; j<width; j++){
			int leftindex = i * rowSize + j * bytesPerPixel;
			int rightindex = i * rowSize + (width - 1 - j) * bytesPerPixel;
			
			// leftindex와 rightindex의 BGR 값을 서로 바꿔서 pOdata에 저장
			pOdata[leftindex + 0] = pIdata[rightindex + 0];
			pOdata[leftindex + 1] = pIdata[rightindex + 1];
			pOdata[leftindex + 2] = pIdata[rightindex + 2];
		}
	}
	
	FILE *fpOut = fopen("switched_baboon.bmp", "wb");

	fwrite(&fileHeader, sizeof(BITMAPFILEHEADER), 1, fpOut);
	fwrite(&infoHeader, sizeof(BITMAPINFOHEADER), 1, fpOut);
	fwrite(pOdata, sizeof(unsigned char), rowSize * height, fpOut);

	fclose(fpBmp);
	fclose(fpOut);
	
	free(pIdata);
	free(pOdata);
	return 0;
}