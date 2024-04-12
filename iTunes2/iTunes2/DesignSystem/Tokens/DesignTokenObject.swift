
import Foundation

struct DesignTokenObject: Mappable {
    var properties: [DesignToken]
}

struct DesignToken: Mappable {
    var type: TokenType?
    var category: TokenCategory?
    var name: String
    var value: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case category
        case name
        case value
    }
}
