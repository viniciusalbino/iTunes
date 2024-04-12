
import Foundation
import XCTest
@testable import iTunes2

class HomeRouterTests: XCTestCase {
    var router: HomeRouter!
    var mockNavigationController: UINavigationController!
    var mockTabBarController: TabBarController!
    
    override func setUp() {
        super.setUp()
        
        mockNavigationController = UINavigationController(rootViewController: UIViewController())
        mockTabBarController = TabBarController()
        mockTabBarController.viewControllers = [mockNavigationController]
        router = HomeRouter(tabBarController: mockTabBarController)
    }
    
    func testLoadItemDetailController() {
        let mockItem = MockHomeInteractor().loadMock().first!
        router.loadItemDetailController(content: mockItem)
        
        let expectation = XCTestExpectation(description: "Waiting for main thread")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        guard let lastViewController = mockNavigationController.viewControllers.last as? ItemDetailViewController else {
            XCTFail("Expected ItemDetailController but found \(String(describing: mockNavigationController.viewControllers.last))")
            return
        }
        
        XCTAssertNil(lastViewController.title)
    }
    
    override func tearDown() {
        router = nil
        mockNavigationController = nil
        mockTabBarController = nil
        mockTabBarController = nil
        
        super.tearDown()
    }
}
