
import Foundation
import XCTest

@testable import iTunes2

class DictionaryExtensionsTests: XCTestCase {
    var tempURL: URL?
    
    override func setUp() {
        super.setUp()
    }
    
    func testConcateningValues() {
        var dictionary: [String: Any] = ["a": 1, "b": "string"]
        let expected: [String: Any] = ["a": 1, "b": "string", "c": true]
        dictionary += ["c": true]
        XCTAssertTrue(NSDictionary(dictionary: dictionary).isEqual(to: expected))
    }
    
    func testDictionaryMerge() {
        let firstDict = ["test": "Michael"]
        let secondDict = ["name": "Lebron"]
        
        let newDict = firstDict.merge(dict: secondDict)
        XCTAssertEqual(newDict["test"], "Michael")
        XCTAssertEqual(newDict["name"], "Lebron")
    }
    
    func testAddDictionary() {
        var firstDict = ["test": "Michael"]
        let secondDict = ["name": "Lebron"]
        
        _ = firstDict.addDictionary(dictionaryToAppend: secondDict)
        
        XCTAssertEqual(firstDict["test"], "Michael")
        XCTAssertEqual(firstDict["name"], "Lebron")
    }
}
