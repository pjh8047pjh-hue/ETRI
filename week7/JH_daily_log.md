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

## dsp implementataion 중요!
CASCADE로 사용할 때는 ACIN으로 포트 이름을 설정해줘야 함!!!!!!!


## input bram으로 depthwise에 받아올 때 주의사항
1. width = 몇 bit 씩 받아와서 저장할건지 line buffer에 바로 물릴 수 있는지 고민
2, 여러 bit를 burst로 받아와서 dsp에 최대 비트로 넣어서 가드비트 포함하여 가속화 할 수 있는지 고민

## start 제어 신호 확인하기
필요없이 삭제하려면 하는게 좋은데 안될듯. pointwise에서 한 채널의 값이 끝나면 start 하도록 설정 필요


## dsp + weight bram 구현 완료
dsp에서 pre-adder를 제외하고 다시 generate 해서 1 clk을 줄임.

## clock wizard로 인풋을 줘서 timing 확인