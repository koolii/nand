# 理論と実装

## 1章

### ブール値

* true/false
* 0/1

ブール関数を表現する最も簡単なのが真理値表を全パターン網羅すること。

### ブール式

* And
* Or
* Not

* xy = x And y
* x + y = x Or y
* ^x = Not x

### 正準表現

正準表現＝ブール式の1つ
真理値表から正準表現を出す時は、真理値の結果が1になる行に注目
それらの全てのブール値（x,y,z）のAnd結合を列挙する
その後に、列挙したブール式をOr結合することで正準表現で表すことができる

本書から正準表現を表すと下記のようになる。
（出力が1になる組み合わせが3通りあり、それらを全てOr結合している）

f(x,y,z) = ^xy^z + x^y^z + xy^z

### Nand

動作は全ての入力の論理積（AND）をとったものの反転（NOT）である
つまり、全ての入力が1の場合のみ出力が0になり、0の入力がひとつでもある場合は1を出力する
=> 普通にandの組み合わせの反対で認識すると楽

Nand(Norも同様)は興味深い性質を持っている
それはAnd, Or, NotはそれぞれNad(またはNor)だけから作ることが出来るということ
下記はNandだけでOrを作成している

e.g) それぞれを詳細に落とした状態。1つ1つを分解していく意識で考えればどうして下記のようになるか理解できる
* x Or y = (x Nand x) Nand (y Nand y)
* A AND B = NOT ( A NAND B ) = ( A NAND B ) NAND ( A NAND B )
* NOT A = A NAND A

### 論理ゲート(= 回路)

ブール関数を実装するための物理デバイス
基本的な論理ゲートから複雑な論理ゲートまで作成することができるようになっている

これら回路は振る舞いを抽象化しており、ハードウェアがどのようなものであっても同じ動作となるため
物理的な世界まで考えを巡らせる必要はない


#### 基本ゲート

And, Or, Not


##### Xor
2入力が互いに異なる場合に1をかえし、それ以外は0を返す
If a != b then out=0 else out=1

##### マルチプレクサ

3入力のゲートだが、「データビット」と呼ばれる2つの入力から1つを選択して出力する
選択には「選択ビット」(=sel)という入力が1つ与えられる
If sel=0 then out=a else out=b

##### デマルチプレクサ

1つの入力と「選択ビット」によって、出力を2つの内、どちらかに振り分ける
IF sel=0 then {a=in, b=0} else {a=0, b=in}

#### 複合ゲート

基本ゲートを組み合わせたもの