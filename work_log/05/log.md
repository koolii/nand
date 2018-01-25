# 関数
Hack 機械語の仕様に従って命令が実行される。言語仕様にある D と A は CPU に 存在するレジスタを指し、一方、M はアドレスが A の場所にあるメモリの値である
M に値を書き込む必要がある場合は writeM が 1 となる。その場合、書き込まれた値 は outM にも送信され、そのアドレスは addressM にも送信される(writeM=0 の場合、outM にはいかなる値も現れる可能性がある)。
reset=1 の場合、CPU は命令メモリのアドレスが 0 の場所に移動する(つまり、 次の時間サイクルにて pc=0 に設定される)。reset=0 の場合は、現在命令の実行 結果に従って移動先のアドレスが決まる。

# CPU

## 命令のパース(実装案で言うところの`decode`)
16ビットのワードをパース -> [i xx a ccccc ddd jjj]
それぞれのビットが行なう挙動については`/memo/05/hack-hardware.md`と`/memo/04/hack.md`を参照だが、iビットについては下記

## iビット
iビットが0なら、A命令になり、命令に埋め込まれた15ビット(a,c,d,jが合体して)の定数値がAレジスタに設定
iビットが1なら、C命令になり、a,c,d,jは制御ビットとして扱う(ALUとレジスタに命令を実行させる)

## a/cビット
ALUの制御ビットとして渡すが、ALUの入力ビットは6ビット分あり、aとcのビットを合計しても6ビットだから全て使う


と言うことで、この判別以外では、iビットを使用しているところを見つけられないので（現状）、instruction[15]をそのまま判別をかけて、
AとCのどちらの命令なのか判定させる、多分AなのかCなのかは色々な場所で使われるだろうから変数にしておいたほうが良さそう

1ビットを抜き出すなら,AndゲートでA命令なのかC命令なのか判定出来る
```
And(a=instruction[15], b=true, out=isC);
```

## Aレジスタの格納
Aレジスタ自身の役割については、`hack-hardware.md`を見れば良い
実装案を見ると、MuxゲートでMの出力値（１つ前の）とinstructionを渡す様になっているっぽい
なので命令であるisAで判定させたMux16ゲートの出力値をAレジスタに渡して上げればよい？

ただ、Aレジスタに渡すloadビットが分からない。何で判定するか？デコードで使ってるビットなのは間違いないとは思う
ビルトインのゲート説明には下記のように記載がある、load[t-1]と言うのはloadの値は保持していないと駄目ということ？

loadビット自体はクロックの概念に取り込まれているから特に気にする必要は無くて、loadに何を渡すかだけ考えればよい


```
 * If load[t-1]=1 then out[t] = in[t-1]
 * else out does not change (out[t] = out[t-1])
```

```
// ARegisterゲート自体はビルトインで提供されている
// (typically used to store an address)
ARegister(in[16], load, out[16]);
```

```
Mux16(a=instruction, b=preOutM, sel=isC, out=address);
ARegister(in=address, load=???, out=out);
```

## PCゲート
```
/**
 * A 16-bit counter with load and reset control bits.
 * if      (reset[t] == 1) out[t+1] = 0 -- 1
 * else if (load[t] == 1)  out[t+1] = in[t] -- 2
 * else if (inc[t] == 1)   out[t+1] = out[t] + 1  (integer addition) -- 3
 * else                    out[t+1] = out[t] -- 4
 */
```
これはPCゲートの中身を書き出しているもの、そして下記はCPU内部のPCのつなぎ方

```
If jump(t) then PC(t) = A(t − 1) else PC(t) = PC(t−1)+1
```

だからjumpの時はinであるAの値を渡すように組めばOKだと思う(ただ、loadにjumpを渡すんだが、どれを渡すのかわからんjumpは3bitあるよね？)

```
j1,j2,j3が全て1だったら、JUMPを行うと言う命令になる。その他のニーモニック(P73)のものは違うと思う
And(a=j1, b=true, out=j1o);
And(a=j2, b=true, out=j2o);
And(a=j3, b=true, out=j3o);
PC(in=outA, load=jump, inc=true, reset=reset, out=outPC);
```


    Mux16(a=preOutM, b=instruction, sel=instruction[15], out=instructionOut);
