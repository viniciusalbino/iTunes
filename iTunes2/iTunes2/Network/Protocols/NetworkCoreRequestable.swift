
import Foundation

protocol NetworkCoreRequestable {
    associatedtype DataType: Codable
    
    var network: NetworkCore { get }
    
    var endpoint: NetworkCoreEndpoint { get }
    
    func request(completion: @escaping (Result<DataType, NetworkCoreErrorType>) -> Void)
}
