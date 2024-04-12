
import Foundation

final class HomeInteractor {
    // MARK: - Viper properties
    /// The output delegate that will be notified with results or errors.
    weak var output: HomeInteractorOutputProtocol?
}

// MARK: - Input Protocol
/// An extension that conforms to `HomeInteractorInputProtocol` for handling input requests.
extension HomeInteractor: HomeInteractorInputProtocol {
    
    /// Executes a search request based on the provided parameters.
    ///
    /// - Parameters:
    ///   - term: The search term.
    ///   - type: The type of media to search for.
    ///   - offset: The offset to start fetching results from.
    ///   - limit: The number of results to fetch.
    public func executeSearch(term: String, type: MediaType, offset: Int, limit: Int) {
        // Construct the search request data object
        let dto = SearchRequestDTO(term: term, media: type, limit: limit, offset: offset)
        let request = SearchTermRequest(paramaters: dto)
        
        // Execute the request
        request.request { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                // On successful data retrieval, notify the output delegate
                self.output?.didGetSearch(objects: data)
            case .failure(let error):
                // On failure, notify the output delegate of the error
                self.output?.errorExecutingSearch(error: error)
            }
        }
    }
}
