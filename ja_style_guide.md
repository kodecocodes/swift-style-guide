# raywenderlich.com 公式のSwiftスタイルガイド  
  
このスタイルガイドは、他のものとは多少異なっているかもしれません。  
なぜなら、印刷やWeb用での読みやすさに焦点をあてているからです。  
raywenderlich.comには多くの著者をが集まっていますが、  
書籍、チュートリアル、スタートキット上で一貫性のあるコードを維持するために、このスタイルガイドを作成しました。   
  
大枠の指針・目標は簡潔、読みやすさ、とシンプルさです。  
  
Objective-Cのコーディング規約はこちらです。  
[Objective-Cのスタイルガイド]（https://github.com/raywenderlich/objective-c-style-guide）  

## Table of Contents

* [Naming](#naming)
  * [Class Prefixes](#class-prefixes)
* [Spacing](#spacing)
* [Comments](#comments)
* [Classes and Structures](#classes-and-structures)
  * [Use of Self](#use-of-self)
* [Function Declarations](#function-declarations)
* [Closures](#closures)
* [Types](#types)
  * [Constants](#constants)
  * [Optionals](#optionals)
  * [Struct Initializers](#struct-initializers)
  * [Type Inference](#type-inference)
  * [Syntactic Sugar](#syntactic-sugar)
* [Control Flow](#control-flow)
* [Semicolons](#semicolons)
* [Language](#language)
* [Smiley Face](#smiley-face)
* [Credits](#credits)


## Naming

メソッド名や変数は小文字で始めるべきです。  
メソッド名、変数は小文字から始めるべきですが、モジュールスコープのクラス名と定数は大文字にするべきです。  
  
**推奨:**

```swift
let MaximumWidgetCount = 100

class WidgetContainer {
  var widgetButton: UIButton
  let widgetHeightPercentage = 0.85
}
```

**非推奨:**

```swift
let MAX_WIDGET_COUNT = 100

class app_widgetContainer {
  var wBut: UIButton
  let wHeightPct = 0.85
}
```

文脈が明確でない限り、関数とイニシャライザでは、すべて名前付きのパラメータが良いでしょう。  
外部パラメータ名も含みます。それは関数呼び出しをより読みやすくするでしょう。  
  
```swift
func dateFromString(dateString: NSString) -> NSDate
func convertPointAt(#column: Int, #row: Int) -> CGPoint
func timedAction(#delay: NSTimeInterval, perform action: SKAction) -> SKAction!

// would be called like this:
dateFromString("2014-03-14")
convertPointAt(column: 42, row: 13)
timedAction(delay: 1.0, perform: someOtherAction)
```

メソッドの場合、メソッド名に第一パラメータの参照を含むかは標準のAppleの規約に従ってください。  
Appleの規約  
https://developer.apple.com/library/ios/documentation/swift/conceptual/swift_programming_language/Methods.html#//apple_ref/doc/uid/TP40014097-CH15-XID_356*  
  
```swift
class Guideline {
  func combineWithString(incoming: String, options: Dictionary?) { ... }
  func upvoteBy(amount: Int) { ... }
}
```

チュートリアル、書籍、コメントなどの関数を参照するときは、呼び出し側の観点から必須パラメータ名が含まれています。  
文脈が明確であり、正確なシグニチャが重要でない場合は、メソッド名のみで使用することができます。  
  
> Call `convertPointAt(column:row:)` from your own `init` implementation.
>
> If you implement `didSelectRowAtIndexPath`, remember to deselect the row when you're done.
>
> You shouldn't call the data source method `tableView(_:cellForRowAtIndexPath:)` directly.


### Class Prefixes

Swiftの型は全て自動的にモジュール単位の名前空間になります。  
そのため、命名衝突を最小にするためのプレフィクスは必要としません。   
同じ名前で異なるモジュールの場合、モジュール名と型名を付けることによって明確にすることができます：  
  

```swift
import MyModule

var myClass = MyModule.MyClass()
```

Swiftの型にプレフィックスをつけないでください。  
  
Objective-C内で使用するSwiftを公開する場合は、適切なプレフィックスを提供することができます。  
（下記[Objective-Cのスタイルガイド]のように（https://github.com/raywenderlich/objective-c-style-guide））：  
  
```swift
@objc (RWTChicken) class Chicken {
   ...
}
```


## Spacing

タブより2スペースインデントでスペースを節約し、行の折り返しを避けてください。  
Xcodeでこのプリファレンスを設定してください。  
メソッドの中括弧や他のブレース（ `if`/` else`/ `switch`/` while`など）は、  
常に文と同じ行でオープンし、新しい行でクローズします。  
　　

**推奨:**
```swift
if user.isHappy {
  //Do something
} else {
  //Do something else
}
```

**非推奨:**
```swift
if user.isHappy
{
    //Do something
}
else {
    //Do something else
}
```

メソッド間には見やすくするために一つの空白行があるはずです。   
ひとつのメソッド内に空白の区切りが多すぎる場合は、いくつかのメソッドに分割するべきでしょう。  

## Comments
  
コメントを必要とする場合には、コードの特定の部分が何なのか理由を説明するのにコメントを使用します。  
コメントはメンテナンスして最新に保つ必要があります。  
  
コードはできるだけ文書としてあるべきように、インラインのブロックコメントを避けてください。  
例外：ドキュメントを生成するために使用するコメントには適用されません。  
  
  
## Classes and Structures
  
よいクラス定義の例を示します。  
   
```swift
class Circle: Shape {
  var x: Int, y: Int
  var radius: Double
  var diameter: Double {
    get {
      return radius * 2
    }
    set {
      radius = newValue / 2
    }
  }

  init(x: Int, y: Int, radius: Double) {
    self.x = x
    self.y = y
    self.radius = radius
  }

  convenience init(x: Int, y: Int, diameter: Double) {
    self.init(x: x, y: y, radius: diameter / 2)
  }

  func describe() -> String {
    return "I am a circle at \(centerString()) with an area of \(computeArea())"
  }

  override func computeArea() -> Double {
    return M_PI * radius * radius
  }

  private func centerString() -> String {
    return "(\(x),\(y))"
  }
}
```

上記の例は、次のスタイルガイドラインを示しています:  
  
プロパティ、変数、定数、引数には型を指定し、コロンの前ではなく後ろにスペースを入れます。  
 例 `x: Int`,  `Circle: Shape`  
共通の目的/コンテキストを共有する場合、一行で複数の変数や構造を定義します。  
ゲッター/セッターの定義およびプロパティオブザーバーはインデントします。  
デフォルトである`internal`などの修飾子を追加しないでください。  
メソッドをオーバーライドする場合も同様に、アクセス修飾子を繰り返さない。  
  
### Use of Self
  
Swiftはオブジェクトのプロパティアクセス、メソッド呼び出しで`self`を必要としないため、 
簡潔にするために、`self`の使用は避けてください。  
  
プロパティ名と引数の初期化で区別するために必要な場合、クロージャ内でプロパティを参照する場合には明確にするために`self`を使用してください。  
  
  
```swift
class BoardLocation {
  let row: Int, column: Int

  init(row: Int,column: Int) {
    self.row = row
    self.column = column
    
    let closure = { () -> () in
      println(self.row)
    }
  }
}
```

## Function Declarations
  
関数は短く簡潔に、開き括弧を含めて1行にまとめてください:  
  
```swift
func reticulateSplines(spline: [Double]) -> Bool {
  // reticulate code goes here
}
```
  
長いシグネチャを持つ関数については、適切な箇所で改行をし、それに続く行にインデントを追加します:  
  
```swift
func reticulateSplines(spline: [Double], adjustmentFactor: Double,
    translateConstant: Int, comment: String) -> Bool {
  // reticulate code goes here
}
```


## Closures
  
可能な限りTrailingClosures構文を使用しましょう。すべてのケースで、意味の伝わる説明的な引数名を用いましょう:  
TrailingClosures構文参考:　http://qiita.com/edo_m18/items/1d93af7de75c6d415f19#2-6  
  
```swift
return SKAction.customActionWithDuration(effect.duration) { node, elapsedTime in 
  // more code goes here
}
```
  
文脈が明確な単一式のclosureについては、暗黙のリターンを使用します:  
  
```swift
attendeeList.sort { a, b in
  a > b
}
```

  
## Types
  
利用可能な場合は、必ずSwiftのネイティブ型を使用します。  
必要に応じて完全なセットを使用できるように、SwiftはObjective-Cにブリッジできます。  
  
**推奨:**
```swift
let width = 120.0                                    //Double
let widthString = (width as NSNumber).stringValue    //String
```

**非推奨:**
```swift
let width: NSNumber = 120.0                                 //NSNumber
let widthString: NSString = width.stringValue               //NSString
```
  
スプライトキットコードでは、変換の回避によってコードがより簡潔なる場合、`CGFloat`を使用します。  
  
### Constants
  
定数は`let`で定義します。変数は`var`で定義します。  
`let`キーワードを使用して定数を適切に定義すれば、おそらく`var`よりもはるかに多くをlet``使用するでしょう。  
  
**Tip:** *この基準を満たすのに役立つかもしれないテクニックとして、すべてを定数として定義し、コンパイラに怒られる場合にのみそれを変数に変更することです！  
  

### Optionals
  
nil値を許容する箇所では、変数や関数の戻り値の型をオプショナル`?`として宣言しましょう。  
  
後で使用する前に初期化することが確実なインスタンス変数のみ、Implicitly Unwrapped Optional型`!`で宣言しましょう。  
例えば、viewDidLoadで初期化するsubviewsなど。  
  
オプショナルの値にアクセスする時、一度アクセスしている値の場合や、チェーンの中で多くのオプショナルがある場合Optional Chainingを使用しましょう:  
  
```swift
myOptional?.anotherOne?.optionalView?.setNeedsDisplay()
```
  
１度のアンラップと複数の処理を実行するのに適している場合は、optional bindingを使用しましょう:  
参考: http://qiita.com/cotrpepe/items/e30c7442733b93adf46a#3-optional-binding  
  
```swift
if let view = self.optionalView {
  // do many things with view
}
```
  
### Struct Initializers
  
レガシーCGGeometryコンストラクタより、ネイティブSwift構造体の初期化子を使用しましょう。  
  
**推奨:**
```swift
let bounds = CGRect(x: 40, y: 20, width: 120, height: 80)
var centerPoint = CGPoint(x: 96, y: 42)
```

**非推奨:**
```swift
let bounds = CGRectMake(40, 20, 120, 80)
var centerPoint = CGPointMake(96, 42)
```

### Type Inference
  
Swiftコンパイラは変数および定数の型推論ができます。明示的な型を指定できますが、多くの場合必要ないでしょう。  
コンパクトなコードにして、コンパイラの定数または変数の型推測を利用しましょう。  
  
**推奨:**
```swift
let message = "Click the button"
var currentBounds = computeViewBounds()
```

**非推奨:**
```swift
let message: String = "Click the button"
var currentBounds: CGRect = computeViewBounds()
```

**NOTE**　このガイドラインに従うことで、説明的な名前を選ぶことは以前よりさらに重要になるでしょう。  
  
### Syntactic Sugar
  
ジェネリクス構文では型宣言のショートカットを使いましょう。  
  
**推奨:**
```swift
var deviceModels: [String]
var employees: [Int: String]
var faxNumber: Int?
```

**非推奨:**
```swift
var deviceModels: Array<String>
var employees: Dictionary<Int, String>
var faxNumber: Optional<Int>
```



## Control Flow
  
`for` loop over the `for-condition-increment`より、`for-in`を使用しましょう。  
  
**推奨:**
```swift
for _ in 0..<3 {
  println("Hello three times")
}

for person in attendeeList {
  // do something
}
```

**非推奨:**
```swift
for var i = 0; i < 3; i++ {
  println("Hello three times")
}

for var i = 0; i < attendeeList.count; i++ {
  let person = attendeeList[i]
  // do something
}
```

  
## Semicolons
  
Swiftはコード内の各ステートメントの後にセミコロンを必要としません。1行に複数の文を組み合わせる場合にのみ必要です。  
  
セミコロンを使用して複数行を１行で記述しないでください。  
  
このルールの唯一の例外は、`for-conditional-increment`です。しかし、可能な限り`for-in`を使用すべきです。  
  
**推奨:**
```swift
var swift = "not a scripting language"
```

**非推奨:**
```swift
var swift = "not a scripting language";
```
  
**NOTE**: Swiftはセミコロンを省略するとされるJavaScriptとは非常に異なっています,
セミコロンを省略することが一般的に安全でないとしています(http://stackoverflow.com/questions/444080/do-you-recommend-using-semicolons-after-every-statement-in-javascript)
  

  
## Language
  
AppleのAPIと一致させるために米国英語のスペルを使用してください。  
  
**推奨:**
```swift
var color = "red"
```

**非推奨:**
```swift
var colour = "red"
```
  
## Smiley Face
  
スマイリーの顔がraywenderlich.comサイトの顕著なスタイルを表しています！  
スマイリーが幸せと興奮をもたらす笑顔であることは、コーディングトピックとして非常に重要です。  
閉じ角括弧は`]`使用します。  
なぜなら、ASCIIアートを使ってキャプチャすることができる最大の笑顔を表すことができるからです。  
閉じ括弧は`）`は中途半端な笑顔を作成するので好ましくないですw  
  
**推奨:**
```
:]
```

**非推奨:**
```
:)
```  


## Credits

This style guide is a collaborative effort from the most stylish raywenderlich.com team members: 

* [Soheil Moayedi Azarpour](https://github.com/moayes)
* [Scott Berrevoets](https://github.com/Scott90)
* [Eric Cerney](https://github.com/ecerney)
* [Sam Davies](https://github.com/sammyd)
* [Evan Dekhayser](https://github.com/edekhayser)
* [Jean-Pierre Distler](https://github.com/pdistler)
* [Colin Eberhardt](https://github.com/ColinEberhardt)
* [Greg Heo](https://github.com/gregheo)
* [Matthijs Hollemans](https://github.com/hollance)
* [Erik Kerber](https://github.com/eskerber)
* [Christopher LaPollo](https://github.com/elephantronic)
* [Andy Pereira](https://github.com/macandyp)
* [Ryan Nystrom](https://github.com/rnystrom)
* [Cesare Rocchi](https://github.com/funkyboy)
* [Ellen Shapiro](https://github.com/designatednerd)
* [Marin Todorov](https://github.com/icanzilb)
* [Chris Wagner](https://github.com/cwagdev)
* [Ray Wenderlich](https://github.com/rwenderlich)
* [Jack Wu](https://github.com/jackwu95)

Hat tip to [Nicholas Waynik](https://github.com/ndubbs) and the [Objective-C Style Guide](https://github.com/raywenderlich/objective-c-style-guide) team!

We also drew inspiration from Apple’s reference material on Swift:

* [The Swift Programming Language](https://developer.apple.com/library/prerelease/ios/documentation/swift/conceptual/swift_programming_language/index.html)
* [Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/index.html)
* [Swift Standard Library Reference](https://developer.apple.com/library/prerelease/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html)

