
import Foundation
import XCTest
@testable import iTunes2

class SpacingTests: XCTestCase {
    
    // Test default DSSpacing init
    func testDefaultDSSpacing() {
        let defaultSpacing = DSSpacing()
        XCTAssertEqual(defaultSpacing.spacingValue, 12)
        XCTAssertEqual(defaultSpacing.enumValue, .spacingXs)
    }
    
    // Test DSSpacing init with name and value
    func testDSSpacingInitWithNameValue() {
        let validSpacing = DSSpacing(name: "spacingMd", value: "16.5")
        XCTAssertEqual(validSpacing.enumValue, .spacingMd)
        XCTAssertEqual(validSpacing.spacingValue, 16.5)
        
        // With invalid name and valid value
        let invalidNameSpacing = DSSpacing(name: "invalidName", value: "14.0")
        XCTAssertEqual(invalidNameSpacing.enumValue, .spacingXs)
        XCTAssertEqual(invalidNameSpacing.spacingValue, 14.0)
        
        // With valid name and invalid value
        let invalidValueSpacing = DSSpacing(name: "spacingLg", value: "invalidValue")
        XCTAssertEqual(invalidValueSpacing.enumValue, .spacingLg)
        XCTAssertEqual(invalidValueSpacing.spacingValue, 12)
        
        // With both invalid name and value
        let bothInvalidSpacing = DSSpacing(name: "invalidName", value: "invalidValue")
        XCTAssertEqual(bothInvalidSpacing.enumValue, .spacingXs)
        XCTAssertEqual(bothInvalidSpacing.spacingValue, 12)
    }
}
