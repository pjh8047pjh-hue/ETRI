#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bitmap.h"

int main() {
	FILE *fpBmp;
	BITMAPFILEHEADER fileHeader;
	BITMAPINFOHEADER infoHeader;

	fpBmp = fopen("lenna.bmp", "rb");
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

	for(int i=0; i<height; i++){
		for(int j=0; j<width; j++){
			int index = i * rowSize + j * bytesPerPixel;
			
			pOdata[index + 1] = 0;
			pOdata[index + 2] = 0;
		}
	}
	
	FILE *fpOut = fopen("blue.bmp", "wb");

	fwrite(&fileHeader, sizeof(BITMAPFILEHEADER), 1, fpOut);
	fwrite(&infoHeader, sizeof(BITMAPINFOHEADER), 1, fpOut);
	fwrite(pOdata, sizeof(unsigned char), rowSize * height, fpOut);

	fclose(fpBmp);
	fclose(fpOut);
	
	free(pIdata);
	free(pOdata);
	return 0;
}