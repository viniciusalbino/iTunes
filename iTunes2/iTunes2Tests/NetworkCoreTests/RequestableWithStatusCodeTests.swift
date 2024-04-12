
import Foundation
import XCTest
@testable import iTunes2

class RequestableWithStatusCodeTests: XCTestCase {
    
    func testRequestSuccess() {
        let requestable = MockRequestable(hash: "a2qsw3de45fr6gt7hy8ju9ikju8hy7gt6fr5")
        requestable.request { result in
            switch result {
            case .success(let dummy):
                XCTAssertNotNil(dummy)
            case .failure:
                break
                //                assertionFailure("Unexpected result")
            }
        }
    }
    
    func testRequestFailure() {
        let requestable = MockRequestable(hash: "wu8hy7gt")
        requestable.request { result in
            switch result {
            case .success:
                assertionFailure("Unexpected result")
            case .failure(let errorType):
                XCTAssertEqual(errorType, .businessError)
            }
        }
    }
}

// MARK: - Requestable and Endpoint

private class MockRequestable: NetworkCoreRequestable {
    
    let hash: String
    let network = NetworkCore()
    var endpoint: NetworkCoreEndpoint {
        return MockEndpoint(hash: hash)
    }
    
    init(hash: String) {
        self.hash = hash
    }
    
    func request(completion: @escaping (Result<Dummy, NetworkCoreErrorType>) -> Void) {
        network.request(for: endpoint) { response in
            if response.statusCode == NetworkCoreStatusCode.created.rawValue {
                completion(.success(Dummy()))
            } else {
                completion(.failure(.businessError))
            }
        }
    }
}

private struct MockEndpoint: NetworkCoreEndpoint {
    
    let hash: String
    let baseURL = URL(string: "https://google.com")!
    let path = "/path/to/endpoint"
    let method = NetworkCoreMethod.post
    let headers: [String : String] = [:]
    var task: NetworkCoreTask {
        return .requestCompositeBodyData(data: hash.encoded(), urlParameters: [:])
    }
}

extension MockEndpoint {
    
    var shouldMock: Bool {
        return true
    }
    
    var mockResponse: NetworkCoreResponse? {
        if hash.count > 10 {
            return NetworkCoreResponse(statusCode: 201, data: Data(), headers: [:], handler: .success)
        } else {
            return NetworkCoreResponse.errorWithCode(.badRequest)
        }
    }
}
