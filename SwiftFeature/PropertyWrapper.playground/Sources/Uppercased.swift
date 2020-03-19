import Foundation

@propertyWrapper
public struct UpperCased   {
    private var text: String
    
    public init(wrappedValue: String) {
        self.text = wrappedValue
    }
    
    public var wrappedValue: String {
        get { self.text.uppercased() }
        set { self.text = newValue }
    }
}
