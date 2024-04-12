
import Foundation

extension Encodable {
    func encoded() -> Data {
        guard let encoded = try? JSONEncoder().encode(self) else {
            return Data()
        }
        return encoded
    }
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
