
import Foundation
import UIKit

let cachedImages = NSCache<NSString, UIImage>()
extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString:String) {
        
        self.image = nil
        
        if let cacheImage = cachedImages.object(forKey: urlString as NSString)  {
            // COMMENTED FOR DEBUG PURPOSES
//            print("Fetching profile image from cache...")
            self.image = cacheImage
            return
        }
        
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data:data!){
                    cachedImages.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            }
        })
        task.resume()
    }
}
