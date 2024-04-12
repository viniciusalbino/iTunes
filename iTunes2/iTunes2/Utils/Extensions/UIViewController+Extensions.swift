
import Foundation
import UIKit

extension UIViewController {
    func startLoading() {
        let loadingView = UIView(frame: view.bounds)
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        loadingView.tag = 100
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loadingIndicator.center = view.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        
        loadingView.addSubview(loadingIndicator)
        
        view.addSubview(loadingView)
    }
    
    func stopLoading() {
        for view in self.view.subviews {
            if view.tag == 100 {
                view.removeFromSuperview()
            }
        }
    }
    
    public func performUIUpdate(using closure: @escaping () -> Void) {
        // If we are already on the main thread, execute the closure directly
        if Thread.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async(execute: closure)
        }
    }
    
    func showAlert(title: String, message: String, actions: [(title: String, callback: (() -> Void)?)]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: .default) { _ in
                action.callback?()
            }
            alertController.addAction(alertAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
