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
    static let whiteBgColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) //#FFFFFF: Pure White color
    static let viewBgColor = Color(#colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)) //#FAFAFA: Almost White
    static let scrollViewBgColor = Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)) //F5F5F5: Off White
    
    //MARK:  Button Colors
    static let btnBgColor = Color(#colorLiteral(red: 0.9960784314, green: 0.4117647059, blue: 0.1254901961, alpha: 1)) //# FE6920
    static let btnTitleColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) // #FFFFFF : White
    static let btnSecondaryBgColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) // #FFFFFF : White
    static let btnSecondaryTitleColor = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1))
    static let btnSecondaryBorderColor = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1))
    static let mainColor = Color(#colorLiteral(red: 1, green: 0.4705882353, blue: 0.1921568627, alpha: 1)) // #FF7831 MainOrange
    static let disableButton = Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1))
    
    //MARK: -  Navigation Bar Colors
    static let backButtonItem = Color(#colorLiteral(red: 0.9960784314, green: 0.4117647059, blue: 0.1254901961, alpha: 1)) //# FE6920
    static let navigationTitle = Color(#colorLiteral(red: 0.9969399571, green: 0.4133140743, blue: 0.126126498, alpha: 1)) //# FE6920
    
    //MARK: - Tag Color
    static let tagColor = Color(#colorLiteral(red: 0.8470588235, green: 0.1215686275, blue: 0.1490196078, alpha: 1)) // #D81F26
    static let cellNavigationArrowColor = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)) //#676767 DarkGray
    static let clockColor = Color(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1))
    
    //MARK: - CELL
    static let cellColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    static let cellDividerColor = Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)) //#D0D0D0
    
    //MARK:  Toggle Colors
    static let toggleOnColor = Color(#colorLiteral(red: 0.9969399571, green: 0.4133140743, blue: 0.126126498, alpha: 1))
    static let toggleOffColor = Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1))
    
    //MARK: - Title Colors
    static let titlePrimary = Color(#colorLiteral(red: 0.2392156863, green: 0.231372549, blue: 0.231372549, alpha: 1))
    
    //MARK: - Battery Cell
    static let batteryCell = Color(#colorLiteral(red: 0.3294117647, green: 0.8196078431, blue: 0.7450980392, alpha: 1)) //#54D1BE
    static let batteryLowCell = Color(#colorLiteral(red: 0.8470588235, green: 0.1215686275, blue: 0.1490196078, alpha: 1)) // #D81F26
    static let batteryIcon = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1))
    
    //MARK:  Label Colors
    static let lblPrimary = Color(#colorLiteral(red: 0.2392156863, green: 0.231372549, blue: 0.231372549, alpha: 1)) //#3D3B3B DarkGray
    static let lblSecondary = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)) //#676767 MediumGray
    static let disabledColor = Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)) //#D0D0D0 LightGray
    
    //MARK:  Description Colors
    static let descriptionPrimary = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1))
    static let descriptionSecondary = Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)) //#676767

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
    ///Hex to SwiftUI Color
    init(fromHex hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
    
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
    static func fromHexSwiftUI(_ hex: String, opacity: Double = 1.0) -> Color {
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
