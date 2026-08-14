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


# 08/10
1. depthwise, pointwise 연결
2. pointwise 연결할 때 채널 주소별로 저장하는 로직 설정
--> 검증 확인

# 8/11
## 할 일
1. 연산구조 확실하게 검증하고 확인. report 뽑기

## 문제점
1. 값이 잘 나오고 들어가기까지는 잘함 but zero padding 할 동안 값을 읽어오기 때문에 그 값을 저장할 무언가가 필요
or zero padding logic을 다시 잘 설계



# 08/12
1. depth 이후 pointwise 설계 -> DSP 개수와 BRAM의 폭을 재설정
input 은 8bit weight도 8bit
DSP 64개를 사용하여 계산
총 6clk 안에 384개의 한 채널 완성


# 8/13
1. tb pointwise after depth 완성
2. waveform 검증 중
3. delay 계산
15단인 이유는 5번과 같습니다. input_done에서 last_delay까지가 14clk이고, sum이 완성되기까지 1clk이 더 걸립니다. 14단으로 하면 done이 마지막 output_valid보다 1clk 먼저 떠서, 상위가 196번째 값을 놓칩니다.


cascade 구조로 하려 했으나 skew 발생 첫번째 pcout이 나오기까지 4clk이 걸리기 때문에 8개의 dsp가 딜레이로 걸림
-> skew를 주어서 dsp가 처음에만 값을 기다리도록 만들어줘야 함

A/B  → AREG(2) → MREG(1) → 가산기 → PREG(1)  = 4 clk
PCIN ──────────────────→ 가산기 → PREG(1)  = 1 clk

 stage 0 :  A0/B0 @T ──[AREG 2]─[MREG 1]──┐
                                          ├─[PREG]→ PCOUT0 @T+4
                               (PCIN 없음)┘

 stage 1 :  A1/B1 @T+1 ─[AREG 2]─[MREG 1]─┐
                                          ├─[PREG]→ PCOUT1 @T+5
                       PCOUT0 @T+4 ───────┘

stage 1의 A/B는 T+1에 들어가서 T+4에 가산기 입구에 도착합니다 (AREG 2 + MREG 1 = 3clk). PCIN도 마침 T+4에 도착하죠. 둘이 가산기에서 만나 PREG를 거쳐 T+5에 나옵니다.

즉 4clk은 각 단의 "깊이"이고, 단들은 서로 겹쳐서 돕니다. 4clk이 누적되는 게 아니라, 겹치고 남는 1clk(PREG)만 쌓입니다.

## 완성 및 검증

g=0 :        -32   =  -32
g=1 :  -32 +  32   =    0
g=2 :    0 +  96   =   96
g=3 :   96 + 160   =  256
g=4 :  256 + 224   =  480
g=5 :  480 + 288   =  768  <- output_valid가 뜨는 순간