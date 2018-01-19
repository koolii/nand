// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

@i
M=0

(LOOP)
@i
D=M // Dにiの値を一時的に確保

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