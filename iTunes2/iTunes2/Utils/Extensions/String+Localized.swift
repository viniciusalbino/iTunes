
import Foundation

extension String {
    public func localized(Withcomment comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    public func localized() -> String {
        return localized(Withcomment: "")
    }
}
