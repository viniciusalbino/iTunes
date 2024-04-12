
import Foundation
import UIKit

final class HomeControllerBuilder: ViewControllerBuilder {
    
    func build() -> UIViewController {
        let router = HomeRouter(tabBarController: TabBarController.sharedInstance)
        let interactor = HomeInteractor()
        let presenter = HomePresenter(router: router, interactor: interactor)
        interactor.output = presenter
        let viewController = HomeViewController(presenter: presenter)
        presenter.viewController = viewController
        router.viewController = viewController
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}
