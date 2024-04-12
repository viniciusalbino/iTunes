
import UIKit

protocol ViewControllerBuilder: AnyObject {
    func build() -> UIViewController
}
