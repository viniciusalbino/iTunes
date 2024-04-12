
import Foundation

extension NetworkCore {
    static let defaultConfig = NetworkCoreConfiguration(logType: .min)
    static let defaultNetwork = NetworkCore(configuration: defaultConfig)
}

extension NetworkCoreEndpoint {
    var baseApiURL: String {
        return "https://itunes.apple.com/"
    }
    
    var baseURL: URL {
        return URL(string: baseApiURL)!
    }
}
