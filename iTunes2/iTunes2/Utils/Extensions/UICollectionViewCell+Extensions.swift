
import Foundation
import UIKit

extension UICollectionViewCell {
    static var cellID: String {
        return String(describing: self)
    }
    
    func removeViews() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
}
