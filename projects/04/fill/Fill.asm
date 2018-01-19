// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(BLACK)
@SCREEN
A=1
@LOOP
0;JMP

(WHITE)
@SCREEN
A=1
@LOOP
0;JMP

(LOOP)
@KBD
D=A
@BLACK
D;JNE // ゼロだったら黒くする

@WHITE
D;JEQ // ゼロ以外だったら黒くする

@LOOP
0;JMP