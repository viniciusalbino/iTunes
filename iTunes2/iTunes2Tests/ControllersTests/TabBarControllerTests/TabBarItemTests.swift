
import Foundation
import XCTest
@testable import iTunes2

class TabBarItemTests: XCTestCase {
    
    // Test titles for TabBarItems
    func testTabBarItemTitles() {
        XCTAssertEqual(TabBarItem.home.title, "Home".localized())
        XCTAssertEqual(TabBarItem.search.title, "Search".localized())
    }
    
    // Test icons for TabBarItems
    func testTabBarItemIcons() {
        XCTAssertNotNil(TabBarItem.home.icon)
        XCTAssertNotNil(TabBarItem.search.icon)
    }
    
    // Test accessibility identifiers for TabBarItems
    func testTabBarItemAccessibilityIdentifiers() {
        XCTAssertEqual(TabBarItem.home.accessibilityIdentifier, "Home".localized().uppercased())
        XCTAssertEqual(TabBarItem.search.accessibilityIdentifier, "Search".localized().uppercased())
    }
}
