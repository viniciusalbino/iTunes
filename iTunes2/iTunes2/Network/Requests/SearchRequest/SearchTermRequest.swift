
import Foundation

final class SearchTermRequest {
    var network = NetworkCore.defaultNetwork
    let endpoint: NetworkCoreEndpoint
    
    init(network: NetworkCore = NetworkCore.defaultNetwork, paramaters: SearchRequestDTO) {
        self.network = network
        self.endpoint = SearchItunesEndpoint(dto: paramaters)
    }

    func request(completion: @escaping (Result<[ITunesItem], NetworkCoreErrorType>) -> Void) {
        network.request(for: endpoint) { response in
            switch response.handler {
            case .success:
                if let data = response.data <--> Response.self {
                    completion(.success(data.results))
                } else {
                    completion(.failure(.businessError))
                }
            case .error(let errorType):
                completion(.failure(errorType))
            }
        }
    }
}

struct SearchItunesEndpoint: NetworkCoreEndpoint {
    var dto: SearchRequestDTO
    
    init(dto: SearchRequestDTO) {
        self.dto = dto
    }
    
    var path: String {
        return "search/"
    }
    
    var task: NetworkCoreTask {
        return .requestParameters(parameters: dto.asDictionary)
    }
    
    var method: NetworkCoreMethod {
        return .get
    }
    
    var headers: [String : String] {
        return ["Content-Type": "application/json;charset=utf-8"]
    }
}
