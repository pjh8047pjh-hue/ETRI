# 08/07
## layer 08 구현 계획
1. pointwise의 출력을 바꾸지 않고 일단 연산이 모두 끝나면 depthwise에서 그 값을 BRAM에서 받아서 연산 진행 
2. batchnorm을 따로 진행하지 않고 folding을 한 후에 relu6를 거쳐서 bram에 저장
3. 그 값을 가지고 일단은 systolic 구조처럼 구현한 depthwise에 연결

## depthwise 연산
1. 첫 번째는 synthsis까지 끝낸 multiply 사용하지 않고 곱셈으로 구현한 모델
2. 두 번째는 dsp를 사용해서 synthsis를 끝내고 이 둘을 비교
--> 어떤 측면에서 이득을 얻었는지에 대한 명확한 이유가 필요

## 다이어그램
draw.io에 전체 다이어그램을 그려놨으니 참고하기