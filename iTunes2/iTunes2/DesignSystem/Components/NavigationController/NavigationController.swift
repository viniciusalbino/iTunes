
import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        consistToTheme()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        consistToTheme()
    }
    
    internal func consistToTheme() {
        let buttonAppearance = UIBarButtonItemAppearance()
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.designSystem(.textPrimaryColor)]
        buttonAppearance.normal.titleTextAttributes = attributes
        buttonAppearance.highlighted.titleTextAttributes = attributes
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .designSystem(.primaryColor)
        let image = UIImage(systemName: "chevron.backward")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.designSystem(.textPrimaryColor)]
        appearance.buttonAppearance = buttonAppearance
        appearance.backButtonAppearance = buttonAppearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        UINavigationBar.appearance().tintColor = UIColor.designSystem(.textPrimaryColor)
    }
}
