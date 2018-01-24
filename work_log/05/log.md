# CPU

## 命令のパース(実装案で言うところの`decode`)
16ビットのワードをパース -> [i xx a cccccc ddd jjj]

iビットが0なら、A命令になり、命令に埋め込まれた15ビット(a,c,d,jが合体して)の定数値がAレジスタに設定
iビットが1なら、C命令になり、a,c,d,jは制御ビットとして扱う(ALUとレジスタに命令を実行させる)

と言うことで、この判別以外では、iビットを使用しているところを見つけられないので（現状）、instruction[15]をそのまま判別をかけて、
AとCのどちらの命令なのか判定させる、多分AなのかCなのかは色々な場所で使われるだろうから変数にしておいたほうが良さそう

1ビットを抜き出すなら,AndゲートでA命令なのかC命令なのか判定出来る
```
And(a=instruction[15], b=true, out=isC);
```

## Aレジスタの格納
※ A（アドレス）レジスタは[データ値|RAMアドレス|ROMアドレス]のどれかの意味として解釈される（命令に寄って変わる）とある
実装案を見ると、MuxゲートでMの出力値（１つ前の）とinstructionを渡す様になっているっぽい
なので命令であるisAで判定させたMux16ゲートの出力値をAレジスタに渡して上げればよい？

ただ、Aレジスタに渡すloadビットが分からない。何で判定するか？デコードで使ってるビットなのは間違いないとは思う

```
// ARegisterゲート自体はビルトインで提供されている
// (typically used to store an address)
ARegister(in[16], load, out[16]);
```

```
Mux16(a=instruction, b=preOutM, sel=isC, out=address);
ARegister(in=address, load=???, out=out);
```

    Mux16(a=preOutM, b=instruction, sel=instruction[15], out=instructionOut);