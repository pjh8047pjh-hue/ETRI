# BMP 파일 처리 순서와 C 문법 정리

이 문서는 BMP 파일을 읽고, 픽셀 데이터를 동적할당으로 저장한 뒤, 새 BMP 파일로 다시 저장하는 흐름을 기준으로 정리한 것이다.

## 1. 전체 순서

BMP 파일을 처리하는 기본 순서는 아래와 같다.

```text
1. 원본 BMP 파일 열기
2. 14바이트 BITMAPFILEHEADER 읽기
3. 40바이트 BITMAPINFOHEADER 읽기
4. infoHeader에서 이미지 크기, 비트 수 확인
5. 이미지 크기를 기준으로 픽셀 데이터 크기 계산
6. 픽셀 데이터를 저장할 배열 동적할당
7. fseek로 픽셀 데이터 시작 위치까지 이동
8. fread로 픽셀 데이터 읽기
9. 필요하면 픽셀 데이터 처리
10. 새 BMP 파일 열기
11. 새 파일에 header 쓰기
12. 새 파일에 pixel data 쓰기
13. free와 fclose로 정리
```

BMP 파일 구조는 보통 아래처럼 생각하면 된다.

```text
[14바이트 File Header][40바이트 Info Header][색상 테이블이 있을 수도 있음][Pixel Data]
```

그래서 픽셀 데이터가 항상 54바이트부터 시작한다고 단정하면 안 된다. 실제 시작 위치는 `fileHeader.bfOffBits`에 들어 있다.

## 2. 파일 열기: fopen

파일을 읽을 때는 `rb`를 쓴다.

```c
FILE *fpIn = fopen("lenna.bmp", "rb");
```

뜻은:

```text
lenna.bmp 파일을 바이너리 읽기 모드로 열어라
```

파일 열기에 실패할 수 있으므로 반드시 확인하는 것이 좋다.

```c
if (fpIn == NULL) {
    printf("input file open failed\n");
    return 1;
}
```

새 파일을 만들거나 저장할 때는 `wb`를 쓴다.

```c
FILE *fpOut = fopen("output.bmp", "wb");
```

뜻은:

```text
output.bmp 파일을 바이너리 쓰기 모드로 열어라
```

## 3. 헤더 읽기: fread

`fread`는 파일에서 데이터를 읽어서 메모리에 저장하는 함수다.

기본 문법:

```c
fread(저장할_주소, 한_개_크기, 몇_개, 파일포인터);
```

정식 형태:

```c
size_t fread(void *ptr, size_t size, size_t count, FILE *stream);
```

BMP 헤더를 읽을 때는 이렇게 쓴다.

```c
BITMAPFILEHEADER fileHeader;
BITMAPINFOHEADER infoHeader;

fread(&fileHeader, sizeof(BITMAPFILEHEADER), 1, fpIn);
fread(&infoHeader, sizeof(BITMAPINFOHEADER), 1, fpIn);
```

뜻은:

```text
BITMAPFILEHEADER 크기만큼 1개 읽어서 fileHeader 변수에 저장
BITMAPINFOHEADER 크기만큼 1개 읽어서 infoHeader 변수에 저장
```

구조체 변수에 저장할 때는 변수 이름 앞에 `&`를 붙인다.

```c
fread(&fileHeader, sizeof(BITMAPFILEHEADER), 1, fpIn);
```

배열이나 포인터에 저장할 때는 보통 `&`를 붙이지 않는다.

```c
fread(imageData, sizeof(unsigned char), imageSize, fpIn);
```

## 4. 헤더에서 필요한 정보 꺼내기

헤더를 읽은 뒤에는 이미지 정보를 확인할 수 있다.

```c
int width = infoHeader.biWidth;
int height = infoHeader.biHeight;
int bitCount = infoHeader.biBitCount;
int offset = fileHeader.bfOffBits;
```

각각의 의미:

```text
biWidth    : 이미지 가로 크기
biHeight   : 이미지 세로 크기
biBitCount : 픽셀 하나를 표현하는 비트 수
bfOffBits  : 픽셀 데이터가 시작되는 파일 위치
```

예를 들어 24비트 BMP라면 픽셀 하나는 보통 3바이트다.

```c
int bytesPerPixel = infoHeader.biBitCount / 8;
```

## 5. 픽셀 데이터 크기 계산

BMP는 한 줄의 바이트 수가 4의 배수가 되도록 맞춰진다. 그래서 단순히 `width * height * bytesPerPixel`만 하면 틀릴 수 있다.

