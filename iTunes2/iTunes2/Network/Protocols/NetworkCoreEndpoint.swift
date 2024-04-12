
import Foundation

protocol NetworkCoreEndpoint {
    var baseURL: URL { get }
    
    var path: String { get }
    
    var task: NetworkCoreTask { get }
    
    var method: NetworkCoreMethod { get }
    
    var headers: [String: String] { get }
    
    var shouldMock: Bool { get }
    
    var mockResponse: NetworkCoreResponse? { get }
}


extension NetworkCoreEndpoint {
    var shouldMock: Bool {
        return false
    }
    
    var mockResponse: NetworkCoreResponse? {
        return nil
    }
}

extension NetworkCoreEndpoint {
    func createRequest() -> NSMutableURLRequest? {
        guard let requestURL = createURL() else {
            return nil
        }
        let request = NSMutableURLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.httpBody = createBody()
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
    
    func createURL() -> URL? {
        switch task {
        case .requestPlain:
            return urlForPlainRequest()
        case .requestParameters(parameters: let urlParameters), .requestCompositeBodyData(_, let urlParameters):
            return urlWithParameters(urlParameters)
        }
    }
    
    func createBody() -> Data? {
        switch task {
        case .requestPlain, .requestParameters:
            return nil
        case .requestCompositeBodyData(let data, _):
            return data
        }
    }
}

private extension NetworkCoreEndpoint {
    private func urlForPlainRequest() -> URL {
        return baseURL.appendingPathComponent(path)
    }
    
    private func urlWithParameters(_ parameters: [String: String]) -> URL? {
        guard var requestURL = URLComponents(string: baseURL.absoluteString + path) else {
            return nil
        }
        requestURL.queryItems = parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        return requestURL.url
    }
}
