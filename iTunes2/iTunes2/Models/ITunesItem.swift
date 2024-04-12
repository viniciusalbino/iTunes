
import Foundation

struct ITunesItem: Mappable, Hashable {
    var wrapperType: String
    var kind: String
    var artistId: Int
    var collectionId: Int
    var trackId: Int
    var artistName: String
    var collectionName: String
    var trackName: String
    var collectionCensoredName: String
    var trackCensoredName: String
    var collectionArtistId: Int?
    var collectionArtistName: String?
    var artistViewUrl: String
    var collectionViewUrl: String
    var trackViewUrl: String
    var previewUrl: String
    var artworkUrl30: String
    var artworkUrl60: String
    var artworkUrl100: String
    var collectionPrice: Double
    var trackPrice: Double
    var releaseDate: String
    var collectionExplicitness: String
    var trackExplicitness: String
    var discCount: Int
    var discNumber: Int
    var trackCount: Int
    var trackNumber: Int
    var trackTimeMillis: Int
    var country: String
    var currency: String
    var primaryGenreName: String
    var isStreamable: Bool
    
    var trackDetails: [String: String] {
        return ["Collection Name": collectionName,
                "Release Date": releaseDate.formattedDate() ?? "",
                "Genre": primaryGenreName,
                "Track Time": trackTimeMillis.formatToMinutesAndSeconds()]
    }
}
