
import Foundation
import XCTest
@testable import iTunes2 

class UIColorExtensionTests: XCTestCase {
    
    // 1. Testing image creation from a color
    func testImageFromColor() {
        let color = UIColor.red
        let image = color.image()
        XCTAssertNotNil(image)
    }
    
    // 2. Initializing a color using a hex string
    func testInitWithHexString() {
        let color = UIColor(hex: "FF0000")
        XCTAssertEqual(color, UIColor.red)
    }
    
    // Test initializing with a hex string containing a "#" prefix
    func testInitWithHashedHexString() {
        let color = UIColor(hex: "#FF0000")
        XCTAssertEqual(color, UIColor.red)
    }
    
    // 3. Initializing a color using UInt32 values for red, green, and blue
    func testInitWithUInt32Values() {
        let color = UIColor(red: 255, green: 0, blue: 0)
        XCTAssertEqual(color, UIColor.red)
    }
    
    // 4. Initializing a color using a net hex value
    func testInitWithNetHex() {
        let color = UIColor(netHex: 0xFF0000)
        XCTAssertEqual(color, UIColor.red)
    }
    
    // 5. Converting a color to its hex string representation
    func testToHexString() {
        let color = UIColor.red
        XCTAssertEqual(color.toHexString(), "#ff0000")
    }
}
