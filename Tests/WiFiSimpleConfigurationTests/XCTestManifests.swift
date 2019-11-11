import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(WiFiSimpleConfigurationTests.allTests),
    ]
}
#endif
