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

## Smiley Face

Smiley faces are a very prominent style feature of the raywenderlich.com site!  It is very important to have the correct smile signifying the immense amount of happiness and excitement for the coding topic.  The end square bracket is used because it represents the largest smile able to be captured using ascii art.  A half-hearted smile is represented if an end parenthesis is used, and thus not preferred.

**Preferred:**
```
:]
```

**Not Preferred:**
```
:)
```  



