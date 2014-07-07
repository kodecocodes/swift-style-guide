# raywenderlich.com Swift风格指南

因为该指南关注于网页上以及打印版的可读性，所以它可能与你阅读过的指南有所不同。为了保证那些在我们书中、教程里以及初学者工程里的代码美观并且一致，我们写下了这份风格指南，尽管书由许多不同作者共同创作而成。

该指南的首要目标是让代码紧凑，可读性高且简洁。

正在用Objective-C写程序？也看看我们的[Objective-C风格指南][objc-style-guide]吧。

## 目录

* [语言](#语言)
* [间隔](#间隔)
* [注释](#注释)
* [命名](#命名)
  * [类前缀](#类前缀)
* [分号](#分号)
* [类与结构体](#类与结构体)
* [函数声明](#函数声明)
* [闭包](#闭包)
* [类型](#类型)
  * [常量](#常量)
  * [Optionals](#Optionals)
  * [类型推导](#类型推导)
  * [语法糖](#语法糖)
* [控制流](#控制流)
* [Self的使用](#Self的使用)
* [笑脸](#笑脸)
* [致谢](#致谢)

## 语言
	
使用美式英语拼写以确保和苹果公司的API一致

**优选：**
```swift
var color = "red"
```

**不建议使用：**
```swift
var colour = "red"
```

## 间隔

* 使用2个空格而不是Tab进行缩进，可以减少换行。确保在Xcode的配置项中使用此设置。
* 方法的花括号以及其它花括号（`if`/`else`/`switch`/`while`等等）总是跟语句在同一行开始，新起一行结束。

**优选：**

```swift
if user.isHappy {
  //Do something
} else {
  //Do something else
}
```

**不建议使用：**

```swift
if user.isHappy
{
    //Do something
}
else {
    //Do something else
}
```

* 方法之间应该总是用一个空行进行分隔以提高视觉以及结构上的清晰度。方法中的空白用来分开功能块，但是如果一个方法中存在太多功能块时，通常意味着你需要将它重构为多个方法。

## 注释

* 在需要的时候使用注释说明一块代码**为什么**这么做。注释必须时刻跟进代码，不然删了得了。

* 代码应该尽可能的自文档化，避免在代码中使用成块的注释。**例外：该规则不适用与用于生成文档的块注释。**

## 命名

使用驼峰法为类、方法、变量等取一个描述性强的名字。模块范围的类名和常量名以大写字母开头，而方法名和变量名应以小写字母开头。

**优选：**

```swift
let MaximumWidgetCount = 100

class WidgetContainer {
  var widgetButton: UIButton
  let widgetHeightPercentage = 0.85
}
```

**不建议使用：**

```swift
let MAX_WIDGET_COUNT = 100

class app_widgetContainer {
  var wBut: UIButton
  let wHeightPct = 0.85
}
```

对于函数以及初始化方法，除非上下文含义非常清楚，推荐对所有的参数都加以命名。如果外部参数名称可以使得函数调用更易读，请加上它。

```swift
func dateFromString(dateString: NSString) -> NSDate
func convertPointAt(#column: Int, #row: Int) -> CGPoint
func timedAction(#delay: NSTimeInterval, perform action: SKAction) -> SKAction!

// 会被这样调用
dateFromString("2014-03-14")
convertPointAt(column: 42, row: 13)
timedAction(delay: 1.0, perform: someOtherAction)
```

对于方法，遵循苹果公司的命名规范，在方法名中提及第一个参数：

```swift
class Guideline {
  func combineWithString(incoming: String, options: Dictionary?) { ... }
  func upvoteBy(amount: Int) { ... }
}
```

在所有提及到函数的内容中（包括教程，书以及评论），请从调用者的视角进行考虑，将所有的必要参数名都包含进来：

```
dateFromString()函数真是太棒了。
在你的init()方法中调用convertPointAt(column:, row:)。
timedAction(delay:, perform:)的返回值可能为nil。
Guideline对象只有两个方法：combineWithString(options:)和upvoteBy()。
你不应该直接调用数据源方法tableView(cellForRowAtIndexPath:)。
```

### 类前缀

Swift中的类型会被自动加入包含它们的模块的命名空间。所以减少命名冲突的前缀已经不必要了。如果同模块的两个名称冲突了，可以在名称前加上模块名消除歧义：

```swift
import MyModule

var myClass = MyModule.MyClass()
```

**不应该**给自己创建的Swift类型加前缀。

如果需要把Swift类型暴露给Objective-C使用，你可以添加一个合适的前缀（前缀的命名请参考[Objective-C风格指南][objc-style-guide]）:

```swift
@objc (RWTChicken) class Chicken {
   ...
}
```

## 分号

Swift不要求每条语句后加分号。只有在你想把多条语句写到一行时才需要加上分号。

请不要在一行中写上用分号隔开的多条语句。

这条规则的唯一例外就是`for-conditional-increment`结构，该结构中分号是必需的。不过请尽量用`for-in`结构代替它们。

**优选：**
```swift
var swift = "not a scripting language"
```

**不建议使用：**
```swift
var swift = "not a scripting language";
```

**请注意**：Swift与JavaScript不同, 在后者中省略分号[通常是不安全的](http://stackoverflow.com/questions/444080/do-you-recommend-using-semicolons-after-every-statement-in-javascript)。

## 类与结构体

下面是一个风格良好的类定义代码例子，请参考：

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
    return "I am a circle at (\(x),\(y)) with an area of \(computeArea())"
  }

  func computeArea() -> Double {
    return M_PI * radius * radius
  }  
}
```
上面的例子阐述了如下的风格准则：

+ 给属性、变量、常量、参数及其它语句指定类型时，在冒号的后面加上空格而不是前面，比如：`x: Int`跟`Circle: Shape`。
+ 对getter跟setter定义以及属性观察器进行缩进。
+ 如果多个变量、结构有着同样的目的或者上下文，在同一行上进行定义。

## Self的使用

在Swift中访问对象属性或调用方法时不需要使用`self`，请避免使用它。

使用`self`的唯一理由是在初始化一个类或结构体时区分属性名和参数名：

```swift
class BoardLocation {
  let row: Int, column: Int

  init(row: Int,column: Int) {
    self.row = row
    self.column = column
  }
}
```

## 函数声明

保持函数声明短小精悍，保持在一行内，花括号在同一行内开始：

```swift
func reticulateSplines(spline: [Double]) -> Bool {
  // reticulate code goes here
}
```

对于有着长签名的函数，请在适当的位置进行断行且对后续行缩进一级：

```swift
func reticulateSplines(spline: [Double], adjustmentFactor: Double,
    translateConstant: Int, comment: String) -> Bool {
  // reticulate code goes here
}
```

## 闭包

尽可能地使用尾闭包语法。在所有的情况下给闭包参数一个描述性强的名称：

```swift
return SKAction.customActionWithDuration(effect.duration) { node, elapsedTime in 
  // more code goes here
}
```

对于上下文清晰的单表达式闭包，使用隐式的返回值：

```swift
attendeeList.sort { a, b in
  a > b
}
```

## 类型

如果可能，使用Swift的原生类型。Swift提供了对Objective-C的桥接，如果需要，仍然可以使用全部的Objective-C方法：

**优选：**
```swift
let width = 120.0                                           //Double
let widthString = width.bridgeToObjectiveC().stringValue    //String
```

**不建议使用：**
```swift
let width: NSNumber = 120.0                                 //NSNumber
let widthString: NSString = width.stringValue               //NSString
```

在Sprite Kit的代码中，如果`CGFloat`可以避免过多的转换从而使得代码简洁，那么请使用它。

### 常量

常量通过`let`关键字定义，而变量使用`var`关键字定义。任何值如果**是**一个不变量，那么请使用`let`关键字恰如其分地定义它。最后你会发现自己喜欢使用`let`远多于`far`。

**Tip：**有一个方法可以帮你满足该项规则，将所有值都定义成常量，然后编译器提示的时候将其改为变量。

### Optionals

在nil值可能出现的情况下，将变量跟函数返回值的类型通过`?`定义成Optional。

只有在确定实例变量会在初始化之后才被使用的情况下，通过`!`将其定义为隐式解包类型（Implicitly Unwrapped Types），比如说会在`viewDidLoad`中被创建的子视图。

在访问一个Optional值时，如果该值只被访问一次，或者之后需要连续访问多个Optional值，请使用链式Optional语法：

```swift
myOptional?.anotherOne?.optionalView?.setNeedsDisplay()
```

对于需要将Optional值解开一次，然后进行多个操作的情况，使用Optional绑定更为方便：

```swift
if let view = self.optionalView {
  // do many things with view
}
```

### 类型推导

Swift的编译器可以推导出变量和常量的类型。可以显式地提供类型别名（冒号后面声明的类型），不过大多数情况下这都是不必要的。

保持代码紧凑，然后让编译器推断变量跟常量的类型。

**优选：**
```swift
let message = "Click the button"
var currentBounds = computeViewBounds()
```

**不建议使用：**
```swift
let message: String = "Click the button"
var currentBounds: CGRect = computeViewBounds()
```

**注意**：遵循这条准则意味着使用描述性强的名称比之前更为重要了。

## 语法糖

优先选择类型声明的缩写版本而不是使用完全的泛型语法：

**优选：**
```swift
var deviceModels: [String]
var employees: [Int: String]
var faxNumber: Int?
```

**不建议使用：**
```swift
var deviceModels: Array<String>
var employees: Dictionary<Int, String>
var faxNumber: Optional<Int>
```

## 控制流

对于`for`循环，优选`for-in`风格而不是`for-condition-increment`风格：

**优选：**
```swift
for _ in 0..3 {
  println("Hello three times")
}

for person in attendeeList {
  // do something
}
```

**不建议使用：**
```swift
for var i = 0; i < 3; i++ {
  println("Hello three times")
}

for var i = 0; i < attendeeList.count; i++ {
  let person = attendeeList[i]
  // do something
}
```

## 笑脸

笑脸对于raywenderlich.com来说是一个格外重要的风格特征。使用正确的笑脸可以表示出对某个主题的无穷尽的高兴以及兴奋程度。选用了`]`是因为它在ASCII艺术可以表示得最大的笑脸。而闭圆括号`)`因为给人一种“**呵呵**”的感觉而不建议使用。

**优选：**
```
:]
```

**不建议使用：**
```
:)
``` 

## 致谢

该风格指南是由下面这些格外有范儿的raywenderlich.com团队成员齐心协力一同打造：

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

向[Nicholas Waynik](https://github.com/ndubbs)以及[Objective-C风格指南](https://github.com/raywenderlich/objective-c-style-guide)团队脱帽致礼！

我们也从苹果公司的有关Swift的参考材料中获取了灵感：

* [The Swift Programming Language](https://developer.apple.com/library/prerelease/ios/documentation/swift/conceptual/swift_programming_language/index.html)
* [Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/index.html)
* [Swift Standard Library Reference](https://developer.apple.com/library/prerelease/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html)


[objc-style-guide]: https://github.com/raywenderlich/objective-c-style-guide
