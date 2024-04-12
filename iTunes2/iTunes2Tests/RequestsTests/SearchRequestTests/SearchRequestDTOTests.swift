
import Foundation
import XCTest
@testable import iTunes2

class SearchRequestDTOTests: XCTestCase {
    
    func testMediaTypeRawValues() {
        XCTAssertEqual(MediaType.movie.rawValue, "movie")
        XCTAssertEqual(MediaType.music.rawValue, "music")
        XCTAssertEqual(MediaType.audiobook.rawValue, "audiobook")
        XCTAssertEqual(MediaType.podcast.rawValue, "podcast")
    }
    
    func testAsDictionaryMapping() {
        let searchDTO = SearchRequestDTO(term: "testTerm", media: .music, limit: 10, offset: 5)
        
        let expectedDictionary: [String: String] = [
            "term": "testTerm",
            "media": "music",
            "limit": "10",
            "offset": "5"
        ]
        
        XCTAssertEqual(searchDTO.asDictionary, expectedDictionary)
    }
}
