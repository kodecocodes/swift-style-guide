## Cocoapods

Use only specific pod versions in Podfile

**Preferred:**
```bash
pod 'FBAudienceNetwork', '= 4.0'
```
**Not Preferred:**
```bash
pod 'FBAudienceNetwork', '~> 4.0'
```
## Unit Tests

### Tear down

`XCTestCase` instances keep alive after test is finished until all test are passed: https://qualitycoding.org/teardown/
Therefore, state should be cleaned in `tearDown()` function.

**Preferred:**
```swift
class UserTests: XCTestCase {

    let sut: User!
    
    override func setUp() {
        super.setUp()
        self.sut = User()
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func testThat_UserDoSometing() {
        // use sut  
    }
}
```

**Not Preferred:**
```swift
class UserTests: XCTestCase {

    let sut = User()
    
    func testThat_UserDoSometing() {
        // use sut  
    }
}
```
**
