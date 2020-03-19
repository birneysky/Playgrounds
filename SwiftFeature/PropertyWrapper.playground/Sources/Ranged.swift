import Foundation

@propertyWrapper
public struct Ranged<T: Comparable> {
    private var maximum: T
    private var minimum: T
    private var value: T
    
    public var wrappedValue: T {
        get { value }
        set {
            if newValue > maximum {
                value = maximum
            } else if newValue < minimum {
                value = minimum
            } else {
                value = newValue
            }
        }
    }
    
   public init(wrappedValue: T, min: T, max: T) {
        guard max > min else {
            fatalError()
        }
        self.value = wrappedValue
        self.maximum = max
        self.minimum = min
    }
}
