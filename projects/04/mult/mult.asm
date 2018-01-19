// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

@2
M=0 // 最終的にRAM[2]に結果を挿入するので、まずは0で初期化

@i
M=1 // ループ変数を初期化

(LOOP)
@i
D=M // Dにiの値を一時的に確保

// 終了条件(MULT)
@1 // ループを回す回数
D=D-M
@END
D;JGT // (num of loop - @1 == 0) 一応これで終了条件は完了


// 終了条件(DEFAULT)
@100
D=D-A // Aに100を代入 && i = i - 100
@END
D;JGT // 100回ループさせる

@i
M=M+1 // インクリメント

@LOOP
0;JMP // LOOPを続ける

(END)
@END
0;JMP // fin