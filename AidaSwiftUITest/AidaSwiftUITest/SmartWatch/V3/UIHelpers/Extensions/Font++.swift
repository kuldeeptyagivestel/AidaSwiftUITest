//
//  UIFont+CustomFonts.swift
//  Arc
//
//  Created by Kuldeep Tyagi on 23/08/23.
//

import SwiftUI

// Enum for different font styles
enum FontStyle: String {
    /// Available for both Fonts: Muli and OpenSans
    case light = "Light"
    case lightItalic = "LightItalic"
    case regular = "Regular"
    case italic = "Italic"
    case semibold = "Semibold"
    case semiBoldItalic = "SemiBoldItalic"
    case bold = "Bold"
    case boldItalic = "BoldItalic"
    case extraBold = "ExtraBold"
    case extraBoldItalic = "ExtraBoldItalic"
    
    /// These fonts are only available for Muli but not OpenSans
    case extraLight = "ExtraLight"
    case extraLightItalic = "ExtraLightItalic"
    case black = "Black"
    case blackItalic = "BlackItalic"
}

// Enum for custom fonts with fallback support
enum CustomFont: String {
    case muli = "Muli"
    case openSans = "OpenSans"
    
    var defaultSize: CGFloat {
        UIFont.preferredFont(forTextStyle: .body).pointSize
    }
    
    static var `default`: Font {
        CustomFont.muli.font(style: .regular, size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    
    // SwiftUI Font with Fallback Handling
    func font(style: FontStyle, size: CGFloat) -> Font {
        let fontName = "\(self.rawValue)-\(adjustedStyle(for: style).rawValue)"
        return Font.custom(fontName, size: size)
    }
    
    // UIKit UIFont with Fallback Handling
    func font(style: FontStyle, size: CGFloat) -> UIFont {
        let fontName = "\(self.rawValue)-\(adjustedStyle(for: style).rawValue)"
        return UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size)
    }
    
    // Method to adjust the font style if not available in the selected font family
    private func adjustedStyle(for style: FontStyle) -> FontStyle {
        switch (self, style) {
        case (.openSans, .extraLight): return .light
        case (.openSans, .extraLightItalic): return .lightItalic
        case (.openSans, .black): return .extraBold
        case (.openSans, .blackItalic): return .extraBoldItalic
        default: return style
        }
    }
}

// Extension on Font to use custom fonts easily in SwiftUI
extension Font {
    static func custom(_ font: CustomFont = .muli, style: FontStyle = .regular, size: CGFloat) -> Font {
        font.font(style: style, size: size)
    }
}

// Extension on UIFont to use custom fonts easily in UIKit
extension UIFont {
    static func custom(_ font: CustomFont = .muli, style: FontStyle = .regular, size: CGFloat) -> UIFont {
        font.font(style: style, size: size)
    }
}
