# The Official raywenderlich.com Swift Style Guide.

The reason we made this style guide was so that we could keep the code in our books, tutorials, and starter kits nice and consistent — even though we have many different authors working on the books.

This style guide is different from others you may see, because the focus is centered on readability for print and the web. Many of the decisions were made with an eye toward conserving space for print, easy legibility, and tutorial writing.

Writing Objective-C? Check out our [Objective-C Style Guide](https://github.com/raywenderlich/objective-c-style-guide) too.

## Credits

TK

## Table of Contents

* [Language](#language)
* [Spacing](#spacing)
* [Comments](#comments)
* [Naming](#naming)
* [Semicolons](#semicolons)
* [Classes and Structures](#classes-and-structures)
* [Function Declarations](#function-declarations)
* [Use of Self](#use-of-self)
* [Var vs. let](#var-vs-let)
* [Class Prefixes](#class-prefixes)
* [Type Inference](#type-inference)
* [Type Choice](#type-choice)
* [Smiley Face](#smiley-face)

## Language

US English should be used.

**Preferred:**
```swift
var color = "red"
```

**Not Preferred:**
```swift
var colour = "red"
```

## Spacing

* Indent using 2 spaces (this conserves space in print and makes line wrapping less likely). Never indent with tabs. Be sure to set this preference in Xcode.
* Method braces and other braces (`if`/`else`/`switch`/`while` etc.) always open on the same line as the statement but close on a new line.

**Preferred:**
```swift
if user.isHappy {
  //Do something
} else {
  //Do something else
}
```

**Not Preferred:**
```swift
if user.isHappy
{
    //Do something
}
else {
    //Do something else
}
```

* There should be exactly one blank line between methods to aid in visual clarity and organization. Whitespace within methods should separate functionality, but often there should probably be new methods.

## Comments

When they are needed, comments should be used to explain **why** a particular piece of code does something. Any comments that are used must be kept up-to-date or deleted.

Block comments should generally be avoided, as code should be as self-documenting as possible, with only the need for intermittent, few-line explanations. *Exception: This does not apply to those comments used to generate documentation.*


## Naming

Use descriptive names with camel case for classes, methods, variables, etc. Class names and constants in module scope should be capitalized, while method names and variables should start with a lower case letter.

**Preferred:**

```swift
let MaximumWidgetCount = 100

class WidgetContainer {
  var widgetButton: UIButton
  let widgetHeightPercentage = 0.85
}
```

**Not Preferred:**

```swift
let MAX_WIDGET_COUNT = 100

class app_widgetContainer {
  var wBut: UIButton
  let wHeightPct = 0.85
}
```

For functions and init methods, prefer named parameters for all arguments unless the context is very clear. Include external parameter names if it makes function calls more readable.

```swift
func dateFromString(dateString: NSString) -> NSDate
func convertPointAt(#column: Int, #row: Int) -> CGPoint
func timedAction(#delay: NSTimeInterval, perform action: SKAction) -> SKAction!

// would be called like this:
dateFromString("2014-03-14")
convertPointAt(column: 42, row: 13)
timedAction(delay: 1.0, perform: someOtherAction)
```

When referring to functions in prose (tutorials, books, comments) include the required parameter names from the caller's perspective.

```
The dateFromString() function is great.
Call convertPointAt(column:, row:) from your init() method.
The return value of timedAction(delay:, perform:) may be nil.
You shouldn't call the data source method tableView(cellForRowAtIndexPath:) directly.
```


## Semicolons

Swift does not require a semicolon after each statement in your code. They are only required if you wish to combine multiple statements on a single line.

Multiple statements should not be placed on a single line and semicolons should not be used.

The only exception to this rule is the `for-conditional-increment` construct, which requires semicolons. However, alternative `for-in` constructs should be used where possible.

**Preferred:**
```swift
var swift = "not a scripting language"
```

**Not Preferred:**
```swift
var swift = "not a scripting language";
```

**NOTE**: Swift is very different to JavaScript, where omitting semicolons is [generally considered unsafe](http://stackoverflow.com/questions/444080/do-you-recommend-using-semicolons-after-every-statement-in-javascript)

## Classes and Structures

Classes and structures (i.e. types defined using `struct`) should be organized as follows:

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

The example above demonstrates the following style guidelines:

 + Properties, variables, constants, argument declarations and other statements where a type is specified should be formatted with a space after the colon but not before, e.g. `x: Int`, and `Circle: Shape`.
 + Getter and setter definitions should be indented. The same applies to property observers.
 + Classes and structures should be organized in the following order:
     + variable and constant properties
     + initializers
     + public methods
     + private methods
 + Multiple variables and structures can be defined on a single line if they share a common purpose / context

## Use of Self

Swift does not require the use of the `self` keyword to access an object's properties or invoke its methods. The `self` keyword should not be used in contexts where the compiler does not require its usage.

The only reason for requiring the use of `self` is to differentiate between property names and arguments when initialising a class or structure:

```swift
class BoardLocation {
  let row: Int, column: Int

  init(row: Int,column: Int) {
    self.row = row
    self.column = column
  }
}
```

## Function Declarations

Keep short function declarations on one line including the opening brace:

```swift
func reticulateSplines(spline: Double[]) -> Bool {
  // reticulate code goes here
}
```

For functions with long signatures, add line breaks at appropriate points and add an extra indent on subsequent lines:

```swift
func reticulateSplines(spline: Double[], adjustmentFactor: Double,
    translateConstant: Int, comment: String) -> Bool {
  // reticulate code goes here
}
```


## Var vs. Let

With Swift, constants are defined using the `let` keyword, and variables with the `var` keyword. Any value which **is** a constant **must** be defined appropriately, using the `let` keyword. As a result, you will likely find yourself using `let` far more than `var`.

**NOTE:** One technique that might help meet this standard is to define everything as a constant and only change it to a variable when the compiler complains!


## Class Prefixes

Swift types are all automatically namespaced by the module that contains them. As a result, prefixes are not required in order to minimize naming collisions. If two names from different modules collide you can disambiguate by prefixing the type name with the module name:

```swift
import MyModule

var myClass = MyModule.MyClass()
```

You **should not** add prefixes to your Swift types.

If you need to expose a Swift type for use within Objective-C you can provide a suitable prefix (following our [Objective-C style guide](https://github.com/raywenderlich/objective-c-style-guide)) as follows:

```swift
@objc (RWTChicken) class Chicken {
   ...
}
```

## Type Inference

The Swift compiler is able to infer the type of variables and constants. You can provide an explicit type via a type alias (which is indicated by the type after the colon), but in the majority of cases this is not necessary.

Wherever the compiler is able to infer the type for a constant or variable, type aliases should not be used, resulting in more compact code.  

**Preferred:**
```swift
let message = "Click the button"
var currentBounds = computeViewBounds()
```

**Not Preferred:**
```swift
let message: String = "Click the button"
var currentBounds: CGRect = computeViewBounds()
```

**NOTE**: As a result, descriptive variable and constant names are even more important than before.

## Type Choice

When programming in Swift, always use Swift's native types when available. Swift offers bridging to Objective-C so you can still use the full set of methods as needed.

**Preferred:**
```swift
let width = 120.0                                           //Double
let widthString = width.bridgeToObjectiveC().stringValue    //String
```

**Not Preferred:**
```swift
let width: NSNumber = 120.0                                 //NSNumber
let widthString: NSString = width.stringValue               //NSString
```

In Sprite Kit code, use `CGFloat` if it make the code more succinct by avoiding too many conversions.


## Smiley Face

Smiley faces are a very prominent style feature of the raywenderlich.com site!  It is very important to have the correct smile signifying the immense amount of happiness and excitement for the coding topic.  The end square bracket is used because it represents the largest smile able to be captured using ASCII art.  A half-hearted smile is represented if an end parenthesis is used, and thus not preferred.

**Preferred:**
```
:]
```

**Not Preferred:**
```
:)
```  
