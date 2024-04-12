
import Foundation
import XCTest
@testable import iTunes2

class HomePresenterTests: XCTestCase {
    
    var presenter: HomePresenter!
    var mockInteractor: MockHomeInteractor!
    var mockViewController: MockHomeViewController!
    var mockRouter: MockRouter!
    
    override func setUp() {
        super.setUp()
        
        mockInteractor = MockHomeInteractor()
        mockRouter = MockRouter()
        presenter = HomePresenter(router: mockRouter, interactor: mockInteractor)
        
        mockViewController = MockHomeViewController()
        presenter.viewController = mockViewController
        mockInteractor.presenter = presenter
    }
    
    func testLoadContentCallsInteractor() {
        presenter.loadContent(term: "test")
        XCTAssertTrue(mockInteractor.searchWasCalled)
        XCTAssertNotNil(presenter.itemForRowAt(0))
    }
    
    func testItemValues() {
        presenter.loadContent(term: "test")
        XCTAssertTrue(mockInteractor.searchWasCalled)
        guard let item = presenter.itemForRowAt(0) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(item.name, "Even Better Than the Real Thing (Jacques Lu Cont Mix)")
        XCTAssertEqual(item.subtitle, "U2")
        XCTAssertEqual(item.imageURL, "https://is2-ssl.mzstatic.com/image/thumb/Music/b4/04/13/mzi.dqmgowwz.jpg/100x100bb.jpg")
        XCTAssertEqual(item.price, "-$1.00")
    }
    
    func testDidGetSearchUpdatesView() {
        presenter.loadContent(term: "test")
        XCTAssertTrue(mockViewController.reloadDataCalled)
    }
    
    func testSelectItemAtCallsRouter() {
        presenter.loadContent(term: "test")
        presenter.selectItemAt(0)
        XCTAssertTrue(mockRouter.loadItemDetailCalled)
    }
    
    func testErrorLoadingData() {
        mockInteractor.shouldReturnError = true
        presenter.loadContent(term: "term")
        
        XCTAssertTrue(mockInteractor.searchWasCalled)
        
        XCTAssertNil(presenter.itemForRowAt(0))
        
        XCTAssertFalse(mockViewController.reloadDataCalled)
        XCTAssertTrue(mockViewController.errorReloadDataCalled)
        
        XCTAssertFalse(mockRouter.loadItemDetailCalled)
    }
}
