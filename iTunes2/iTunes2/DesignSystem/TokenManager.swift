
import Foundation
import UIKit

final class TokenManager {
    static let shared = TokenManager()
    init() {}
    
    var components = Properties()
    
    private var colors: [String: DSColor] = [:]
    private var fontSizes: [String: DSFontSize] = [:]
    private var spacings: [String: DSSpacing] = [:]
    
    private func setTokenSheet() {
        components = TokensParser.shared.getAllTokens(tokenSheet: "DSTokens")
        storeProperties()
    }
    
    private func storeProperties() {
        components.colors().forEach { color in
            colors.addDictionary(dictionaryToAppend: [color.enumValue.rawValue: color])
        }
        
        components.fontSizes().forEach { fontSize in
            fontSizes.addDictionary(dictionaryToAppend: [fontSize.enumValue.rawValue: fontSize])
        }
        
        components.spacings().forEach { spacing in
            spacings.addDictionary(dictionaryToAppend: [spacing.enumValue.rawValue: spacing])
        }
    }
    
    // MARK: - Public
    
    public func setup() {
        setTokenSheet()
    }
    
    public func getColorFor(name: CustomColor) -> DSColor {
        guard let color = colors[name.rawValue] else {
            return DSColor()
        }
        return color
    }
    
    public func getSpacingFor(name: Spacing) -> DSSpacing {
        guard let spacing = spacings[name.rawValue] else {
            return DSSpacing()
        }
        return spacing
    }
    
    public func getFontSizeFor(name: FontSize) -> DSFontSize {
        guard let font = fontSizes[name.rawValue] else {
            return DSFontSize()
        }
        return font
    }
}
