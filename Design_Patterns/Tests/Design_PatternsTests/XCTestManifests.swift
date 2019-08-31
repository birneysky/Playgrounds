import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Design_PatternsTests.allTests),
    ]
}
#endif
