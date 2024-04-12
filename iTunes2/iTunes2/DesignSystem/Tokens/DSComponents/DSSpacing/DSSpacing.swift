
import Foundation

public enum Spacing: String {
    case spacingXs
    case spacingSm
    case spacingMd
    case spacingLg
    case spacingXl
    case none
    
    fileprivate var value: Spacing {
        return .init(rawValue: self.rawValue) ?? .none
    }
}

public struct DSSpacing {
    public var spacingValue: CGFloat = 12
    public var enumValue: Spacing = .spacingXs
    
    init() {
    }
    
    init(name: String, value: String) {
        enumValue = Spacing(rawValue: name) ?? .spacingXs
        let formatter = NumberFormatter.usNumberFormatter()
        guard let number = formatter.number(from: value) else {
            spacingValue = 12
            return
        }
        spacingValue = CGFloat(truncating: number)
    }
}

public extension CGFloat {
    static func spacing(_ spacing: Spacing) -> CGFloat {
        return TokenManager.shared.getSpacingFor(name: spacing).spacingValue
    }
}
