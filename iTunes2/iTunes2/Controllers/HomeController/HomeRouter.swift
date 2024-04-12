
import Foundation
import UIKit

final class HomeRouter {
    // MARK: - Private properties -
    /// The view controller from which the routing originates.
    weak var viewController: UIViewController?
    /// A reference to the tab bar controller, if any, responsible for handling tab-based navigation.
    private weak var tabBarController: TabBarController?
    
    // MARK: - Module setup -
    /// Initializes a new instance of `HomeRouter`.
    ///
    /// - Parameters:
    ///   - viewController: The view controller from which routing originates. Default is nil.
    ///   - tabBarController: The tab bar controller for tab-based navigation. Default is nil.
    init(viewController: UIViewController? = nil, tabBarController: TabBarController? = nil) {
        self.viewController = viewController
        self.tabBarController = tabBarController
    }
}

// MARK: - HomeRouterProtocol
/// An extension that conforms to `HomeRouterProtocol` for handling routing requests.
extension HomeRouter: HomeRouterProtocol {
    /// Loads the item detail screen for a specific `ITunesItem`.
    ///
    /// - Parameters:
    ///   - content: The `ITunesItem` for which the detail screen should be loaded.
    func loadItemDetailController(content: ITunesItem) {
        // Try to get the active navigation controller from the tab bar
        guard let navigationController = tabBarController?.selectedViewController?.children.first?.navigationController else {
            return
        }
        // Build the detail controller for the specified content
        let controller = ItemDetailControllerBuilder(content: content).build()
        
        // Push the detail controller onto the navigation stack
        DispatchQueue.main.async {
            navigationController.pushViewController(controller, animated: true)
        }
    }
}
