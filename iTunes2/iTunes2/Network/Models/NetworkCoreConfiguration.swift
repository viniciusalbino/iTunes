
import Foundation

struct NetworkCoreConfiguration {
    let logType: NetworkCoreLogType
    
    init(logType: NetworkCoreLogType = .min) {
        self.logType = logType
    }
}
