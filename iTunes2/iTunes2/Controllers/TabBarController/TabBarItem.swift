
import Foundation
import UIKit

enum TabBarItem: Int {
    case home = 0
    case search = 1
    
    var title: String {
        switch self {
        case .home:
            return "Home".localized()
        case .search:
            return "Search".localized()
        }
    }
    
    var icon: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "circle.grid.3x3.circle")!
        case .search:
            return UIImage(systemName: "magnifyingglass.circle")!
        }
    }
    
    var accessibilityIdentifier: String {
        return self.title.uppercased()
    }
}
