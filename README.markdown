# The Official Teamwork.com iOS development Guide
As based on the [raywenderlich.com Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)

## Table of Contents

* [Our Aims](#our-aims)
* [Correctness](#correctness)
* [Naming](#naming)
  * [Prose](#prose)
  * [Delegates](#delegates)
  * [Use Type Inferred Context](#use-type-inferred-context)
  * [Generics](#generics)
  * [Class Prefixes](#class-prefixes)
  * [Language](#language)
* [Code Organization](#code-organization)
  * [Protocol Conformance](#protocol-conformance)
  * [Unused Code](#unused-code)
  * [Minimal Imports](#minimal-imports)
* [Spacing](#spacing)
* [Comments](#comments)
* [Classes and Structures](#classes-and-structures)
  * [Use of Self](#use-of-self)
  * [Protocol Conformance](#protocol-conformance)
  * [Computed Properties](#computed-properties)
  * [Final](#final)
* [Function Declarations](#function-declarations)
* [Closure Expressions](#closure-expressions)
* [Types](#types)
  * [Constants](#constants)
  * [Static Methods and Variable Type Properties](#static-methods-and-variable-type-properties)
  * [Optionals](#optionals)
  * [Lazy Initialization](#lazy-initialization)
  * [Type Inference](#type-inference)
  * [Syntactic Sugar](#syntactic-sugar)
* [Functions vs Methods](#functions-vs-methods)
* [Memory Management](#memory-management)
  * [Extending Lifetime](#extending-lifetime)
* [Access Control](#access-control)
* [Control Flow](#control-flow)
* [Comparisons](#comparisons)
* [Golden Path](#golden-path)
  * [Failing Guards](#failing-guards)
* [Semicolons](#semicolons)
* [Parentheses](#parentheses)
* [Deprecated](#deprecated)
* [Linting](#linting)
* [Organization and Bundle Identifier](#organization-and-bundle-identifier)
* [Localisation](#localisation)
* [Colors](#colours)
* [Unit Tests](#unit-tests)
* [Copyright Statement](#copyright-statement)
* [References](#references)


## Our Aims

Writing code that is easy to read and easy to understand is our number one aim.  It's often tempting to write something that is intellectually satisfying, something that makes use of esoteric features in the language, something that makes us feel like we have full mastery of our craft.  But that's not what this team is about.  We need to think about the people coming after us.  If a new dev can come in, read through the code in a function and straight away have a good idea of what's going on (without having to work hard to build up a mental image/model ), then it's worked and you can feel proud of what you've created.

A few common rules-of-thumb will help produce code that's easy to read and understand.  ( We'll cover these in more detail throughout the document )

+ Name things well.
+ Keep functions short
+ Functions that perform some operation, should do one thing only.
+ If you need to do multiple operations, separate out each behaviour into a single responsibility and group them instead.
+ Be careful of inline blocks.  Use them where appropriate, they're brilliant.  But always pause to see if the code would need less explanation, and provide better direction to the follow-on dev, by using a named function.




## Correctness

Strive to make your code compile without warnings. This rule informs many style decisions such as using `#selector` types instead of string literals.

## Naming

Descriptive and consistent naming makes software easier to read and understand. Use the Swift naming conventions described in the [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/). Some key takeaways include:

- strive for clarity at the call site
  - for example, a function name should read well and make things clearer wherever it's used.
- prioritize clarity and simplicity over brevity
- use [camel case](https://en.wikipedia.org/wiki/Camel_case) (not [snake case](https://en.wikipedia.org/wiki/Snake_case))
  - e.g: `taskTitle` rather than `task_title`
- use uppercase for types (and protocols), lowercase for everything else
- include all needed words while omitting needless words
  - for example don't repeat words.
- using names based on roles, not types
  - e.g: `taskTitle` rather than `aString`
- sometimes it may be necessary to compensate for weak type information.
  - e.g: when the type is Any or NSObject precede each weakly typed param with a noun describing its role. That is, use [Hungarian Notation](https://en.wikipedia.org/wiki/Hungarian_notation)
- striving for fluent usage
  - e.g: Prefer method and function names that make use sites form grammatical English phrases.
- begin factory methods with `make`
  - e.g: `makeGetAllProjectInteractor` rather than `initGetAllProjectInteractor` or `createGetAllProjectInteractor`
- name methods for their side effects
  - verb methods follow the -ed, -ing rule for the non-mutating version.  E.g: mutating: `sort()`, non-mutating: `x.sorted()`
  - noun methods follow the formX rule for the mutating version.  E.g.    E.g: mutating: `union(z)`, non-mutating: `formUnion(z)`
  - boolean types should read like assertions
  - protocols that describe _what something is_ should read as nouns
  - protocols that describe _a capability_ should end in _-able_ or _-ible_
- use terms that don't surprise experts or confuse beginners
- generally avoid abbreviations
- use precedent for names - if there's a well known name use it, don't come up with a new term just for the sake of it.
- prefer methods and properties to free (or global) functions.
- case for acronyms and initialisms should be uniformly up or down
- use the same base name for methods that share the same meaning
- avoid overloads based purely on return type. Avoid using [Covariant Returns](https://en.wikipedia.org/wiki/Covariant_return_type) which are allowed in Swift.
- choose good parameter names that serve as documentation
- label closure and tuple parameters
  - e.g.:

Instead of:
```swift
func makeLocation() -> (Float, Float) {
   // ... 
}
```
do:
```swift
func makeLocation() -> (latitude: Float, longitude: Float) {
    // ...
}
```

- take advantage of default parameters

### Lists of items

When creating the screen for a collection of items we need to think carefully about how we plan to name each object. Simply using the term "list" could cause confusion down the line with items like a tasklist which is already predefined within the context of Projects and a list of tasklists, which is something we will have to implement within the project ourselves.

The conclusion to this was that anytime we are creating an object which will have a list of items, we are going to use the term "Collection" for that object. eg. `TasklistCollection`, `ProjectCollection`

That way, we are not overlapping with the list term defined within Projects and don't end up with an object that looks like `TasklistList`, it would be `TasklistCollection` instead.

### Prose

When referring to methods in prose (in developer documentation), being unambiguous is critical. To refer to a method name, use the simplest form possible.

1. Write the method name with no parameters.  **Example:** Next, you need to call the method `addTarget`.
2. Write the method name with argument labels.  **Example:** Next, you need to call the method `addTarget(_:action:)`.
3. Write the full method name with argument labels and types. **Example:** Next, you need to call the method `addTarget(_: Any?, action: Selector?)`.

For the above example using `UIGestureRecognizer`, 1 is unambiguous and preferred.

**Pro Tip:** You can use Xcode's jump bar to lookup methods with argument labels.

![Methods in Xcode jump bar](screens/xcode-jump-bar.png)


### Class Prefixes

Swift types are automatically namespaced by the module that contains them and you should not add a class prefix such as TW. If two names from different modules collide you can disambiguate by prefixing the type name with the module name. However, only specify the module name when there is possibility for confusion which should be rare.

```swift
import SomeModule

let myClass = MyModule.UsefulClass()
```

### Delegates

When creating custom delegate methods, an unnamed first parameter should be the delegate source. (UIKit contains numerous examples of this.)

**Preferred:**
```swift
func namePickerView(_ namePickerView: NamePickerView, didSelectName name: String)
func namePickerViewShouldReload(_ namePickerView: NamePickerView) -> Bool
```

**Not Preferred:**
```swift
func didSelectName(namePicker: NamePickerViewController, name: String)
func namePickerShouldReload() -> Bool
```

### Use Type Inferred Context

Use compiler inferred context to write shorter, clear code.  (Also see [Type Inference](#type-inference).)

**Preferred:**
```swift
let selector = #selector(viewDidLoad)
view.backgroundColor = .red
let toView = context.view(forKey: .to)
let view = UIView(frame: .zero)
```

**Not Preferred:**
```swift
let selector = #selector(ViewController.viewDidLoad)
view.backgroundColor = UIColor.red
let toView = context.view(forKey: UITransitionContextViewKey.to)
let view = UIView(frame: CGRect.zero)
```

### Generics

Generic type parameters should be descriptive, upper camel case names. When a type name doesn't have a meaningful relationship or role, use a traditional single uppercase letter such as `T`, `U`, or `V`.  But really, in most cases it should be possible to come up with something better than those.

**Preferred:**
```swift
struct Stack<Element> { ... }
func write<Target: OutputStream>(to target: inout Target)
func swap<T>(_ a: inout T, _ b: inout T)
```

**Not Preferred:**
```swift
struct Stack<T> { ... }
func write<target: OutputStream>(to target: inout target)
func swap<Thing>(_ a: inout Thing, _ b: inout Thing)
```

### Language

Use US English spelling to match Apple's API.

**Preferred:**
```swift
let color = "red"
```

**Not Preferred:**
```swift
let colour = "red"
```

## Code Organization

Use extensions to organize your code into logical blocks of functionality. Each extension should be set off with a `// MARK: -` comment to keep things well-organized.

### Protocol Conformance

In particular, when adding protocol conformance to a model, prefer adding a separate extension for the protocol methods. This keeps the related methods grouped together with the protocol and can simplify instructions to add a protocol to a class with its associated methods.

**Preferred:**
```swift
class MyViewController: UIViewController {
  
  // class stuff here
}

// MARK: - UITableViewDataSource
extension MyViewController: UITableViewDataSource {
  
  // table view data source methods
}

// MARK: - UIScrollViewDelegate
extension MyViewController: UIScrollViewDelegate {
  
  // scroll view delegate methods
}
```

**Not Preferred:**
```swift
class MyViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate {
  
  // all methods
}
```

When putting protocol conformance for an object in an extension as previously mentioned, consider creating a folder and separated files to put its ancillary extensions therefore reducing the file of the initial component and facilitating looking for specific conformance.

The container folder should have the name of the component (E.g., MyViewController) and inside the folder the main component should be placed alongside with the extensions, which will be named using the following convention: `ComponentName+ConformanceName`.

**Preferred:**

```
[MyViewController] (folder)
|- MyViewController.swift  
|- MyViewController+SomeDelegate.swift  
|- MyViewController+SomeViewProtocol.swift  
|- MyViewController+UITableViewDelegate.swift  
|- MyViewController+Themable.swift  
|- MyViewController+StoryboardInstantiable.swift  
|- MyViewController+UITextViewDelegate.swift`
```

This way you can visually see all protocols a class implements from the file names inside that group.

Since the compiler does not allow you to re-declare protocol conformance in a derived class or extension, it is not always required to replicate the extension groups of the base class. This is especially true if the derived class is a terminal class and a small number of methods are being overridden. When to preserve the extension groups is left to the discretion of the author.

For UIKit view controllers, consider grouping lifecycle, custom accessors, and IBAction in separate class extensions.

### Unused Code

Unused (dead) code, including Xcode template code and placeholder comments should be removed.

**Preferred:**
```swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
  return Database.contacts.count
}
```

**Not Preferred:**
```swift
override func didReceiveMemoryWarning() {
  super.didReceiveMemoryWarning()
  // Dispose of any resources that can be recreated.
}

override func numberOfSections(in tableView: UITableView) -> Int {
  // #warning Incomplete implementation, return the number of sections
  return 1
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  // #warning Incomplete implementation, return the number of rows
  return Database.contacts.count
}

```
### Minimal Imports

Keep imports minimal. For example, don't import `UIKit` when importing `Foundation` will suffice.

## Spacing

* Indent using tabs characters - we're programmers, if we can't deal with the concept of something having variable values, get out now. The default size of a tab should be set to 4 spaces.  Be sure to set this preference in Xcode and in the Project settings as shown below:

![Xcode indent settings](screens/indentation.png)

* Method braces and other braces (`if`/`else`/`switch`/`while` etc.) always open on the same line as the statement but close on a new line.
* Tip: You can re-indent by selecting some code (or ⌘A to select all) and then Control-I (or Editor\Structure\Re-Indent in the menu). Some of the Xcode template code will have 4-space tabs hard coded, so this is a good way to fix that.

**Preferred:**
```swift
if user.isHappy {
 
  // Do something
} else {
  
  // Do something else
}
```

**Not Preferred:**
```swift
if user.isHappy
{
 
  // Do something
}
else {
 
  // Do something else
}
```

* There should be three blank lines between methods to help with separatation, visual clarity and organization. Lines with similar or connected behaviour should not be separated by empty newlines.  Whitespace within methods should separate and group functionality, but having too many sections in a method often means you should refactor into several methods.

**Preferred:**
```swift
func funStuff() {
  
  var thing = makeThing()
  doThis(thing)
  doThat(thing)

  var otherThing = somethingElse()
  blah(otherThing)
}



func second(){

  hello()
}



func third(){

  there()
}


```

**Not Preferred:**
```swift
func funStuff() {
  
  var thing = makeThing()

  doThis(thing)

  doThat(thing)

  var otherThing = somethingElse()

  blah(otherThing)
}

func second(){

  hello()
}

func third(){

  there()
}

```



* Colons always have no space on the left and one space on the right. Exceptions are the ternary operator `? :`, empty dictionary `[:]` and `#selector` syntax for unnamed parameters `(_:)`.

**Preferred:**
```swift
class TestDatabase: Database {
  
  var data: [String: CGFloat] = ["A": 1.2, "B": 3.2]
}
```

**Not Preferred:**
```swift
class TestDatabase : Database {
  
  var data :[String:CGFloat] = ["A" : 1.2, "B":3.2]
}
```

* Long lines should aim to be wrapped at around 70 characters. Although a hard limit is intentionally not specified.

* Avoid trailing whitespaces at the ends of lines.

* Add a single newline character at the end of each file.

## Comments

When they are needed, use comments to explain **why** a particular piece of code does something. Comments must be kept up-to-date or deleted.

Avoid block comments inline with code, as the code should be as self-documenting as possible. *Exception: This does not apply to those comments used to generate documentation.*

The aim for comments though, is to write simple, clear code that doesn't require much explaintion.  If something multiple complex pieces of behaviour are being performed, break them out into separate functions with good clear names.

Most properties should have a comment.  Use /// for property comments as it'll show up in contextual help. 

Multiline comments can be set with `/* */` or `///`, but we prefer the later because that’s the format of the template created by the `⌥⌘/` shortcut. Note that even when you may have to extend the template, it does most of the work, specially for complex methods.

## Classes and Structures

### Which one to use?

Remember, structs have [value semantics](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-XID_144). Use structs for things that do not have an identity. An array that contains [a, b, c] is really the same as another array that contains [a, b, c] and they are completely interchangeable. It doesn't matter whether you use the first array or the second, because they represent the exact same thing. That's why arrays are structs.

Classes have [reference semantics](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-XID_145). Use classes for things that do have an identity or a specific life cycle. You would model a person as a class because two person objects are two different things. Just because two people have the same name and birthdate, doesn't mean they are the same person. But the person's birthdate would be a struct because a date of 3 March 1950 is the same as any other date object for 3 March 1950. The date itself doesn't have an identity.

Sometimes, things should be structs but need to conform to `AnyObject` or are historically modeled as classes already (`NSDate`, `NSSet`). Try to follow these guidelines as closely as possible.

### Example definition

Here's an example of a well-styled class definition:

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

  override func area() -> Double {

    return Double.pi * radius * radius
  }
}

extension Circle: CustomStringConvertible {

  var description: String {

    return "Circle area = \(area())"
  }
}
```

The example above demonstrates the following style guidelines:

 + Specify types for properties, variables, constants, argument declarations and other statements with a space after the colon but not before, e.g. `x: Int`, and `Circle: Shape`.
 + Define multiple variables and structures on a single line if they share a common purpose / context.
 + Indent getter and setter definitions and property observers.
 + Don't add modifiers such as `internal` when they're already the default. Similarly, don't repeat the access modifier when overriding a method.
 + Organize extra functionality (e.g. printing) in extensions.
 
### Use of Self

For conciseness, avoid using `self` since Swift does not require it to access an object's properties or invoke its methods.

Use self only when required by the compiler (in `@escaping` closures, or in initializers to disambiguate properties from arguments). In other words, if it compiles without `self` then omit it.


### Computed Properties

For conciseness, if a computed property is read-only, omit the get clause. The get clause is required only when a set clause is provided.

If a computed property is expensive, don't do it as a computed property at all  (unless there's a huge mitigating factor.)

**Preferred:**
```swift
var diameter: Double {

  return radius * 2
}
```

**Not Preferred:**
```swift
var diameter: Double {

  get {

    return radius * 2
  }
}
```

### Property Observers

When writing didSets they can be a few lines long if they are related to setting up a component and they don't encapsulate logic. If they need to be longer write the logic inside a private method or inside an external component.

### Final

Mark a class as final unless it needs to be subclassed.


## Function Declarations

Keep short function declarations on one line including the opening brace:

```swift
func reticulateSplines(spline: [Double]) -> Bool {

  // reticulate code goes here
}
```

For functions with long signatures, add line breaks at appropriate points and add an extra indent on subsequent lines:

```swift
func reticulateSplines(spline: [Double], adjustmentFactor: Double,
    translateConstant: Int, comment: String) -> Bool {

  // reticulate code goes here
}
```

When declaring a new function, we recommend using markup to create a richly formatted 'Quick Help' describing the function, it's parameters and it's return object. This way, other users simply have to select the option key and select the function in any context to see the information about the function with it's intended use.

You can create a 'Quick Help' declaration format for your function using the hotkey 'OPT+CMD+/'. You may also check [Apple's documentation](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/SymbolDocumentation.html) for more details.

```
    /// Finds and return the range of the content inside some enclosing keys, if any. If there are more than one enclosing content it will return the first one.
    ///
    /// - Parameters:
    ///   - startKey: the start key for the enclosing content
    ///   - endKey: the end key for the enclosing content
    /// - Returns: the range of the content enclosed by the startKey and endKey
    func rangeForEnclosingKeys(startKey: String, endKey: String) -> Range<String.Index>? { }
```

## Closure Expressions

Use trailing closure syntax if there's a single closure expression parameter at the end of the argument list. Where possible try to avoid multiple inline closures in a single function call. It's too hard to read. Separate them out into well named functions.

**Preferred:**
```swift
UIView.animate(withDuration: 1.0) {

  self.myView.alpha = 0
}

UIView.animate(withDuration: 1.0, animations: performRotation, completion: finishRotation)
```

**Not Preferred:**
```swift
UIView.animate(withDuration: 1.0, animations: {

  self.myView.alpha = 0
})

UIView.animate(withDuration: 1.0, animations: {

  self.myView.alpha = 0
}) { f in

  self.myView.removeFromSuperview()
}
```

For single-expression closures where the context is clear, use implicit returns:

```swift
attendeeList.sort { a, b in

  a > b
}
```

Chained methods using trailing closures should only ever be used if it's clear and easy to read.

```swift
let value = numbers
  .map { $0 * 2} 
  .filter { $0 > 50 }
  .map { $0 + 10 }
```

## Types

Always use Swift's native types when available. Swift offers bridging to Objective-C so you can still use the full set of methods as needed.

**Preferred:**
```swift
let width = 120.0                                    // Double
let widthString = (width as NSNumber).stringValue    // String
```

**Not Preferred:**
```swift
let width: NSNumber = 120.0                          // NSNumber
let widthString: NSString = width.stringValue        // NSString
```

In Sprite Kit code, use `CGFloat` if it makes the code more succinct by avoiding too many conversions.

### Constants

Constants are defined using the `let` keyword, and variables with the `var` keyword. Always use `let` instead of `var` if the value of the variable will not change.

**Tip:** A good technique is to define everything using `let` and only change it to `var` if the compiler complains!

You can define constants on a type rather than on an instance of that type using type properties. To declare a type property as a constant simply use `static let`. Type properties declared in this way are generally preferred over global constants because they are easier to distinguish from instance properties. Example:

**Preferred:**
```swift
enum Math {

  static let e = 2.718281828459045235360287
  static let root2 = 1.41421356237309504880168872
}

let hypotenuse = side * Math.root2

```
**Note:** The advantage of using a case-less enumeration is that it can't accidentally be instantiated and works as a pure namespace.

**Not Preferred:**
```swift
let e = 2.718281828459045235360287  // pollutes global namespace
let root2 = 1.41421356237309504880168872

let hypotenuse = side * root2 // what is root2?
```

### Static Methods and Variable Type Properties

Static methods and type properties work similarly to global functions and global variables and should be used sparingly. They are useful when functionality is scoped to a particular type or when Objective-C interoperability is required.

### Optionals

Declare variables and function return types as optional with `?` where a nil value is acceptable.

Use implicitly unwrapped types declared with `!` only for instance variables that you know will be initialized later before use, such as subviews that will be set up in `viewDidLoad`.  Avoid using implicit unwrapping anywhere else.

When accessing an optional value, use optional chaining if the value is only accessed once or if there are many optionals in the chain:

```swift
self.textContainer?.textLabel?.setNeedsDisplay()
```

Use optional binding when it's more convenient to unwrap once and perform multiple operations:

```swift
if let textContainer = self.textContainer {

  // do many things with textContainer
}
```

When naming optional variables and properties, avoid naming them like `optionalString` or `maybeView` since their optional-ness is already in the type declaration.

For optional binding, shadow the original name when appropriate rather than using names like `unwrappedView` or `actualLabel`.

**Preferred:**
```swift
var subview: UIView?
var volume: Double?

// later on...
if let subview = subview, let volume = volume {

  // do something with unwrapped subview and volume
}
```

**Not Preferred:**
```swift
var optionalSubview: UIView?
var volume: Double?

if let unwrappedSubview = optionalSubview {

  if let realVolume = volume {

    // do something with unwrappedSubview and realVolume
  }
}
```

### Lazy Initialization

Consider using lazy initialization for finer grain control over object lifetime. This is especially true for `UIViewController` that loads views lazily. You can either use a closure that is immediately called `{ }()` or call a private factory method. Example:

```swift
lazy var locationManager: CLLocationManager = self.makeLocationManager()

private func makeLocationManager() -> CLLocationManager {

  let manager = CLLocationManager()
  manager.desiredAccuracy = kCLLocationAccuracyBest
  manager.delegate = self
  manager.requestAlwaysAuthorization()
  return manager
}
```

**Notes:**
  - `[unowned self]` is not required here. A retain cycle is not created.
  - Location manager has a side-effect for popping up UI to ask the user for permission so fine grain control makes sense here.


### Type Inference

Prefer compact code and let the compiler infer the type for constants or variables of single instances. Type inference is also appropriate for small (non-empty) arrays and dictionaries. When required, specify the specific type such as `CGFloat` or `Int16`.

**Preferred:**
```swift
let message = "Click the button"
let currentBounds = computeViewBounds()
var names = ["Mic", "Sam", "Christine"]
let maximumWidth: CGFloat = 106.5
```

**Not Preferred:**
```swift
let message: String = "Click the button"
let currentBounds: CGRect = computeViewBounds()
let names = [String]()
```

#### Type Annotation for Empty Arrays and Dictionaries

For empty arrays and dictionaries, use type annotation. (For an array or dictionary assigned to a large, multi-line literal, use type annotation.)

**Preferred:**
```swift
var names: [String] = []
var lookup: [String: Int] = [:]
```

**Not Preferred:**
```swift
var names = [String]()
var lookup = [String: Int]()
```

**NOTE**: Following this guideline means picking descriptive names is even more important than before.


### Syntactic Sugar

Prefer the shortcut versions of type declarations over the full generics syntax.

**Preferred:**
```swift
var deviceModels: [String]
var employees: [Int: String]
var faxNumber: Int?
```

**Not Preferred:**
```swift
var deviceModels: Array<String>
var employees: Dictionary<Int, String>
var faxNumber: Optional<Int>
```

When working with elements related to **Viper** architecture, especially when variable names are generic (e.g., presenter, router, dataManager, view etc), it's recommended to include the type or protocol conformance in order to facilitate understanding and provide more context. 

**Preferred:**
```swift
let dataManager: ProjectApiProtocol = MockedApi()
```

**Not Preferred:**
```swift
let dataManager = MockedApi()
```

**Preferred:**
```swift
let repositoryToDomainMapper: AnyMapper<[ProjectEntity], [Project]> = AnyMapper(ProjectCollectionRepositoryToDomainMapper())
```

**Not Preferred:**
```swift
let repositoryToDomainMapper = AnyMapper(ProjectCollectionRepositoryToDomainMapper())
```

## Functions vs Methods

Free functions, which aren't attached to a class or type, should be used sparingly. When possible, prefer to use a method instead of a free function. This aids in readability and discoverability.

Free functions are most appropriate when they aren't associated with any particular type or instance.

**Preferred**
```swift
let sorted = items.mergeSorted()  // easily discoverable
rocket.launch()  // acts on the model
```

**Not Preferred**
```swift
let sorted = mergeSort(items)  // hard to discover
launch(&rocket)
```

## Memory Management

Code (even non-production, tutorial demo code) should not create reference cycles. Analyze your object graph and prevent strong cycles with `weak` and `unowned` references. Alternatively, use value types (`struct`, `enum`) to prevent cycles altogether.

### Extending object lifetime

Extend object lifetime using the `[weak self]` and `guard let strongSelf = self else { return }` idiom. `[weak self]` is preferred to `[unowned self]` where it is not immediately obvious that `self` outlives the closure. Explicitly extending lifetime is preferred to optional unwrapping.

**Preferred**
```swift
resource.request().onComplete { [weak self] response in

  guard let strongSelf = self else {

    return
  }

  let model = strongSelf.updateModel(response)
  strongSelf.updateUI(model)
}
```

**Not Preferred**
```swift
// might crash if self is released before response returns
resource.request().onComplete { [unowned self] response in

  let model = self.updateModel(response)
  self.updateUI(model)
}
```

**Not Preferred**
```swift
// deallocate could happen between updating the model and updating UI
resource.request().onComplete { [weak self] response in

  let model = self?.updateModel(response)
  self?.updateUI(model)
}
```

As a *better* alternative to the weak self/strong self scenario, if we just need to capture some variables or objects, instead of addressing the whole self, we can use a capture list with the name of the vars needed.

**Preferred**
```swift
doSomethingAsync { [myCapturedVar] in

  print(myCapturedVar)
}
```

This way the closure doesn't capture self at all, but only the reference to the item it actually needs. The benefit is that we can avoid the somewhat "dangerous" unowned reference to self while also not having to deal with a weak optional self within the closure...

## Access Control

Using `private` and `fileprivate` appropriately, however, adds clarity and promotes encapsulation. Prefer `private` to `fileprivate` when possible. Using extensions may require you to use `fileprivate`.

Only explicitly use `open`, `public`, and `internal` when you require a full access control specification.

Use access control as the leading property specifier. The only things that should come before access control are the `static` specifier or attributes such as `@IBAction`, `@IBOutlet` and `@discardableResult`.

**Preferred:**
```swift
private let message = "Great Scott!"

class TimeMachine {  

  fileprivate dynamic lazy var fluxCapacitor = FluxCapacitor()
}
```

**Not Preferred:**
```swift
fileprivate let message = "Great Scott!"

class TimeMachine {  

  lazy dynamic fileprivate var fluxCapacitor = FluxCapacitor()
}
```

IBOutlets  should always be marked as private and weak.
IBActions  should always be marked as private.

**Preferred:**
```swift
@IBOutlet private weak var butt: UIButton!

@IBAction private func buttonTouched(_ sender: Any) {

   print("click")
}
```

**Not Preferred:**
```swift
@IBOutlet var butt: UIButton!

@IBAction func buttonTouched(_ sender: Any) {

   print("click")
}
```





## Control Flow

Prefer the `for-in` style of `for` loop over the `while-condition-increment` style.

**Preferred:**
```swift
for _ in 0..<3 {

  print("Hello three times")
}

for (index, person) in attendeeList.enumerated() {

  print("\(person) is at position #\(index)")
}

for index in stride(from: 0, to: items.count, by: 2) {

  print(index)
}

for index in (0...3).reversed() {

  print(index)
}
```

**Not Preferred:**
```swift
var i = 0
while i < 3 {

  print("Hello three times")
  i += 1
}


var i = 0
while i < attendeeList.count {

  let person = attendeeList[i]
  print("\(person) is at position #\(i)")
  i += 1
}
```

## Comparisons

Returning the result of Boolean comparisons:  if the bool is non-optional, simply return the bool.  If it's optional then return the comparison against true or false.

**Preferred:**
```swift

var isDone = false
:
:
return isDone
```

**Not Preferred:**
```swift
var isDone: Bool?
:
:
return isDone == true
```



## Golden Path

When coding with conditionals, the left-hand margin of the code should be the "golden" or "happy" path. That is, don't nest `if` statements. Multiple return statements are OK. The `guard` statement is built for this.

**Preferred:**
```swift
func computeFFT(context: Context?, inputData: InputData?) throws -> Frequencies {

  guard let context = context else {
    throw FFTError.noContext
  }
  guard let inputData = inputData else {
    throw FFTError.noInputData
  }

  // use context and input to compute the frequencies
  return frequencies
}
```

**Not Preferred:**
```swift
func computeFFT(context: Context?, inputData: InputData?) throws -> Frequencies {

  if let context = context {

    if let inputData = inputData {

      // use context and input to compute the frequencies

      return frequencies
    } else {

      throw FFTError.noInputData
    }

  } else {

    throw FFTError.noContext
  }
}
```

When multiple optionals are unwrapped either with `guard` or `if let`, minimize nesting by using the compound version when possible. Example:

**Preferred:**
```swift
guard let number1 = number1,
      let number2 = number2,
      let number3 = number3 else {

  fatalError("impossible")
}

// do something with numbers
```

**Not Preferred:**
```swift
if let number1 = number1 {

  if let number2 = number2 {

    if let number3 = number3 {

      // do something with numbers
    } else {

      fatalError("impossible")
    }

  } else {

    fatalError("impossible")
  }

} else {

  fatalError("impossible")
}
```

### Failing Guards

Guard statements are required to exit in some way. Generally, this should be simple one line statement such as `return`, `throw`, `break`, `continue`, and `fatalError()`. Large code blocks should be avoided. If cleanup code is required for multiple exit points, consider using a `defer` block to avoid cleanup code duplication.

### Use of returns

On facing a method, we expect to find at the top the `guard` to check for the execution conditions, followed by the method's body and finishing with a return when requested. This simple flow helps on code readability. 

Whenever possible use only one return command for method/function. This does not include the use of one or more `guard` for an early return on checking execution conditions.

## Semicolons

Don't.  Just don't.


**Preferred:**
```swift
let swift = "not a scripting language"
```

**Not Preferred:**
```swift
let swift = "not a scripting language";
```

**NOTE**: Swift is very different from JavaScript, where omitting semicolons is [generally considered unsafe](http://stackoverflow.com/questions/444080/do-you-recommend-using-semicolons-after-every-statement-in-javascript)

## Parentheses

Parentheses around conditionals are not required and should be omitted.

**Preferred:**
```swift
if name == "Hello" {

  print("World")
}
```

**Not Preferred:**
```swift
if (name == "Hello") {

  print("World")
}
```

In larger expressions, optional parentheses can sometimes make code read more clearly.

**Preferred:**
```swift
let playerMark = (player == current ? "X" : "O")
```

## Deprecated

Sometimes there's code that will be refactored in the near future, so it may be interesting to mark vars, methods etc with **@available**. 

This way we can get warnings when compiling and when trying to use/access those 'deprecated' code...It's also useful as a better reminder than **//TODO**. If you try to use something marked as deprecated you'll get a warning.

**Preferred:**
```swift
@available(*, deprecated, message: "This has to be refactored, it shouldn't be used")
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {

            titleLabel.text = title
        }
    }
```

If we try to access titleLabel (a deprecated var) e.g.
```
titleLabel.font = font   
```

The compiler will show a warning ---> 'titleLabel' is deprecated: This has to be refactored, it shouldn't be used'


**Not Preferred:**
```swift
/// TODO - Refactor some day, please don't use it! 
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {

            titleLabel.text = title
        }
    }
```

## Linting

 We use SwiftLint to lint our projects so we guarantee our guidelines are being enforced during development. 
 
 To install SwiftLint we use CocoaPods, since it's a easy way to install and maintain versioning on this tool. To do so just add SwiftLint as a pod in the project's Podfile (`pod 'SwiftLint'`) and execute the `pod install` command. You also have to include a build phase bash script:
 ```
 "${PODS_ROOT}/SwiftLint/swiftlint"
 ```
 
 After the installation is complete include the `.swiftlint.yml` file at the root folder of the project. Be sure to include `.swiftlint.yml` in to source versioning, so that everybody has the same set of rules (including CI/CD).
 
 For more details on how SwiftLint works and how to install it please [check this](https://github.com/realm/SwiftLint).
 
 This is a sample of the `.swiftlint.yml` file to be used in all projects.
```yaml
# All rules: https://github.com/realm/SwiftLint/blob/master/Rules.md#mark
 disabled_rules: # rule identifiers to exclude from running
- shorthand_operator        # Prefer shorthand operators (+=, -=, *=, /=) over doing the operation and assigning
- trailing_whitespace
- file_header
- trailing_newline
- todo
 opt_in_rules: # some rules are only opt-in
- empty_count                                   # Prefer checking isEmpty over comparing count to zero
- private_outlet                                # IBOutlets should be private to avoid leaking UIKit to higher layers.
- file_header
- modifier_order                                # Modifier order should be consistent.
- multiline_arguments                           # Arguments should be either on the same line, or one per line.
- number_separator                              # Underscores should be used as thousand separator in large decimal numbers
- operator_usage_whitespace                     # Operators should be surrounded by a single whitespace when they are being used.
- operator_whitespace                           # Operators should be surrounded by a single whitespace when defining them.
- prohibited_super_call                         # Some methods should not call super
- overridden_super_call                         # Some overridden methods should always call super
- vertical_parameter_alignment_on_call          # Function parameters should be aligned vertically if they're in multiple lines in a method call.
- array_init                                    # Prefer using Array(seq) over seq.map { $0 } to convert a sequence into an Array.
- attributes                                    # Attributes should be on their own lines in functions and types, but on the same line as variables and imports.
- closure_end_indentation                       # Closure end should have the same indentation as the line that started it.
- closure_spacing                               # Closure expressions should have a single space inside each brace.
- contains_over_first_not_nil                   # Prefer contains over first(where:) != nil
- empty_string                                  # Prefer checking isEmpty over comparing string to an empty string literal.
- explicit_init                                 # Explicitly calling .init() should be avoided.
- extension_access_modifier                     # Prefer to use extension access modifiers
- fallthrough                                   # Fallthrough should be avoided.
- fatal_error_message                           # A fatalError call should have a message.
- first_where                                   # Prefer using .first(where:) over .filter { }.first in collections.
- force_unwrapping                              # Force unwrapping should be avoided.
- function_default_parameter_at_end             # Prefer to locate parameters with defaults toward the end of the parameter list.
- implicit_return                               # Prefer implicit returns in closures.
- implicitly_unwrapped_optional                 # Implicitly unwrapped optionals should be avoided when possible.
- joined_default_parameter                      # Discouraged explicit usage of the default separator.
- literal_expression_end_indentation            # Array and dictionary literal end should have the same indentation as the line that started it.
- lower_acl_than_parent                         # Ensure definitions have a lower access control level than their enclosing parent
- multiline_function_chains                     # Chained function calls should be either on the same line, or one per line.
- multiline_parameters                          # Functions and methods parameters should be either on the same line, or one per line.
- pattern_matching_keywords                     # Combine multiple pattern matching bindings by moving keywords out of tuples.
- prefixed_toplevel_constant                    # Top-level constants should be prefixed by k
- private_action                                # IBActions should be private.
- redundant_nil_coalescing                      # nil coalescing operator is only evaluated if the lhs is nil, coalescing operator with nil as rhs is redundant
- sorted_first_last                             # Prefer using min() or max() over sorted().first or sorted().last
- trailing_closure                              # Trailing closure syntax should be used whenever possible.
- unavailable_function                          # Unimplemented functions should be marked as unavailable.
- unneeded_parentheses_in_closure_argument      # Parentheses are not needed when declaring closure arguments.
- yoda_condition                                # The variable should be placed on the left, the constant on the right of a comparison operator.
- nimble_operator                               # Prefer Nimble operator overloads over free matcher functions.
- quick_discouraged_call                        # Discouraged call inside 'describe' and/or 'context' block.
- quick_discouraged_focused_test                # Discouraged focused test. Other tests won't run while this one is focused.
- quick_discouraged_pending_test                # Discouraged pending test. This test won't run while it's marked as pending.
- required_enum_case                            # Enums conforming to a specified protocol must implement a specific case(s).
- single_test_class                             # Test files should contain a single QuickSpec or XCTestCase class.
 excluded: # paths to ignore during linting. Takes precedence over `included`.
- Pods
 # configurable rules can be customized from this configuration file
 line_length:
    warning: 140
    ignores_comments: true
 nesting:
    type_level: 2
 vertical_whitespace: 1
force_cast: warning
force_try: warning
force_unwrapping: warning
 file_length:
    warning: 600
    ignore_comment_only_lines: true
 function_body_length: 40
 function_parameter_count:
    warning: 6
 type_body_length: 600
 identifier_name:
    min_length: # only min_length
        warning: 3 # only error
    excluded: # excluded via string array
        - id
 reporter: "xcode" # reporter type (xcode, json, csv, checkstyle, junit, html, emoji)
 custom_rules:
    more_than_one_variable_declaration:
        regex: '^(let|var) \w+,'
        message: "Don't put more than one declaration in the same line."
        severity: error
```

## Organization and Bundle Identifier

Where an Xcode project is involved, the organization should be set to `Teamwork.com` and the Bundle Identifier set to `com.teamwork.XXXName` where `XXXName` is the name of the project.

![Xcode Project settings](screens/project_settings.png)


## Localisation

+ Any user visible text, defined in the app, must always be localisable.  
+ All localisable strings should use a key that isn't just the original English text.  That way if the Englist text is adjust it won't break the matching translations.  Plus the same text may need to be localised differently in different situations - which wouldn't be possible if the key is the original text.
+ Localised text should be added as an extension on String.
+ Always provide useful instructions for the `comment` property of `NSLocalizedString()`.  Don't just repeat the original text.  If necessary also indiciate to the localiser where/what type of thing the text will appear in.  (Button, window title etc...)

**Preferred:**
```swift
let blahTitle =  NSLocalizedString("blah", comment:"a blah title to use in modal screens")
```

**Not Preferred:**
```swift
if (name == "Hello") {

  print("World")
}
```


## Colors

+ Always use the american spelling of color.  Never Colour.
+ Aim to never use colours built with specific colour components directly in code.  Name them and put them in an exention on UIColor instead.
+ Prefer `rgbValue/255` over `fractionalRGBValue`.
+ Prefer compiler inference.  No need to write `UIColor.red` -> `.red` is enough.  


**Preferred:**
```swift
extension UIColor {
  
  static var messageColor = UIColor(red: 31/255.0, green: 33/255.0, blue: 36/255.0, alpha: 1)
}

messageView.color = .messageColor
```

**Not Preferred:**
```swift
messageView.color = UIColor(red: 0.121568627, green: 0.129411765, blue: 0.141176471, alpha: 1)
```

## Unit Tests

When writing new code, it should have a considerable amount of tests backing those additions. There is no code coverage requisite yet for this.

It's been agreed that unit tests should be written using the Quick/Nimble framework because of the increased readability over `XCTest`. The methods `describe`, `context` and `it` should be used accordingly to build the test specs in a manner that is easy to read, like english, such as:
```swift
describe("Given a set of strings") {
    context("When comparing two strings that are equal") {
        it("Then return true") {
            /* Test code goes here */
        }
    }
}
```

When writing your tests use force unwraps (`!`) to unwrap optional values when needed since safely unwraping (`?` or using `guard`/`if` statements) may give us false positives (not fail a test when it should). The only acceptable case to not forcibly unwrap a variable is when it is being compared to another value using the `expect` method, since if it is `nil` the test will fail with a nice test error message instead of a stacktrace error. E.g.
```swift
struct SomeStruct {
    let name: String
}

let optionalValue: SomeStruct? = SomeStruct(name: "test")
expect(optionalValue?.name).to(equal("test")) // This will fail with a message saying value was nil if optionalValue is nil rather than blowing everything up like using !
```
Please notice that one of the sides of the comparison must not be optional, otherwise we may end up with a false positive, e.g.
```swift
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"

struct SomeStruct {
    let date: Date
}

let optionalValue: SomeStruct? = SomeStruct(date: Date())
expect(optionalValue?.date).to(equal(dateFormatter.date(from: "2018-06-20")!)) // Notice than one of the sides must be forcibly unwraped otherwise we might be comparing two nil objects, which might not be what we want. Force unwrap your test values (the desired value), not the values to be tested
```

## Copyright Statement

The following copyright statement should be included at the top of every source
file:

```swift
/// Copyright (c) 2017 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
```


## References

* [The Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
* [The Swift Programming Language](https://developer.apple.com/library/prerelease/ios/documentation/swift/conceptual/swift_programming_language/index.html)
* [Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/index.html)
* [Swift Standard Library Reference](https://developer.apple.com/library/prerelease/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html)
