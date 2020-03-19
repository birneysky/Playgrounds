import Foundation

@propertyWrapper
public struct ISO8601DateFormatted {
    static private let formatter = ISO8601DateFormatter()
    public var projectedValue: String {
        Self.formatter.string(from: wrappedValue)
    }
    public var wrappedValue: Date
    
    public init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
    }
}
