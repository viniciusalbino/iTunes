
import Foundation
import UIKit

public enum CustomColor: String, CaseIterable, Mappable {
    case primaryColor
    case secondaryColor
    case textPrimaryColor
    case textSecondaryColor
    
    case none
    case clear
    
    public func color() -> UIColor {
        switch self {
        case .clear, .none:
            return .clear
        default:
            return TokenManager.shared.getColorFor(name: self).color
        }
    }
}

public struct DSColor {
    public var hexString: String = ""
    public var enumValue: CustomColor = .clear
    public var color: UIColor = .clear
    
    init() { }
    
    public init(colorHex: String, value: String) {
        hexString = colorHex
        enumValue = CustomColor(rawValue: value) ?? .clear
        color = UIColor(hex: colorHex)
    }
}

public extension UIColor {
    class func designSystem(_ colorEnum: CustomColor) -> UIColor {
        return colorEnum.color()
    }
}
