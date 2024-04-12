
import Foundation

public extension NumberFormatter {
    static func usNumberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }
}
