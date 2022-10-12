//
//  StringExtension.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import Foundation
import PhoneNumberKit

extension String {
    
    //Get You Tube ID
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, options: [], range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
    
    //If Is You tube URL
    func isYouTubeUrl() -> Bool {
        
        if self.lowercased().contains("www.youtube.com") {
            return true
        }
        
        return false
    }
    
    func toDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter.number(from: self) as? Double
    }
    
    func toInt() -> Int? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self) as? Int
    }

    func formatValue() -> String {
       
        let value = Double(self) ?? 0.0
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        let formattedAmount = formatter.string(from: value as NSNumber)
        if formattedAmount == "0.00"{
            return "-"
        } else if formattedAmount == "0" {
            return "-"
        }
        return formattedAmount ?? "-"
    }

    func isNumeric() -> Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return  !hasLetters && hasNumbers
    }
    
    func isValidPassword() -> Bool {
    
        let regExpression = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regExpression)
        return predicate.evaluate(with:self)
    }
    

    /// Check for email validation
    func isValidEmail() -> Bool {
        
        let str = self.removeWhiteSpaces()
        let regExpression = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,25}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regExpression)
        
        return predicate.evaluate(with:str)
    }
    
    /// Check for WebSite validation
    func isValidURL() -> Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    func isValidWeChat() -> Bool {
        //!profileField["wechat"].match(/^[a-zA-Z][a-zA-Z0-9_-]+$/) || profileField["wechat"].length > 20 || profileField["wechat"].length < 6
        let str = self.removeWhiteSpaces()
        let regExpression = "^[a-zA-Z0-9_-]{6,20}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regExpression)
        
        return predicate.evaluate(with:str)
    }
    
    /// Check for mobile validation
       func isValidMobileNumber(strMobile: String, strCountryCode: String) -> Bool{
    
            let phone = strCountryCode + " \(strMobile)"    //  +91 9898989898
    
            let phoneKit = PhoneNumberKit.init()
                let phoneNumber = phoneKit.isValidPhoneNumber(phone)
                if phoneNumber {
                    return true
    
                } else {
                    return false
    
                }
    
    
        }
    
    /// Check for mobile validation
    func isValidPincode() -> Bool{
        
        let pincodeRegex: String = "^[0-9]{4,6}$"
        let pincodeTest = NSPredicate(format: "SELF MATCHES %@", pincodeRegex)
        if pincodeTest.evaluate(with: self) {
            if CInt(self) != 0 {
                return true
            }
        }
        return false
    }
    
    /// Remove white spaces (front and rear) from string
    func removeWhiteSpaces () -> String {
        var str = self.trimmingCharacters(in: .whitespaces)
        str = str.replacingOccurrences(of: " ", with: "")
        return str
    }
    
    func replaceSpaceTo20 () -> String {
        var str = self.trimmingCharacters(in: .whitespaces)
        str = str.replacingOccurrences(of: " ", with: "%20")
        return str
    }
    func replaceCurlyBracesTo7B () -> String {
        var str = self.trimmingCharacters(in: .whitespaces)
        str = str.replacingOccurrences(of: "{", with: "%7B")
        str = str.replacingOccurrences(of: "}", with: "%7B")
        return str
    }

    /// Remove UnderScore
    func removeUnderScore () -> String {
        var str = self
        if str.lowercased().range(of:"_") != nil {
            str = str.replacingOccurrences(of: "_", with: " ")
        }
        return str.localizedCapitalized
    }
    
    /// Remove %
    func removePrecentage () -> String {
        var str = self
        if str.lowercased().range(of:"%") != nil {
            str = str.replacingOccurrences(of: "%", with: "")
        }
        return str
    }

    /// Check if value is 0/1 or Yes/No or Y/N
    func boolValue() -> Bool {
        
        switch self {
        case "True", "true", "yes", "Yes", "1":
            return true
        case "False", "false", "no", "No", "0":
            return false
        default:
            return false
        }
    }
    
    func isImage() -> Bool {
        let str = self.lowercased()
        if str.contains(".png") || str.contains(".jpg") || str.contains(".jpeg") {
            return true
        }
        return false
    }
    
    func isPDF() -> Bool {
        let str = self.lowercased()
        if str.contains(".pdf") {
            return true
        }
        return false
    }
    
    func replace(target: String, withString: String) -> String{
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        let range: Range<Index> = start ..< end
        //return String(self[Range(start ..< end)])
        return String(self[range])
    }
    
    /// Get document directory path url for given string
    static func documentDirectoryPath(forFileName name:String) -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentPath = paths.first! as NSString
        return documentPath.appendingPathComponent(name) as String
    }
    
    func fileExtension() -> String {
        
        if let fileExtension = NSURL(fileURLWithPath: self).pathExtension {
            return fileExtension
        } else {
            return ""
        }
    }
    
    func fileName() -> String {
        
        if let fileNameWithoutExtension = NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent {
            return fileNameWithoutExtension
        } else {
            return ""
        }
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
   
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    //Chat Methods
    
    func isVideo() -> Bool {
        
        if self.fileExtension().lowercased() == "webm" || self.fileExtension().lowercased() == "mkv" || self.fileExtension().lowercased() == "3gp" || self.fileExtension().lowercased() == "m4v" || self.fileExtension().lowercased() == "mp4" || self.fileExtension().lowercased() == "mov" {
            
            return true
        }
        
        return false
    }
    
    mutating func insert(string:String,ind:Int) {
        self.insert(contentsOf: string, at:self.index(self.startIndex, offsetBy: ind) )
    }
    
    func exponentize() -> String {
        
        let supers = [
            "1": "\u{00B9}",
            "2": "\u{00B2}",
            "3": "\u{00B3}",
            "4": "\u{2074}",
            "5": "\u{2075}",
            "6": "\u{2076}",
            "7": "\u{2077}",
            "8": "\u{2078}",
            "9": "\u{2079}"]
        
        var newStr = ""
        var isExp = false
        for (_, char) in self.enumerated() {
            if char == "^" {
                isExp = true
            } else {
                if isExp {
                    let key = String(char)
                    if supers.keys.contains(key) {
                        newStr.append(Character(supers[key]!))
                    } else {
                        isExp = false
                        newStr.append(char)
                    }
                } else {
                    newStr.append(char)
                }
            }
        }
        return newStr
    }
    
    var localized: String {
        return LanguageManager.localizedString(self)
    }
}

extension String {
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
}


// Set Color for Specific string inside string
extension NSMutableAttributedString{

    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
    
    func setFontForText(_ textToFind: String, with font: UIFont) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }
    }
}

extension Double {
    
    //Remove After Points Digits
//    func getFloreValue(digit : Int) -> Double {
//
//        return self
////        let aString: String = String(format: "%.\(digit)f", self)
////        return Double(aString) ?? 0
//    }
}
