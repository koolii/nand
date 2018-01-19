// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

// 初期化処理
@2
M=0 // 最終的にRAM[2]に結果を挿入するので、まずは0で初期化

@i
M=1 // ループ変数を初期化

// ループ内部処理
(LOOP)
@i
D=M // Dにiの値を一時的に確保

// judge of break
@1 // ループを回す回数
D=D-M // 引き算をしている理由はJGTの条件が真になるのはD==0の時だから
@END
D;JGT // (num of loop - @1 == 0) 一応これで終了条件は完了

// multiplication
@0
D=M
@2
M=M+D // @0の値を@2に加算する(@0自身に加算してしまうと、ループで次第に値が大きくなってしまうため、@2に直接足し合わせていく)

@i
M=M+1 // インクリメント

@LOOP
0;JMP // １つ前にAレジスタに代入したLOOPにjumpする

(END)
@END
0;JMP // fin (infinite loop is generally method of finish process in Hack machine language.)