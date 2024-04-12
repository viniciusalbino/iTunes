
import Foundation
import UIKit

// MARK: - Typealiases
/// An alias representing the diffable data source used for the `HomeViewController`.
fileprivate typealias ItunesItemDataSource =  UICollectionViewDiffableDataSource<HomeViewController.Section, ITunesItem>
/// An alias representing the diffable data source snapshot used in the `HomeViewController`.
fileprivate typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<HomeViewController.Section, ITunesItem>

class HomeViewController: UIViewController {
    
    // MARK: - Nested Enumerations
    /// Enumeration of all sections in the HomeViewController.
    fileprivate enum Section {
        case main
    }
    
    // MARK: - Viper Properties
    /// The presenter responsible for the business logic and data retrieval.
    private let presenter: HomePresenterInputProtocol
    
    // MARK: - Private Properties
    /// The main collection view displaying the iTunes items.
    private var collectionView: UICollectionView!
    /// The data source feeding the collection view.
    private var dataSource: ItunesItemDataSource?
    /// A snapshot of the current state of the data source.
    private var snapshot: DataSourceSnapshot?
    /// Layout for the `collectionView`.
    private lazy var homeCompLayout: HomeLayout = HomeLayout()
    private var isLoading = false
    
    // MARK: - Initialization
    /// Initializes a new instance of `HomeViewController`.
    ///
    /// - Parameter presenter: An instance of the presenter to feed the view controller.
    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Required initializer (disabled).
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadContent()
    }
    
    // MARK: - Setup
    /// Sets up the view controller and its subviews.
    private func setup() {
        title = "Home".localized()
        view.backgroundColor = .white
        
        setupViews()
        configureDataSource()
    }
    
    /// Initiates a content loading operation from the API and show the loading screen
    private func loadContent() {
        // Check if already loading
        guard !isLoading else { return }
        
        isLoading = true
        
        performUIUpdate {
            self.startLoading()
        }
        presenter.loadContent(term: "U2")
    }
    
    /// Sets up all views required for the view controller.
    private func setupViews() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: homeCompLayout.layout)
        collectionView.delegate = self
        collectionView.register(SongCell.self, forCellWithReuseIdentifier: SongCell.reuseIdentifer)
        collectionView.backgroundColor = .clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        
        setupConstraints()
    }
    
    /// Sets up constraints for all views in the view controller.
    private func setupConstraints() {
        collectionView.pinToBounds(of: view)
    }
    
    /// Configures the data source for the collection view.
    private func configureDataSource() {
        dataSource = ItunesItemDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> SongCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SongCell.reuseIdentifer, for: indexPath) as! SongCell
            if let content = self.presenter.itemForRowAt(indexPath.row) {
                cell.fill(dto: content)
            }
            return cell
        })
        
        snapshot = DataSourceSnapshot()
        snapshot?.appendSections([Section.main])
    }
    
    // MARK: - Helper Functions
    /// Displays an alert to the user.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message body of the alert.
    private func showAlert(title: String, message: String) {
        performUIUpdate {
            self.showAlert(title: title, message: message, actions: [
                (title: "OK".localized(), callback: {
                    print("OK button tapped")
                })
            ])
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.selectItemAt(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard collectionView.numberOfSections > 0, collectionView.numberOfItems(inSection: 0) > 0, self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height), !isLoading else {
            return
        }
        loadContent()
    }
}

// MARK: - HomePresenterOutputProtocol
/// Extension conforming to the `HomePresenterOutputProtocol`.
extension HomeViewController: HomePresenterOutputProtocol {
    /// Updates the UI with newly loaded data.
    func reloadData(data: [ITunesItem]) {
        isLoading = false
        
        performUIUpdate {
            self.stopLoading()
            self.snapshot?.appendItems(data)
            self.dataSource?.apply(self.snapshot!, animatingDifferences: true)
        }
    }
    
    /// Displays an error message when loading data fails.
    func errorLoadingData(error: Error) {
        isLoading = false
        showAlert(title: "Error".localized(), message: "There was an error on loading content.".localized())
    }
}