한 줄 크기는 보통 이렇게 계산한다.

```c
int rowSize = ((width * bytesPerPixel + 3) / 4) * 4;
```

전체 이미지 데이터 크기:

```c
int imageSize = rowSize * height;
```

정리:

```c
int width = infoHeader.biWidth;
int height = infoHeader.biHeight;
int bytesPerPixel = infoHeader.biBitCount / 8;
int rowSize = ((width * bytesPerPixel + 3) / 4) * 4;
int imageSize = rowSize * height;
```

## 6. 동적할당: malloc

`malloc`은 실행 중에 원하는 크기만큼 메모리를 빌리는 함수다.

기본 문법:

```c
자료형 *포인터 = (자료형 *)malloc(sizeof(자료형) * 개수);
```

예시:

```c
unsigned char *imageData;

imageData = (unsigned char *)malloc(sizeof(unsigned char) * imageSize);
```

`unsigned char`는 1바이트라서 이미지 픽셀 데이터를 저장할 때 자주 사용한다.

`malloc` 뒤에는 실패했는지 확인하는 것이 좋다.

```c
if (imageData == NULL) {
    printf("memory allocation failed\n");
    fclose(fpIn);
    return 1;
}
```

사용이 끝나면 반드시 `free`로 해제한다.

```c
free(imageData);
```

## 7. 픽셀 데이터 위치로 이동: fseek

`fseek`는 파일 안에서 읽거나 쓸 위치를 이동시키는 함수다.

기본 문법:

```c
fseek(파일포인터, 이동할_바이트수, 기준위치);
```

BMP에서 픽셀 데이터 위치로 이동할 때:

```c
fseek(fpIn, fileHeader.bfOffBits, SEEK_SET);
```

뜻은:

```text
파일 시작 위치에서 bfOffBits 바이트만큼 이동해라
```

`SEEK_SET`은 파일의 처음을 기준으로 이동하겠다는 뜻이다.

## 8. 픽셀 데이터 읽기

픽셀 데이터 시작 위치로 이동한 뒤, `fread`로 픽셀 데이터를 읽는다.

```c
fread(imageData, sizeof(unsigned char), imageSize, fpIn);
```

뜻은:

```text
fpIn 파일에서 imageSize 바이트만큼 읽어서 imageData에 저장해라
```

이제 `imageData` 안에 BMP의 실제 픽셀 값들이 들어 있다.

## 9. 새 BMP 파일에 저장: fwrite

`fwrite`는 메모리에 있는 데이터를 파일에 쓰는 함수다.

기본 문법:

```c
fwrite(쓸_데이터_주소, 한_개_크기, 몇_개, 파일포인터);
```

새 BMP 파일을 열고:

```c
FILE *fpOut = fopen("output.bmp", "wb");

if (fpOut == NULL) {
    printf("output file open failed\n");
    free(imageData);
    fclose(fpIn);
    return 1;
}
```

헤더를 먼저 쓴다.

```c
fwrite(&fileHeader, sizeof(BITMAPFILEHEADER), 1, fpOut);
fwrite(&infoHeader, sizeof(BITMAPINFOHEADER), 1, fpOut);
```

그 다음 픽셀 데이터 시작 위치로 이동한다.

```c
fseek(fpOut, fileHeader.bfOffBits, SEEK_SET);
```

픽셀 데이터를 쓴다.

```c
fwrite(imageData, sizeof(unsigned char), imageSize, fpOut);
```

## 10. memcpy

`memcpy`는 메모리 내용을 통째로 복사하는 함수다.

기본 문법:

```c
memcpy(복사받을곳, 복사할곳, 복사할바이트수);
```

예시:

```c
unsigned char a[5] = {1, 2, 3, 4, 5};
unsigned char b[5];

memcpy(b, a, sizeof(unsigned char) * 5);
```

뜻은:

```text
a에 있는 5바이트 데이터를 b로 복사해라
```

네 코드의 이런 형태:

```c
memcpy(buffer, pO, sizeof(unsigned char) * 510 * 510);
```

뜻은:

```text
pO에 있는 결과 이미지 데이터를 buffer로 복사해라
```

하지만 바로 파일에 쓸 거라면 `memcpy`가 꼭 필요하지는 않다.

아래처럼 복사 후 저장하는 코드:

```c
memcpy(buffer, pO, sizeof(unsigned char) * 510 * 510);
fwrite(buffer, sizeof(unsigned char), 510 * 510, fpOut);
```

