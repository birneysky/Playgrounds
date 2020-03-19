import Foundation

@propertyWrapper
public struct Localizable {
    private var key: String
    
    public var wrappedValue:  String {
        get { NSLocalizedString(key, tableName: "Main", comment: "") }
        set { key = newValue }
    }
    
    public init(wrappedValue: String) {
        self.key = wrappedValue
    }
    
}
