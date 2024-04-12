
import Foundation
import  XCTest

@testable import iTunes2

class NetworkCoreMappableTests: XCTestCase {
    let userA = UserMock(name: "User A", age: 20)
    let userB = UserMock(name: "User B", age: 30)
    
    func testEncodeAndDecodeSingleModel() {
        let data = userA.encoded()
        XCTAssertFalse(data.isEmpty)
        XCTAssertEqual(String(data: data, encoding: .utf8), "{\"name\":\"User A\",\"age\":20}")
        let decoded = data <--> UserMock.self
        XCTAssertNotNil(decoded)
        XCTAssertEqual(decoded, userA)
    }
    
    func testEncodeAndDecodeArrayModels() {
        let users = [userA, userB]
        let data = users.encoded()
        XCTAssertFalse(data.isEmpty)
        XCTAssertEqual(String(data: data, encoding: .utf8), "[{\"name\":\"User A\",\"age\":20},{\"name\":\"User B\",\"age\":30}]")
        let decoded = data <--> [UserMock].self
        XCTAssertNotNil(decoded)
        XCTAssertEqual(decoded, users)
    }
}
