
import Foundation
import XCTest

@testable import iTunes2

class TokensTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TokenManager.shared.setup()
    }
    
    // MARK: - Color tests
    
    func testColors() {
        XCTAssertTrue(UIColor.designSystem(.primaryColor).isEqualTo(UIColor(hex: "072E33")))
        XCTAssertTrue(UIColor.designSystem(.secondaryColor).isEqualTo(UIColor(hex: "6DA5C0")))
        XCTAssertTrue(UIColor.designSystem(.textPrimaryColor).isEqualTo(UIColor(hex: "FFFFFF")))
        XCTAssertTrue(UIColor.designSystem(.textSecondaryColor).isEqualTo(UIColor(hex: "D3D3D3")))
    }
    
    // MARK: - Spacing
    func testSpacing() {
        XCTAssertEqual(CGFloat.spacing(.spacingXs), 6.0)
        XCTAssertEqual(CGFloat.spacing(.spacingSm), 12)
        XCTAssertEqual(CGFloat.spacing(.spacingMd), 18)
        XCTAssertEqual(CGFloat.spacing(.spacingLg), 32)
        XCTAssertEqual(CGFloat.spacing(.spacingXl), 64)
    }
    
    
    // MARK: - FontSize
    func testFontSize() {
        XCTAssertEqual(CGFloat.fontSize(.fontSizeSm), 12)
        XCTAssertEqual(CGFloat.fontSize(.fontSizeMd), 14)
        XCTAssertEqual(CGFloat.fontSize(.fontSizeLg), 20)
        XCTAssertEqual(CGFloat.fontSize(.fontSizeXl), 32)
    }
}
