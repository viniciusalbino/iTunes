
import Foundation

struct Response: Mappable {
    var resultCount: Int
    var results: [ITunesItem]
}
