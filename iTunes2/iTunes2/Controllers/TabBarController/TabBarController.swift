
import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    static var sharedInstance: TabBarController? {
        let window = UIApplication.shared.currentWindow
        return window?.rootViewController as? TabBarController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTabBar(viewControllers: [HomeControllerBuilder().build()], tabs: [.home])
    }
    
    func loadTabBar(viewControllers: [UIViewController], tabs: [TabBarItem]) {
        var tempViewControllers = [UIViewController]()
        for (index, viewController) in viewControllers.enumerated() {
            guard let tabItem = tabs.object(index: index) else {
                return
            }
            let tabBarItem = UITabBarItem(title: tabItem.title, image: tabItem.icon, tag: index)
            
            viewController.tabBarItem = tabBarItem
            tempViewControllers.append(viewController)
        }
        
        self.viewControllers = tempViewControllers
        consistToTheme()
    }
    
    func customizeTabBarItems() {
        //use this to reorder or add items to the tabbar
        //just make sure that in storyboard the order is respected
        let icons: [TabBarItem] = [.home]
        
        for (index, icon) in icons.enumerated() {
            let tabBarIcon = self.tabBar.items?.object(index: index)
            tabBarIcon?.image = icon.icon
            tabBarIcon?.title = icon.title
            tabBarIcon?.selectedImage = icon.icon
            if let barButton = self.tabBar.subviews.filter({ $0.accessibilityLabel == icon.title }).first {
                barButton.accessibilityIdentifier = "UITabBar.\(icon.accessibilityIdentifier)"
            }
        }
        
        consistToTheme()
    }
    
    func switchTabBar(selected: TabBarItem) {
        self.selectedIndex = selected.rawValue
    }
    
    internal func consistToTheme() {
        tabBar.barTintColor = .designSystem(.primaryColor)
        tabBar.tintColor = .designSystem(.textPrimaryColor)
        tabBar.unselectedItemTintColor = .lightText
        tabBar.isTranslucent = false
        
        tabBar.items?.forEach { item in
            item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.designSystem(.textPrimaryColor)], for: .selected)
        }
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .designSystem(.primaryColor)
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
}
