
import Foundation
@testable import iTunes2
import XCTest

class StringLocalizationTests: XCTestCase {
    
    func testLocalizedStringWithComment() {
        let string = "hello"
        let localizedString = string.localized(Withcomment: "Just a test")
        XCTAssertEqual(localizedString, "Hello", "Expected 'Hello' but got \(localizedString)")
    }
    
    func testLocalizedStringWithoutComment() {
        let string = "world"
        let localizedString = string.localized()
        XCTAssertEqual(localizedString, "World!", "Expected 'World!' but got \(localizedString)")
    }
    
    func testStringWithoutLocalizationEntry() {
        let string = "not_present_key"
        let localizedString = string.localized()
        XCTAssertEqual(localizedString, "not_present_key", "Expected 'not_present_key' but got \(localizedString)")
    }
}
