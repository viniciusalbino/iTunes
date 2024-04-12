
import Foundation
import XCTest
@testable import iTunes2

class RequestableWithBodyTests: XCTestCase {
    
    func testRequestSuccessFromJSON() {
        let requestable = MockRequestable(username: "name")
        requestable.request { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.name, "Test name")
                XCTAssertEqual(user.age, 30)
            case .failure:
                break
            }
        }
    }
    
    func testRequestSuccessFromCode() {
        let requestable = MockRequestable(username: "developer")
        requestable.request { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.name, "Developer Name")
                XCTAssertEqual(user.age, 27)
            case .failure:
                break
            }
        }
    }
    
    func testRequestFailure() {
        let requestable = MockRequestable(username: "")
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
    let network = NetworkCore()
    var endpoint: NetworkCoreEndpoint {
        return MockEndpoint(username: username)
    }
    
    init(username: String) {
        self.username = username
    }
    
    func request(completion: @escaping (Result<UserMock, NetworkCoreErrorType>) -> Void) {
        network.request(for: endpoint) { response in
            if let userMock = response.data <--> UserMock.self {
                completion(.success(userMock))
            } else {
                if case let .error(errorType) = response.handler {
                    completion(.failure(errorType))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }
    }
}

private struct MockEndpoint: NetworkCoreEndpoint {
    
    let username: String
    let baseURL = URL(string: "https://google.com")!
    let path = "/path/to/endpoint"
    let method = NetworkCoreMethod.post
    let headers: [String : String] = [:]
    var task: NetworkCoreTask {
        return .requestParameters(parameters: ["username": username])
    }
}

extension MockEndpoint {
    
    var shouldMock: Bool {
        return true
    }
    
    var mockResponse: NetworkCoreResponse? {
        guard !username.isEmpty else {
            return NetworkCoreResponse.notFound
        }
        if username == "developer" {
            let userMockData = UserMock(name: "Developer Name", age: 27).encoded()
            return NetworkCoreResponse(statusCode: 200, data: userMockData, headers: [:], handler: .success)
        } else {
            let jsonFile = Bundle(for: RequestableWithBodyTests.self).path(forResource: "user-mock", ofType: "json") ?? ""
            let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile), options: .mappedIfSafe)
            return NetworkCoreResponse(statusCode: 200, data: data ?? Data(), headers: [:], handler: .success)
        }
    }
}
