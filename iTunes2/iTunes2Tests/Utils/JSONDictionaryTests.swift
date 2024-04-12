
import Foundation
import XCTest

@testable import iTunes2

class DictionaryTests: XCTestCase {
    
    func testMerge() {
        var dict1 = ["a": 1, "b": 2]
        let dict2 = ["b": 3, "c": 4]
        
        dict1 = dict1.merge(dict: dict2)
        
        XCTAssertEqual(dict1, ["a": 1, "b": 3, "c": 4])
    }
    
    func testAddDictionary() {
        var dict1 = ["a": 1, "b": 2]
        let dict2 = ["b": 3, "c": 4]
        
        dict1.addDictionary(dictionaryToAppend: dict2)
        
        XCTAssertEqual(dict1, ["a": 1, "b": 3, "c": 4])
    }
    
    func testFormUnion() {
        var dict1 = ["a": 1, "b": 2]
        let dict2 = ["b": 3, "c": 4]
        
        dict1.formUnion(dict2)
        
        XCTAssertEqual(dict1, ["a": 1, "b": 3, "c": 4])
    }
    
    func testUnion() {
        let dict1 = ["a": 1, "b": 2]
        let dict2 = ["b": 3, "c": 4]
        let result = dict1.union(dict2)
        
        XCTAssertEqual(result, ["a": 1, "b": 3, "c": 4])
    }
    
    func testPlusOperator() {
        let dict1 = ["a": 1, "b": 2]
        let dict2 = ["b": 3, "c": 4]
        let result = dict1 + dict2
        
        XCTAssertEqual(result, ["a": 1, "b": 3, "c": 4])
    }
}
