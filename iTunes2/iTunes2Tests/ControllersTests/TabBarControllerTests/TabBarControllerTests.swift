
import Foundation
import XCTest
@testable import iTunes2

class TabBarControllerTests: XCTestCase {
    
    var tabBarVC: TabBarController!
    
    override func setUp() {
        super.setUp()
        tabBarVC = TabBarController()
    }
    
    override func tearDown() {
        tabBarVC = nil
        super.tearDown()
    }
    
    func testLoadTabBar() {
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        
        tabBarVC.loadTabBar(viewControllers: [vc1, vc2], tabs: [.home, .search])
        
        XCTAssertNotNil(tabBarVC.viewControllers, "TabBarController view controllers are nil.")
        XCTAssertEqual(tabBarVC.viewControllers?.count, 2, "Incorrect number of view controllers.")
        XCTAssertEqual(tabBarVC.tabBar.items?.count, 2, "Incorrect number of tab bar items.")
    }
    
    func testCustomizeTabBarItems() {
        tabBarVC.loadTabBar(viewControllers: [UIViewController(), UIViewController()], tabs: [.home, .search])
        tabBarVC.customizeTabBarItems()
        XCTAssertEqual(tabBarVC.tabBar.items?.first?.title, TabBarItem.home.title, "First tab bar item title is incorrect.")
        XCTAssertEqual(tabBarVC.tabBar.items?.last?.title, TabBarItem.search.title, "Last tab bar item title is incorrect.")
    }
    
    func testSwitchTabBar() {
        tabBarVC.loadTabBar(viewControllers: [UIViewController(), UIViewController()], tabs: [.home, .search])
        tabBarVC.switchTabBar(selected: .search)
        XCTAssertEqual(tabBarVC.selectedIndex, TabBarItem.search.rawValue, "TabBarController selected index is incorrect.")
    }
    
    func testConsistToTheme() {
        tabBarVC.loadTabBar(viewControllers: [UIViewController(), UIViewController()], tabs: [.home, .search])
        tabBarVC.consistToTheme()
        XCTAssertEqual(tabBarVC.tabBar.barTintColor, UIColor.designSystem(.primaryColor), "TabBar background color is incorrect.")
        XCTAssertEqual(tabBarVC.tabBar.tintColor, UIColor.designSystem(.textPrimaryColor), "TabBar tint color is incorrect.")
    }
}
