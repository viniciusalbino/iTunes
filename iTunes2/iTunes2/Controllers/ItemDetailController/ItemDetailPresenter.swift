
import Foundation

final class ItemDetailPresenter {
    // MARK: -  Viper Properties
    weak var viewController: ItemDetailPresenterOutputProtocol?
    private let router: ItemDetailRouterProtocol
    private let interactor: ItemDetailInteractorInputProtocol
    
    // MARK: - Properties
    private var content: ITunesItem?
    private var objectDetail: [ItemDetailCellDTO] = []
    
    // MARK: - init
    init(router: ItemDetailRouterProtocol, interactor: ItemDetailInteractorInputProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    public func setContent(data: ITunesItem) {
        self.content = data
    }
}

// MARK: - Presenter Input Protocol
extension ItemDetailPresenter: ItemDetailPresenterInputProtocol {
    func headerDTO() -> DetailHeaderViewDTO? {
        guard let content = content, let price = content.trackPrice.toCurrencyFormat(currency: content.currency) else {
            return nil
        }
        return DetailHeaderViewDTO(imageURL: content.artworkUrl100, name: content.trackName, subtitle: content.artistName, price: price)
    }
    
    func loadContent() {
        content?.trackDetails.forEach { key, value in
            objectDetail.append(ItemDetailCellDTO(title: key, content: value))
        }
        
        didLoadContent()
    }
}

// MARK: - Presenter Output Protocol
extension ItemDetailPresenter: ItemDetailInteractorOutputProtocol {
    func didLoadContent() {
        viewController?.reloadData(data: objectDetail)
    }
}

struct ItemDetailCellDTO: Hashable {
    var title: String
    var content: String
    
    func formattedText() -> String {
        return "\(title): \(content)"
    }
}
