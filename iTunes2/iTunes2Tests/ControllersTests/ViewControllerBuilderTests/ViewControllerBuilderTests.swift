
import Foundation
@testable import iTunes2
import XCTest

class SampleViewControllerBuilderTests: XCTestCase {
    
    var builder: SampleViewControllerBuilder!
    
    override func setUp() {
        super.setUp()
        builder = SampleViewControllerBuilder()
    }
    
    override func tearDown() {
        builder = nil
        super.tearDown()
    }
    
    func testBuild() {
        let viewController = builder.build()
        XCTAssertNotNil(viewController)
        XCTAssertTrue(viewController is UIViewController)
    }
}


class SampleViewControllerBuilder: ViewControllerBuilder {
    func build() -> UIViewController {
        return UIViewController()
    }
}
