//
//  DetailRequest.swift
//  iTunes2
//
//  Created by Vinicius Albino on 19/08/23.
//

import Foundation

final class DetailRequest {
    var network = NetworkCore.defaultNetwork
    let endpoint: NetworkCoreEndpoint
    
    init(network: NetworkCore = NetworkCore.defaultNetwork, itemID: String) {
        self.network = network
        self.endpoint = DetailEndpoint(itemID: itemID)
    }
    
    func request(completion: @escaping (Result<ITunesItem, NetworkCoreErrorType>) -> Void) {
        network.request(for: endpoint) { response in
            switch response.handler {
            case .success:
                if let data = response.data <--> Response.self {
                    completion(.success(data.results.first!))
                } else {
                    completion(.failure(.businessError))
                }
            case .error(let errorType):
                completion(.failure(errorType))
            }
        }
    }
}

struct DetailEndpoint: NetworkCoreEndpoint {
    var itemID: String
    
    init(itemID: String) {
        self.itemID = itemID
    }
    
    var path: String {
        return "lookup/"
    }
    
    var task: NetworkCoreTask {
        return .requestParameters(parameters: ["id": itemID])
    }
    
    var method: NetworkCoreMethod {
        return .get
    }
    
    var headers: [String : String] {
        return ["Content-Type": "application/json;charset=utf-8"]
    }
}
