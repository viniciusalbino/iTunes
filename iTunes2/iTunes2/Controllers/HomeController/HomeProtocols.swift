
import Foundation
import UIKit

// MARK: - ViewController
protocol HomePresenterOutputProtocol: AnyObject {
    func reloadData(data: [ITunesItem])
    func errorLoadingData(error: Error)
}

// MARK: - Presenter
protocol HomePresenterInputProtocol: AnyObject {
    func loadContent(term: String)
    func itemForRowAt(_ row: Int) -> SongCellDTO?
    func selectItemAt(_ row: Int)
}

// MARK: - Interactor
protocol HomeInteractorInputProtocol: AnyObject {
    func executeSearch(term: String, type: MediaType, offset: Int, limit: Int)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func didGetSearch(objects: [ITunesItem])
    func errorExecutingSearch(error: Error)
}

// MARK: - Router
protocol HomeRouterProtocol: AnyObject {
    func loadItemDetailController(content: ITunesItem)
}
