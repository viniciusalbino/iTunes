
@testable import iTunes2
import XCTest

class MockHomeViewController: HomePresenterOutputProtocol {
    
    var reloadDataCalled = false
    var errorReloadDataCalled = false
    var loadedData: [ITunesItem]?
    
    func reloadData(data: [ITunesItem]) {
        reloadDataCalled = true
        loadedData = data
    }
    
    func errorLoadingData(error: Error) {
        errorReloadDataCalled = true
        reloadDataCalled = false
    }
}

class MockRouter: HomeRouterProtocol {
    var loadItemDetailCalled = false
    var loadedContent: ITunesItem?
    
    func loadItemDetailController(content: ITunesItem) {
        loadItemDetailCalled = true
        loadedContent = content
    }
}

class MockHomeInteractor: HomeInteractorInputProtocol {
    
    var shouldReturnError = false
    var searchWasCalled = false
    
    func executeSearch(term: String, type: MediaType, offset: Int, limit: Int) {
        searchWasCalled = true
        if shouldReturnError {
            presenter?.errorExecutingSearch(error: NSError(domain: "", code: 0, userInfo: nil))
        } else {
            let mockData = loadMock()
            presenter?.didGetSearch(objects: mockData)
        }
    }
    
    weak var presenter: HomeInteractorOutputProtocol?
}

extension MockHomeInteractor {
    func loadMock() -> [ITunesItem] {
        let jsonFile = Bundle(for: MockHomeInteractor.self).path(forResource: "itunesData", ofType: "json") ?? ""
        let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile), options: .mappedIfSafe)
        if let data = data <--> Response.self {
            return data.results
        } else {
            return []
        }
    }
}

