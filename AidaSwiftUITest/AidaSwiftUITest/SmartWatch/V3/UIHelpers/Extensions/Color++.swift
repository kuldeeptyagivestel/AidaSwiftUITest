//
//  SwiftUIColor++.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 02/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension Color {
    static let themeColor = Color(#colorLiteral(red: 0.9969399571, green: 0.4133140743, blue: 0.126126498, alpha: 1)) //FE6920
    
    //MARK: Table, Cells BG Colors
    static let cellBgColor = Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1))
    static let whiteBgColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) //White color
    static let scrollViewBgColor = Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)) //F5F5F5: Off White
    
    //MARK:  Button Colors
    static let btnBgColor = Color(#colorLiteral(red: 0.9969399571, green: 0.4133140743, blue: 0.126126498, alpha: 1))
    static let btnTitleColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    static let btnSecondaryBgColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    static let btnSecondaryTitleColor = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1))
    static let btnSecondaryBorderColor = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1))

    static let disableButton = Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1))
    
    //MARK: -  Navigation Bar Colors
    static let backButtonItem = Color(#colorLiteral(red: 0.9969399571, green: 0.4133140743, blue: 0.126126498, alpha: 1))
    static let navigationTitle = Color(#colorLiteral(red: 0.9969399571, green: 0.4133140743, blue: 0.126126498, alpha: 1))
    
    //MARK: - Tag Color
    static let tagColor = Color(#colorLiteral(red: 0.8470588235, green: 0.1215686275, blue: 0.1490196078, alpha: 1))
    static let cellNavigationArrowColor = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1))
    static let clockColor = Color(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1))
    static let cellColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    //MARK:  Toggle Colors
    static let toggleOnColor = Color(#colorLiteral(red: 0.9969399571, green: 0.4133140743, blue: 0.126126498, alpha: 1))
    static let toggleOffColor = Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1))
    
    //MARK: - Title Colors
    static let titlePrimary = Color(#colorLiteral(red: 0.2392156863, green: 0.231372549, blue: 0.231372549, alpha: 1))
    
    //MARK: - Battery Cell
    static let batteryCell = Color(#colorLiteral(red: 0.3294117647, green: 0.8196078431, blue: 0.7450980392, alpha: 1))
    static let batteryLowCell = Color(#colorLiteral(red: 0.8470588235, green: 0.1215686275, blue: 0.1490196078, alpha: 1))
    static let batteryIcon = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1))
    
    //MARK:  Label Colors
    static let lblPrimary = Color(#colorLiteral(red: 0.2392156863, green: 0.231372549, blue: 0.231372549, alpha: 1))
    static let lblSecondary = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1))
    static let disabledColor = Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1))
    static let labelNofav = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    
    //MARK:  Description Colors
    static let descriptionPrimary = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1))
    static let descriptionSecondary = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1))

    //MARK:  Popup Colors
    static let popupBGColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    static let popupLblPrimary = Color(#colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03921568627, alpha: 1)) //#0A0A0A
    static let popupLblSecondary = Color(#colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03921568627, alpha: 1))
    static let popupLblTertiary = Color(#colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03921568627, alpha: 1))
    static let progressColor = Color(#colorLiteral(red: 0.9969399571, green: 0.4133140743, blue: 0.126126498, alpha: 1))
    static let crossButtonColor = Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1))
    
    //MARK:  Selection and Removal Color
    static let checkMarkColor = Color(#colorLiteral(red: 0.9969399571, green: 0.4133140743, blue: 0.126126498, alpha: 1))
    static let radioSelectionColor = Color(#colorLiteral(red: 0.9969399571, green: 0.4133140743, blue: 0.126126498, alpha: 1))
    
    static let removeColor = Color(#colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1))
    static let addColor = Color(#colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1))
    
    //MARK:  Gradient Colors
    static let gradientStartColor = Color(#colorLiteral(red: 0.9764705882, green: 0.8588235294, blue: 0.8039215686, alpha: 1))
    static let gradientEndColor = Color(#colorLiteral(red: 1, green: 0.9529411765, blue: 1, alpha: 1))
    
    //MARK: Picker Colors
    static let pickerSelectorColor = Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1))
}

//MARK: - HEX/RGBA CONVERSION
extension Color {
    func hexToRGBA(hex: String, alpha: CGFloat = 1.0) -> UIColor? {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
 
        var rgb: UInt64 = 0
 
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
 
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
 
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// Creates a SwiftUI `Color` from a hexadecimal color code (HEX).
    ///
    /// - Parameters:
    ///   - hex: The hexadecimal color code (e.g., "#FF5733").
    ///   - opacity: The opacity value for the color, ranging from 0.0 (fully transparent) to 1.0 (fully opaque). Default is 1.0.
    /// - Returns: A SwiftUI `Color` instance representing the specified color.
    static func fromHex(_ hex: String, opacity: Double = 1.0) -> Color {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
 
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
 
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
 
        return Color(red: red, green: green, blue: blue, opacity: opacity)
    }
    
    /// Creates a `UIColor` from a hexadecimal color code (HEX).
    ///
    /// - Parameters:
    ///   - hex: The hexadecimal color code (e.g., "#FF5733").
    ///   - alpha: The alpha (opacity) value for the color, ranging from 0.0 (fully transparent) to 1.0 (fully opaque). Default is 1.0.
    /// - Returns: A `UIColor` instance representing the specified color.
    static func fromHex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor? {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
 
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
 
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
 
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
