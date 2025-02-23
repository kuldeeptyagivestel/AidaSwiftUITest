//
//  String.swift
//  UmbrellaApp
//
//  Created by Maksym Musiienko on 12/7/17.
//  Copyright © 2017 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var intValue: Int? {
        Int(self)
    }
    
    struct Constants {
        static let splitLength = 5
    }
    
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    nonmutating func parseToUIntFormat() -> UInt {
        var result : UInt = 0
        
        for i in stride(from: 0, to: self.count, by: Constants.splitLength) {
            let endIndex = self.index(self.endIndex, offsetBy: -i)
            let startIndex = self.index(endIndex, offsetBy: -Constants.splitLength, limitedBy: self.startIndex) ?? self.startIndex
            let data = String(self[startIndex..<endIndex])
            result = result | UInt(data)! << (16 * i/Constants.splitLength)
        }
        return result
    }
    
    func isValidPass() -> Bool {
        if self.count > 5 {
            return true
        }
        return false
    }
    
    func setAttributedString(changeText:String, font:UIFont,color:UIColor)-> NSAttributedString {
        let longestWordRange = (self as NSString).range(of: changeText)
        let attributedString = NSMutableAttributedString(string: self, attributes:
            [NSAttributedString.Key.foregroundColor : UIColor(white: 102.0 / 255.0, alpha: 1.0)])
        attributedString.setAttributes([NSAttributedString.Key.font : font,NSAttributedString.Key.foregroundColor : color], range: longestWordRange)
        return attributedString
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func removingLeadingSpaces() -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
            return self
        }
        return String(self[index...])
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
    
    func toInt() -> Int? {
         if let num = NumberFormatter().number(from: self) {
             return num.intValue
         } else {
             return nil
         }
     }
    
    
    func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }

    func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

///Empty String Extension: Use this where need place empty string or need to check for empty
extension String {
    static var empty: String {
        return ""
    }
}

extension String {
    /// The formatted MAC address string with colons.
    ///
    /// This property formats the `macAddress` by adding colons every two characters.
    /// Example: "F5017A410D35" becomes "F5:01:7A:41:0D:35".
    ///
    /// - Note: If the input MAC address is invalid or empty, `nil` is returned.
    ///
    /// Example usage:
    /// ```
    /// let macAddress = "F5017A410D35"
    /// let formattedAddress = macAddress.formattedMACAddress
    /// print(formattedAddress) // Output: "F5:01:7A:41:0D:35"
    /// ```
    ///
    /// - Returns: The formatted MAC address string, or `nil` if the input is invalid.    
    public var formattedMACAddress: String? {
        let cleanMACAddress = self.replacingOccurrences(of: ":", with: "")
        let regex = try! NSRegularExpression(pattern: "(.{2})", options: [])
        let formattedMACAddress = regex.stringByReplacingMatches(
            in: cleanMACAddress,
            options: [],
            range: NSRange(location: 0, length: cleanMACAddress.count),
            withTemplate: "$1:"
        )
        
        let capitalizedMACAddress = String(formattedMACAddress.dropLast())
        
        // Check if the original MAC address is in lowercase
        if self.rangeOfCharacter(from: .lowercaseLetters) != nil {
            return capitalizedMACAddress.uppercased()
        } else {
            return capitalizedMACAddress
        }
    }
}

//MARK: - FILE NAME EXTENSION
extension String {
    //wf_w10.watch -> wf_w10
    //"image.png" -> image
    //Some/Random/Path/To/This.Strange.File.txt -> This.Strange.File
    public var fileName: String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    //wf_w10.watch -> wf_w10.watch
    //image.png -> image.png
    //Some/Random/Path/To/This.Strange.File.txt -> This.Strange.File.txt
    public var fileNameWithExtension: String {
        return URL(fileURLWithPath: self).lastPathComponent
    }

    //wf_w10.watch -> watch
    //image.png -> png
    //Some/Random/Path/To/This.Strange.File.txt -> txt
    public var fileExtension: String {
        return URL(fileURLWithPath: self).pathExtension
    }
}
