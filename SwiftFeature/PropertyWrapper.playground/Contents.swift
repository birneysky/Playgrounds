import UIKit

/// refer to https://www.vadimbulavin.com/swift-5-property-wrappers/

struct ConsoleLogged<T> {
    private var value: T
    
    init(wrappedValue: T) {
        self.value = wrappedValue
    }
    
    var wrappedValue: T {
        get { value }
        set {
            value = newValue
            print("New Value is \(newValue)")
        }
    }
}

struct Bar {
    private  var _x = ConsoleLogged(wrappedValue: 0)
    
    var x: Int  {
        get { _x.wrappedValue }
        set { _x.wrappedValue  = newValue }
    }
}

@propertyWrapper
struct Logged<T> {
    private var value: T
    
    init(wrappedValue: T) {
        value = wrappedValue
    }
    
    var wrappedValue: T {
        get { value }
        set {
            value = newValue
            print("Logged New Value is \(newValue)")
        }
    }
}

struct Bar2 {
    @Logged var x = 3
}

/// The attribute @Logged is a syntactic sugar, which translates into the previous version of our code( ConsoleLogged<T>).

var bar = Bar()
bar.x = 2

var bar2 = Bar2()
bar2.x = 6
bar2.x = 7
bar2.x = 8


/// There are two requirements for a property wrapper type [1]:

/// - It must be defined with the attribute @propertyWrapper.
/// - It must have a wrappedValue property.

/// Here is how the simplest wrapper looks:

@propertyWrapper
struct Wrapper<T> {
    var wrappedValue: T
    
    /// It’s often useful to provide extra behavior in a property wrapper:
    func foo() {
        print("Foo")
    }
    
    /// >  A property wrapper may expose more API by defining a projectedValue property. There any no restrictions on the type of projectedValue.
     var projectedValue: Wrapper<T> { self }
}

/// We can now use the attribute @Wrapper at the property declaration site:

struct HasWrapper {
    @Wrapper var x: Int
    
    /// We can access the wrapper type by adding an underscore to the variable name:
    /// Here `_x` is an instance of `Wrapper<T>` ,hence we can call `foo()`
    /// However, calling it from the outside of HasWrapper will generate a compilation error:
    func foo() {
        _x.foo()
    }
    
    /// In summary, there are three ways to access a wrapper:
    func foo2() {
        print(x) ///  wrappedValue
        print(_x) ///  wrapper type self
        print($x) /// projectedValue
    }
}



let a = HasWrapper(x: 0)
/// a._x.foo()  ❌ `_x` is inaccessible due to 'private' protection level
/// The reason for that is that the synthesized wrapper has a private access control level. We can overcome this by using a projection.

/// Dollar sign is the syntactic sugar to access the wrapper’s projection:
a.$x.foo()
a.foo2()

/// We can pass a default value to the wrapper in two ways:
///
/// There is a difference between the two declarations:
/// - 1. The compiler implicitly uses `init(wrappedValue:)` to initialize x with 0.
/// - 2. The initializer is specified explicitly as a part of an attribute.
struct HasWrapperWithInitalValue {
    @Wrapper var x = 0 // 1
    @Wrapper(wrappedValue: 5) var y // 2
}

let b = HasWrapperWithInitalValue()
b.x
b.y



struct User {
    @UpperCased var name: String
}

let user = User(name: "alfianlo")
print(user.name)

struct Form {
    @Ranged(min: 17, max: 65) var age: Int = 0
}

var form = Form()

form.age = 200
form.age = 2
form.age = 20

struct Form2 {
    @Ranged var age: Int
}

let form2 = Form2(age: Ranged(wrappedValue: 3, min: 0, max: 10))

let form2_1 = Form2(age: .init(wrappedValue: 3, min: 0, max: 90))

struct Form3 {
    @ISO8601DateFormatted var lastLoginAt: Date
}

let form3_0 = Form3(lastLoginAt: Date())
print(form3_0.$lastLoginAt)

struct HomeViewModel {
    @Localizable var headerTitle: String
    @Localizable var headerSubtitle: String
}

let homeModel = HomeViewModel(headerTitle: "a", headerSubtitle: "b")
print(homeModel.headerTitle)
print(homeModel.headerSubtitle)
