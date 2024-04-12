
import Foundation

class NetworkCore {
    
    private let configuration: NetworkCoreConfiguration
    private let dispatchGroup = DispatchGroup()
    private let dispatchQueueName = "NetworkCore"
    private var task: URLSessionDataTask?
    
    init(configuration: NetworkCoreConfiguration = NetworkCoreConfiguration()) {
        self.configuration = configuration
    }
    
    func request(for endpoint: NetworkCoreEndpoint, completion: @escaping (_ response: NetworkCoreResponse) -> Void) {
        if endpoint.shouldMock, let mockResponse = endpoint.mockResponse {
            NetworkCoreLogger.log(endpoint, mockResponse, configuration.logType)
            completion(mockResponse)
        }
        
        guard let request = endpoint.createRequest() else {
            let errorResponse = NetworkCoreResponse.internalError
            NetworkCoreLogger.log(endpoint, errorResponse, configuration.logType)
            completion(errorResponse)
            return
        }
        executeRequest(request as URLRequest, for: endpoint, and: completion)
    }
}

extension NetworkCore {
    
    func executeRequest(_ request: URLRequest, for endpoint: NetworkCoreEndpoint, and completion: @escaping (_ response: NetworkCoreResponse) -> Void) {
        execute(request) { [weak self] data, response, error in
            guard let self = self else {
                let errorResponse = NetworkCoreResponse.internalError
                NetworkCoreLogger.log(endpoint, errorResponse, .min)
                completion(errorResponse)
                return
            }
            self.handleResponse(endpoint, data, response, error) { response in
                completion(response)
            }
        }
    }
    
    func execute(_ request: URLRequest, with completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void ) {
        dispatchGroup.enter()
        let session = createSession()
        let queue = DispatchQueue(label: dispatchQueueName, attributes: .concurrent, target: nil)
        queue.async(group: dispatchGroup) { [weak self] in
            guard let self = self else  {
                completion(nil, nil, NetworkCoreErrorType.internal)
                return
            }
            self.task = session.dataTask(with: request, completionHandler: { data, response, error in
                session.finishTasksAndInvalidate()
                completion(data, response, error)
            })
            self.task?.resume()
            self.dispatchGroup.leave()
        }
    }
    
    func handleResponse(_ endpoint: NetworkCoreEndpoint, _ data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (_ response: NetworkCoreResponse) -> Void) {
        guard let httpResponse = response as? HTTPURLResponse else {
            if let error = error {
                let errorResponse = NetworkCoreResponse.errorWithCode(error._code)
                NetworkCoreLogger.log(endpoint, errorResponse, configuration.logType)
                completion(errorResponse)
            } else {
                let errorResponse = NetworkCoreResponse.noConnection
                NetworkCoreLogger.log(endpoint, errorResponse, configuration.logType)
                completion(errorResponse)
            }
            return
        }
        
        let response = NetworkCoreResponse(statusCode: httpResponse.statusCode,
                                           data: data ?? Data(),
                                           headers: httpResponse.allHeaderFields,
                                           handler: NetworkCoreHandler(statusCode: httpResponse.statusCode))
        NetworkCoreLogger.log(endpoint, response, configuration.logType)
        completion(response)
    }
    
    func createSession() -> URLSession {
        return URLSession(configuration: .default)
    }
}
