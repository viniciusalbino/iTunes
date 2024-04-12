
import Foundation
import UIKit

final class HomePresenter {
    
    // MARK: -  Viper Properties
    /// The view controller to which this presenter outputs information.
    weak var viewController: HomePresenterOutputProtocol?
    /// The router responsible for navigation logic related to the home scree
    private let router: HomeRouterProtocol
    /// The interactor responsible for business logic and data retrieval.
    private let interactor: HomeInteractorInputProtocol
    
    // MARK: - Properties
    /// An array containing the content to be displayed.
    private var content: [ITunesItem] = []
    /// The current offset used for pagination.
    private var offset: Int = 0
    /// The limit used to determine the number of items fetched in each request.
    private var limit: Int = 10
    /// The type of media content to be fetched.
    private var mediaType: MediaType = .music
    
    // MARK: - init
    /// Initializes a new instance of `HomePresenter`.
    ///
    /// - Parameters:
    ///   - router: An instance of the router for handling navigation logic.
    ///   - interactor: An instance of the interactor for handling business logic and data retrieval.
    init(router: HomeRouterProtocol, interactor: HomeInteractorInputProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - Presenter Input Protocol
/// Extension that conforms to `HomePresenterInputProtocol` which handles inputs from the view controller.
extension HomePresenter: HomePresenterInputProtocol {
    /// Select an desired item and navigate to the detail page
    /// - Parameters:
    ///   - row: The row index of the desired term.
    func selectItemAt(_ row: Int) {
        guard let content = content.object(index: row) else {
            return
        }
        router.loadItemDetailController(content: content)
    }
    /// Requests content based on the given search term.
    /// - Parameters:
    ///   - term: The search term to be executed on API
    func loadContent(term: String) {
        interactor.executeSearch(term: term, type: mediaType, offset: offset, limit: limit)
    }
    
    /// Retrieves a data object for a given row, suitable for populating a `SongCell`.
    /// - Parameters:
    ///   - row: The row index of the desired term.
    /// - Returns: An optional object SongCellDTO
    func itemForRowAt(_ row: Int) -> SongCellDTO? {
        guard let content = content.object(index: row), let price = content.trackPrice.toCurrencyFormat(currency: content.currency) else {
            return nil
        }
        return SongCellDTO(name: content.trackName, subtitle: content.artistName, imageURL: content.artworkUrl100, price: price)
    }
}

// MARK: - Presenter Output Protocol
/// Extension that conforms to `HomeInteractorOutputProtocol` which handles outputs from the interactor.
extension HomePresenter: HomeInteractorOutputProtocol {
    /// Updates the content and notifies the view controller when new data is fetched.
    func didGetSearch(objects: [ITunesItem]) {
        offset += objects.count
        content.append(contentsOf: objects)
        viewController?.reloadData(data: objects)
    }
    /// Notifies the view controller when an error occurs while fetching data.
    func errorExecutingSearch(error: Error) {
        viewController?.errorLoadingData(error: error)
    }
}
