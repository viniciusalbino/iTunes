
import Foundation
import XCTest

@testable import iTunes2

class UIViewControllerExtensionTests: XCTestCase {
    
    var viewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        viewController = UIViewController()
        _ = viewController.view
    }
    
    func testStartLoading() {
        viewController.startLoading()
        XCTAssertNotNil(viewController.view.viewWithTag(100))
        
        let loadingView = viewController.view.viewWithTag(100)
        let activityIndicator = loadingView?.subviews.first { $0 is UIActivityIndicatorView }
        
        XCTAssertNotNil(activityIndicator)
    }
    
    func testStopLoading() {
        viewController.startLoading()
        XCTAssertNotNil(viewController.view.viewWithTag(100))
        
        viewController.stopLoading()
        XCTAssertNil(viewController.view.viewWithTag(100))
    }
    
    func testPerformUIUpdate() {
        let expectation = self.expectation(description: "Closure Execution")
        
        viewController.performUIUpdate {
            XCTAssertTrue(Thread.isMainThread)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
}