이 코드는 보통 이렇게 줄일 수 있다.

```c
fwrite(pO, sizeof(unsigned char), 510 * 510, fpOut);
```

즉, `pO` 자체가 이미 저장할 데이터라면 굳이 `buffer`로 한 번 더 복사하지 않아도 된다.

## 11. char *pK = (char *)weight

네 코드에 있는 형태:

```c
char weight[3][3] = {
    {1, 0, -1},
    {1, 0, -1},
    {1, 0, -1}
};

char *pK = (char *)weight;
```

이 문장은 `weight`라는 2차원 배열을 `char *` 포인터로 바꿔서 1차원 배열처럼 접근하겠다는 뜻이다.

원래 방식:

```c
weight[k][h]
```

포인터 방식:

```c
pK[3 * k + h]
```

둘은 같은 위치를 가리킨다.

```text
weight[0][0] == pK[0]
weight[0][1] == pK[1]
weight[0][2] == pK[2]
weight[1][0] == pK[3]
weight[1][1] == pK[4]
weight[1][2] == pK[5]
weight[2][0] == pK[6]
weight[2][1] == pK[7]
weight[2][2] == pK[8]
```

그래서 convolution 계산에서:

```c
sum += pI[512 * (j + k) + i + h] * pK[3 * k + h];
```

이 코드는 아래와 같은 의미다.

```c
sum += pI[512 * (j + k) + i + h] * weight[k][h];
```

초보자 입장에서는 `weight[k][h]`가 더 읽기 쉽다.

## 12. BMP 복사 예시 코드

아래 코드는 BMP 파일을 읽어서 새 BMP 파일로 그대로 저장하는 기본 형태다.

```c
#include <stdio.h>
#include <stdlib.h>
#include "bitmap.h"

int main()
{
    FILE *fpIn;
    FILE *fpOut;
    BITMAPFILEHEADER fileHeader;
    BITMAPINFOHEADER infoHeader;
    unsigned char *imageData;

    fpIn = fopen("lenna.bmp", "rb");
    if (fpIn == NULL) {
        printf("input file open failed\n");
        return 1;
    }

    fread(&fileHeader, sizeof(BITMAPFILEHEADER), 1, fpIn);
    fread(&infoHeader, sizeof(BITMAPINFOHEADER), 1, fpIn);

    int width = infoHeader.biWidth;
    int height = infoHeader.biHeight;
    int bytesPerPixel = infoHeader.biBitCount / 8;
    int rowSize = ((width * bytesPerPixel + 3) / 4) * 4;
    int imageSize = rowSize * height;

    imageData = (unsigned char *)malloc(sizeof(unsigned char) * imageSize);
    if (imageData == NULL) {
        printf("memory allocation failed\n");
        fclose(fpIn);
        return 1;
    }

    fseek(fpIn, fileHeader.bfOffBits, SEEK_SET);
    fread(imageData, sizeof(unsigned char), imageSize, fpIn);

    fpOut = fopen("output.bmp", "wb");
    if (fpOut == NULL) {
        printf("output file open failed\n");
        free(imageData);
        fclose(fpIn);
        return 1;
    }

    fwrite(&fileHeader, sizeof(BITMAPFILEHEADER), 1, fpOut);
    fwrite(&infoHeader, sizeof(BITMAPINFOHEADER), 1, fpOut);

    fseek(fpOut, fileHeader.bfOffBits, SEEK_SET);
    fwrite(imageData, sizeof(unsigned char), imageSize, fpOut);

    free(imageData);
    fclose(fpIn);
    fclose(fpOut);

    return 0;
}
```

## 13. 핵심 요약

```text
fopen("file.bmp", "rb") : BMP 파일 읽기용으로 열기
fopen("out.bmp", "wb") : BMP 파일 쓰기용으로 열기
fread                  : 파일에서 메모리로 읽기
fwrite                 : 메모리에서 파일로 쓰기
fseek                  : 파일 내부 위치 이동
malloc                 : 실행 중 필요한 크기만큼 메모리 만들기
free                   : malloc으로 만든 메모리 해제
memcpy                 : 메모리 내용을 다른 메모리로 복사
char *pK=(char *)weight: 2차원 배열을 1차원 포인터처럼 보기
```

가장 중요한 흐름은 이것이다.

```text
헤더 읽기 -> 크기 계산 -> malloc -> fseek -> 픽셀 fread -> 새 파일 fopen -> 헤더 fwrite -> 픽셀 fwrite -> free/fclose
```
