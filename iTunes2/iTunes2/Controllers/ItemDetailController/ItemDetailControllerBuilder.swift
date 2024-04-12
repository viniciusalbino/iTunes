
import Foundation
import UIKit

final class ItemDetailControllerBuilder: ViewControllerBuilder {
    var content: ITunesItem
    
    init(content: ITunesItem) {
        self.content = content
    }
    
    func build() -> UIViewController {
        let router = ItemDetailRouter()
        let interactor = ItemDetailInteractor()
        let presenter = ItemDetailPresenter(router: router, interactor: interactor)
        presenter.setContent(data: self.content)
        interactor.output = presenter
        let viewController = ItemDetailViewController(presenter: presenter)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
