# raywenderlich.com Swift风格指南

因为该指南关注于网页上以及打印版的可读性，所以它与其他你可能阅读过的指南有所不同。为了保证那些在我们书中、教程里以及配套工程里的代码看上去美观且一致，我们写下了这份风格指南，尽管我们的书由许多不同作者共同创作而成。

我们的首要目标是让代码紧凑，可读性高且简洁。

正在用Objective-C写程序？也看看我们的[Objective-C风格指南][objc-style-guide]吧。

## 目录

* [语言](#语言)
* [间隔](#间隔)
* [注释](#注释)
* [注释](#注释)
  * [类前缀](#类前缀)
* [类与结构体](#类与结构体)
* [函数声明](#函数声明)
* [闭包](#闭包)
* [类型](#类型)
  * [常量](#常量)
  * [Optionals](#Optionals)
  * [类型推断](#类型推断)
* [控制流](#控制流)
* [Self的使用](#Self的使用)
* [笑脸](#笑脸)
* [工作人员](#工作人员)

## 语言
	
使用美式英语拼写以匹配苹果的API

**优选：**
```swift
var color = "red"
```

**不建议使用：**
```swift
var colour = "red"
```

## 间隔

* 使用2个空格进行缩进而不是使用Tab，这样可以节省空格，阻止换行。确保在Xcode的配置项中进行了设置。
* 方法的花括号以及其它花括号（`if`/`else`/`switch`/`while`等等）总是跟语句在同一行开始，但是在新的一行中结束。

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

* 方法之间应该总是用一空白行进行分隔以提高视觉以及结构上的清晰度。方法中的空白符用来隔离功能块，但是如果一个方法中存在太多这种功能块时，通常也意味着你需要将它重构为多个方法了。

## 注释

* 在需要的时候使用注释说明一块代码**为什么**这么做。注释必须时刻跟进代码，不然删了得了。

* 因为代码应该尽可能的自文档化，所以避免在代码中使用成块的注释。**例外：该规则不适用与用于生成文档的成块注释。**

## 命名

使用驼峰法为类、方法、变量等等取一个描述性的名字。模块范围的类名以及常量名称要以大写字母开头，而方法名跟变量名则应该以小写字母开头。

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

对于普通函数以及构造函数名称，除非上下文含义非常清楚，对所有的参数都加以命名是更为推荐的做法。如果外部参数名称可以使得函数调用更具有可读性，那么请带上它。

```swift
func dateFromString(dateString: NSString) -> NSDate
func convertPointAt(#column: Int, #row: Int) -> CGPoint
func timedAction(#delay: NSTimeInterval, perform action: SKAction) -> SKAction!

// 会被这样调用
dateFromString("2014-03-14")
convertPointAt(column: 42, row: 13)
timedAction(delay: 1.0, perform: someOtherAction)
```

对于方法，遵循苹果的命名标准，在方法名中提及第一个参数：

```swift
class Guideline {
  func combineWithString(incoming: String, options: Dictionary?) { ... }
  func upvoteBy(amount: Int) { ... }
}
```

在文章中（包括教程，书以及评论）提到函数时，请从调用者的视觉来考虑，将所有的必要参数名都包含进来：

```
The dateFromString() function is great.
Call convertPointAt(column:, row:) from your init() method.
The return value of timedAction(delay:, perform:) may be nil.
Guideline objects only have two methods: combineWithString(options:) and upvoteBy()
You shouldn't call the data source method tableView(cellForRowAtIndexPath:) directly.
```

### 类前缀

Swift中的类型会自动加入包含它们的模块的命名空间。所以即使是为了最小化命名冲突的可能性，前缀也是不必要的。如果来自于不同模块的两个名称冲突了，可以通过在名称前面加上模块名以消除歧义：

```swift
import MyModule

var myClass = MyModule.MyClass()
```

**不应该**在自己创建的类型上加前缀。

如果需要将Swift类型暴露在Objective-C环境中使用，请按照以下方式提供合适的前缀（前缀的命名请参考[Objective-C风格指南](https://github.com/raywenderlich/objective-c-style-guide)）:

```swift
@objc (RWTChicken) class Chicken {
   ...
}
```




[objc-style-guide]: https://github.com/raywenderlich/objective-c-style-guide