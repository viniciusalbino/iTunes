
import Foundation

final class TokensParser {
    static let shared = TokensParser()
    private var currentJSON: JSONDictionary?
    
    func getAllTokens(tokenSheet: String) -> Properties {
        guard let designTokens = parseDesignTokens(tokenFile: tokenSheet) else {
            fatalError("error parsing the DS token json")
        }
        
        return Properties(tokens: designTokens.properties)
    }
    
    private func parseDesignTokens(tokenFile: String) -> DesignTokenObject? {
        let jsonData = JSONParser().jsonDataFor(fileName: tokenFile, bundle: Bundle.main)
        return jsonData <--> DesignTokenObject.self
    }
}
