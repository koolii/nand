```c
// 1 - 100までの和を求める

int i = 1;
int sum = 0;

while (i <= 100) {
  sum += i;
  i++;
}
```

↑をHack機械語で実装する

```
@i  // これでiというメモリを割り当てる？ A <- i?
M=1 // iに1を代入していて、この行を見ると、Memory[i] = 1と考えられるから@iは変数宣言と取れるかな

// ここから Aがバッファで、MがMemory[A]となり、実体だとわかる
// 個人的な解釈だと、Aが要素番号で、Memoryが配列、MがMemory[A]のalias

@sum
M=0 // iと同様にsumを初期化 Memory[sum] = 0

(LOOP)
@i // Aにiを代入
D=M // Dにiの値を代入

@100 // Aに100を代入
D=D-A // D(i) - A(100) を行う

@END
D;JGT // D(i-100) > 0ならENDへ移動(break条件)

@i
D=M
// Dにiを代入 ここって D=Aにしちゃだめなの？アドレスになってる？ A <- iになると思った。
// i自身が最初に変数？みたいなものとして確保しているからiはアドレスとなっているのかな
// だからaliasであるMを使って、Dに代入していると考えると腹落ちする

// sumとiを足し合わせるから、AとDでそれぞれ値を持たせている
// 今回はsumをAに代入しているからiをDに逃している

@sum
M=D+M
// M(sum) = M(sum) + D(i)  sumも↑と同様と考えればMなのも理解できる
// MがMemory[sum]のaliasだから合計値を代入して、sumのポインタの先が最新の合計値になる

@i
M=M+1 // i = i+1 でインクリメント

@LOOP
0;JMP // LOOPへ移動　自分自身にループ(whileループ)

(END)
@END
0;JMP // 無限ループ Hackプログラムを終了去せる時はよく使う
```