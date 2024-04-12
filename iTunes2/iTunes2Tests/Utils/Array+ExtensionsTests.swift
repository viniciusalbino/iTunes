//
//  Array+ExtensionsTests.swift
//  iTunes2Tests
//
//  Created by Vinicius Albino on 19/08/23.
//

import Foundation
import XCTest

@testable import iTunes2

class ArrayExtensionsTests: XCTestCase {
    
    let arrayObject = [1, 2, 3, 4, 5, 5]
    
    override func setUp() {
        super.setUp()
    }
    
    func testObject() {
        XCTAssertNotNil(arrayObject.object(index: 0))
        XCTAssertNotNil(arrayObject.object(index: 2))
        XCTAssertNil(arrayObject.object(index: 10))
    }
    
    func testIsNotEmpty() {
        XCTAssertTrue(!arrayObject.isEmpty)
        XCTAssertFalse(arrayObject.isEmpty)
    }
}
