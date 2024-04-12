
import Foundation
import XCTest

class NumberFormatterTests: XCTestCase {
    
    func testUSNumberFormatter() {
        let formatter = NumberFormatter.usNumberFormatter()
        XCTAssertEqual(formatter.locale, Locale(identifier: "en_US"))
        
        // Example usage test
        let formattedNumber = formatter.string(from: NSNumber(value: 1234567.89))
        
        XCTAssertEqual(formattedNumber, "1234568")
    }
}
