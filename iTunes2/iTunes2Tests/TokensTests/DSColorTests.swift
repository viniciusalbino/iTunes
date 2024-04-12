
import Foundation
import XCTest
@testable import iTunes2

class ColorTests: XCTestCase {
    
    // Test all cases for Color enum
    func testColorEnumCases() {
        XCTAssertEqual(CustomColor.primaryColor.color(), TokenManager.shared.getColorFor(name: .primaryColor).color)
        XCTAssertEqual(CustomColor.secondaryColor.color(), TokenManager.shared.getColorFor(name: .secondaryColor).color)
        XCTAssertEqual(CustomColor.textPrimaryColor.color(), TokenManager.shared.getColorFor(name: .textPrimaryColor).color)
        XCTAssertEqual(CustomColor.textSecondaryColor.color(), TokenManager.shared.getColorFor(name: .textSecondaryColor).color)
        XCTAssertEqual(CustomColor.none.color(), UIColor.clear)
        XCTAssertEqual(CustomColor.clear.color(), UIColor.clear)
    }
    
    // Test default DSColor init
    func testDefaultDSColor() {
        let defaultColor = DSColor()
        XCTAssertEqual(defaultColor.hexString, "")
        XCTAssertEqual(defaultColor.enumValue, .clear)
        XCTAssertEqual(defaultColor.color, .clear)
    }
    
    // Test DSColor init with colorHex and value
    func testDSColorInitWithHexValue() {
        let validColor = DSColor(colorHex: "#FFFFFF", value: "primaryColor")
        XCTAssertEqual(validColor.hexString, "#FFFFFF")
        XCTAssertEqual(validColor.enumValue, .primaryColor)
        XCTAssertEqual(validColor.color, UIColor(hex: "#FFFFFF"))
        
        // With invalid name and valid hex
        let invalidNameColor = DSColor(colorHex: "#FF0000", value: "invalidValue")
        XCTAssertEqual(invalidNameColor.hexString, "#FF0000")
        XCTAssertEqual(invalidNameColor.enumValue, .clear)
        XCTAssertEqual(invalidNameColor.color, UIColor(hex: "#FF0000"))
    }
    
    // Test UIColor extension
    func testUIColorDesignSystem() {
        XCTAssertEqual(UIColor.designSystem(.primaryColor), CustomColor.primaryColor.color())
        XCTAssertEqual(UIColor.designSystem(.clear), UIColor.clear)
    }
    
}
