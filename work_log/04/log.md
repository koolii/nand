## Mult.asm
乗算をするということだが、どうやって乗算するかそもそも分からない
`2x = x + x` だよって書いてる所が有った

今回は R0 * R1なので、 R1回だけループして、R0を加算し続けてみたらどうだろうか。
ループは

```
(LOOP)
 // この中身がループされるっぽい
 // あとは R1回ループしたらbreakするように実装する？ @ENDと言うのを使う？
(END)
```

Here's the pseudo-code for the program:

```
// こんなのを見つけた
// do-whileがどういうのか忘れたけど、一度は必ずdoブロック内を実行して、whileの後の条件式でループ制御してたはず
n = 0
addr = 100
do {
    RAM[addr] = n
    addr = addr+1
    n = n+11
} while n <= 99


Hack program
1:      @n      // n = 0
2:      M=0
3:
4:      @100    // addr = 100
5:      D=A
6:      @addr
7:      M=D     // ここは何をしている？
8:
9:  (Loop)      // do {
10:     @n      //     RAM[addr] = n
11:     D=M
12:     @addr
13:     A=M
14:     M=D
15:
16:     @addr   //     addr = addr+1
17:     M=M+1
18:
19:     @11     //     n = n+11
20:     D=A
21:     @n
22:     MD=M+D  // (tricky: also leaves new 'n' value in D)
23:
24:     @99     // } while n <= 99
25:     D=D-A
26:     @Loop
27:     D;JLE
28:
29:     @Halt   // loop forever
30: (Halt)
31:     0;JMP
```

http://www1.idc.ac.il/tecs/lectures/chapter04.pdf
http://phoenix.goucher.edu/~kelliher/f2015/cs220/project04.pdf