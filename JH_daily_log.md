# 08/07
## layer 08 구현 계획
1. pointwise의 출력을 바꾸지 않고 일단 연산이 모두 끝나면 depthwise에서 그 값을 BRAM에서 받아서 연산 진행 
2. batchnorm을 따로 진행하지 않고 folding을 한 후에 relu6를 거쳐서 bram에 저장
3. 그 값을 가지고 일단은 systolic 구조처럼 구현한 depthwise에 연결

## depthwise 연산
1. 첫 번째는 synthsis까지 끝낸 multiply 사용하지 않고 곱셈으로 구현한 모델
2. 두 번째는 dsp를 사용해서 synthsis를 끝내고 이 둘을 비교
--> 어떤 측면에서 이득을 얻었는지에 대한 명확한 이유가 필요

### 다이어그램
draw.io에 전체 다이어그램을 그려놨으니 참고하기


## mobilenetV2 구현 중 
1. 전체 아키텍처 구상
2. 현재 만들어놓은 ip를 가지고 설계 진행
3. pointwise에서 연산된 accumulation 값을 어떻게 처리할것인가?
  --> saturation 처리를 어떻게 할 것인지. 몇 비트까지가 유의미한 것이고 어떻게 처리하는 것이 가장 큰 정확도를 보장하는지에 대해서 확실하게 알아야 함.




# 08/08
1. dsp48에서 pre-adder의 기능은 없다고 봐야하는데 왜 타이밍이 안맞는가?



# 08/09
1. data bit 수가 맞지 않는 문제를 해결. -> saturation 처리 : 상위 비트를 비교해서 부호 비트면 자르기, 범위가 벗어난 값이 나오면 max값과 min 값으로 saturation 시키기.