// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;

// @LOOP_NUM M=8191 // (512 * 256 / 16) - 1 ゼロスタートだから1だけマイナス

(LOOP)
@SCREEN
D=A

@idx
M=D
// @idxに@SCREENのインデックスを渡す
// これはラベルなので全体でアクセス可能

@KBD
D=M

@WHITE
D;JEQ
@BLACK
D;JMP

(WHITE)
@idx
A=M
M=0 // Memory[@idx] = 0(white)

@idx
M=M+1
D=M // next pixel index (next)

@SCREEN
D=D-A // next = next - @SCREEN
@8191
D=D-A // next = next - 8191

@LOOP
D;JGT // break

@WHITE
0;JMP // loop by myself


(BLACK)
@idx
A=M
M=-1

@idx
M=M+1
D=M

@SCREEN
D=D-A
@8191
D=D-A

@LOOP
D;JGT
@BLACK
0;JMP
