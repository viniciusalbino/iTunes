
import Foundation

struct Properties: Mappable {
    
    var tokens: [DesignToken] = []
    
    enum CodingKeys: String, CodingKey {
        case tokens = "properties"
    }
    
    public func colors() -> [DSColor] {
        return tokens.filter { $0.type == .color }.compactMap { DSColor(colorHex: $0.value, value: $0.name) }
    }
    
    public func fontSizes() -> [DSFontSize] {
        return tokens.filter { $0.category == .fontSize }.compactMap { DSFontSize(name: $0.name, value: $0.value) }
    }
    
    public func spacings() -> [DSSpacing] {
        return tokens.filter { $0.category == .spacing }.compactMap { DSSpacing(name: $0.name, value: $0.value) }
    }
}
