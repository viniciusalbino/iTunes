
import Foundation

extension Double {
    func toCurrencyFormat(currency: String? = nil) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let currencyCode = currency {
            formatter.currencyCode = currencyCode
        }
        return formatter.string(from: NSNumber(value: self))
    }
}
