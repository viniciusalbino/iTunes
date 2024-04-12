
import Foundation
import XCTest

@testable import iTunes2

class FontSizeTests: XCTestCase {
    
    // Test default DSFontSize init
    func testDefaultDSFontSize() {
        let defaultSize = DSFontSize()
        XCTAssertEqual(defaultSize.fontSize, 12)
        XCTAssertEqual(defaultSize.enumValue, .fontSizeSm)
    }
    
    // Test DSFontSize init with name and value
    func testDSFontSizeInitWithNameValue() {
        let validSize = DSFontSize(name: "fontSizeMd", value: "14.5")
        XCTAssertEqual(validSize.enumValue, .fontSizeMd)
        XCTAssertEqual(validSize.fontSize, 14.5)
        
        // With invalid name and valid value
        let invalidNameSize = DSFontSize(name: "invalidName", value: "15.0")
        XCTAssertEqual(invalidNameSize.enumValue, .fontSizeSm)
        XCTAssertEqual(invalidNameSize.fontSize, 15.0)
        
        // With valid name and invalid value
        let invalidValueSize = DSFontSize(name: "fontSizeLg", value: "invalidValue")
        XCTAssertEqual(invalidValueSize.enumValue, .fontSizeLg)
        XCTAssertEqual(invalidValueSize.fontSize, 12)
        
        // With both invalid name and value
        let bothInvalidSize = DSFontSize(name: "invalidName", value: "invalidValue")
        XCTAssertEqual(bothInvalidSize.enumValue, .fontSizeSm)
        XCTAssertEqual(bothInvalidSize.fontSize, 12)
    }
}
