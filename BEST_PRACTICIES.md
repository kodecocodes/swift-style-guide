## Table of Contents

* [Parameters Order](#parameters-order)

## Parameters Order

In general, all kinds of functions shouldn't have a long list of parameters. Usually, your aren't passing more then 3 parameters, but in rare cases it's necessary. For example, if a factory provides dependencies to all products, then factory init function will have a long list of parameters that contains all dependencies passed to all products. In such rare cases having predefined parameters order makes your code more structured and consistent, therefore, it helps you to read and understand code faster.

Prefer to use next parameters order:
 - Data
 - Dependencies
 - Closures

**Preferred**

```swift
// Example 1
init(pageSize: Int, networkService: NetworkServiceProtocol) { ... }

// Example 2
func load(_ reqest: NetworkRequestProtocol, completion: () -> Void) { .. }

// Example 3
func scheduleUpdate(forItems oldItems: [ItemProtocol], 
                    with newItems: [ItemProtocol], 
                    in collectionView: UICollectionView, 
                    updateItemsClosure: (_ updatedItems: [ItemProtocol]) -> Void, 
                    completion: () -> Void) { ... }
```

**Not Preferred**

```swift
// Example 1
init(networkService: NetworkServiceProtocol, pageSize: Int) { ... }

// Example 2
func load(completion: () -> Void, reqest: NetworkRequestProtocol) { .. }

// Example 3
func scheduleUpdate(forItems oldItems: [ItemProtocol], 
                    with newItems: [ItemProtocol], 
                    updateItemsClosure: (_ updatedItems: [ItemProtocol]) -> Void,
                    in collectionView: UICollectionView,
                    completion: () -> Void) { ... }
```
