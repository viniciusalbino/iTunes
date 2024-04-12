
import UIKit
import Foundation

public enum FontSize: String {
    case fontSizeSm
    case fontSizeMd
    case fontSizeLg
    case fontSizeXl
    
    fileprivate var value: FontSize {
        return .init(rawValue: rawValue)!
    }
}

public struct DSFontSize {
    public var fontSize: CGFloat = 12
    public var enumValue: FontSize = .fontSizeSm
    
    init() {
    }
    
    init(name: String, value: String) {
        enumValue = FontSize(rawValue: name) ?? .fontSizeSm
        let formatter = NumberFormatter.usNumberFormatter()
        guard let number = formatter.number(from: value) else {
            fontSize = 12
            return
        }
        fontSize = CGFloat(truncating: number)
    }
}

public extension CGFloat {
    static func fontSize(_ size: FontSize) -> CGFloat {
        return TokenManager.shared.getFontSizeFor(name: size).fontSize
    }
}
