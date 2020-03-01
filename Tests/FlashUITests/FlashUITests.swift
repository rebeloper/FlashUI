import XCTest
@testable import FlashUI

final class FlashUITests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FlashUI().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
