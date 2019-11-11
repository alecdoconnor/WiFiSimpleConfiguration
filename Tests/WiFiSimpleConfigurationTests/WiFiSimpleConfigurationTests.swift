import XCTest
@testable import WiFiSimpleConfiguration

final class WiFiSimpleConfigurationTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WiFiSimpleConfiguration().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
