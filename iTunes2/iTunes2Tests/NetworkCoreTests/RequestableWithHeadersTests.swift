
import Foundation
import XCTest
@testable import iTunes2

class RequestableWithHeadersTests: XCTestCase {
    
    func testRequestSuccess() {
        let requestable = MockRequestable(username: "developer", password: "123456")
        requestable.request { result in
            
            switch result {
            case .success(let authorization):
                XCTAssertEqual(authorization, "ki9ju8hy7gt6fr5de4sw34ed5rft6gy7bhnum")
            case .failure(let _):
                break
            }
        }
    }
    
    func testRequestFailureWithInvalidCredentials() {
        let requestable = MockRequestable(username: "developer", password: "138hs782")
        requestable.request { result in
            switch result {
            case .success:
                assertionFailure("Unexpected result")
            case .failure(let errorType):
                XCTAssertEqual(errorType, .businessError)
            }
        }
    }
    
    func testRequestFailureWithEmptyCredentials() {
        let requestable = MockRequestable(username: "", password: "")
        requestable.request { result in
            switch result {
            case .success:
                assertionFailure("Unexpected result")
            case .failure(let errorType):
                XCTAssertEqual(errorType, .noConnection)
            }
        }
    }
}

// MARK: - Requestable and Endpoint

private class MockRequestable: NetworkCoreRequestable {
    
    let username: String
    let password: String
    let network = NetworkCore()
    var endpoint: NetworkCoreEndpoint {
        return MockEndpoint(username: username, password: password)
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func request(completion: @escaping (Result<String, NetworkCoreErrorType>) -> Void) {
        network.request(for: endpoint) { response in
            switch response.handler {
            case .success:
                if let authorizationHeader = response.headers["X-Authorization"] as? String {
                    let normalizedAuthorization = authorizationHeader.replacingOccurrences(of: "Bearer", with: "").trimmingCharacters(in: .whitespaces)
                    completion(.success(normalizedAuthorization))
                } else {
                    completion(.failure(.businessError))
                }
            case .error(let errorType):
                completion(.failure(errorType))
            }
        }
    }
}

private struct MockEndpoint: NetworkCoreEndpoint {
    
    let username: String
    let password: String
    let baseURL = URL(string: "https://google.com")!
    let path = "/path/to/endpoint"
    let method = NetworkCoreMethod.post
    let headers: [String : String] = [:]
    var task: NetworkCoreTask {
        let credentialsData = "\(username)=\(password)".data(using: .utf8) ?? Data()
        return .requestCompositeBodyData(data: credentialsData, urlParameters: [:])
    }
}

extension MockEndpoint {
    
    var shouldMock: Bool {
        return true
    }
    
    var mockResponse: NetworkCoreResponse? {
        guard !username.isEmpty, !password.isEmpty else {
            return NetworkCoreResponse.notFound
        }
        let passwordContainsOnlyNumbers = password.allSatisfy { $0.isNumber }
        if passwordContainsOnlyNumbers {
            let headers = ["X-Authorization": "Bearer ki9ju8hy7gt6fr5de4sw34ed5rft6gy7bhnum"]
            return NetworkCoreResponse(statusCode: 204, data: Data(), headers: headers, handler: .success)
        } else {
            return NetworkCoreResponse.errorWithCode(.badRequest)
        }
    }
}
