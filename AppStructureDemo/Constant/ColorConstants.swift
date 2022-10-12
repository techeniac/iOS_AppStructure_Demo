//
//  ColorConstants.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import Foundation
import UIKit
struct ColorConstants {
    
    static let NavigationBarColor           = #colorLiteral(red: 0.4196078431, green: 0.5568627451, blue: 0.9803921569, alpha: 1)
    static let whiteColor                   = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let BgColor                      = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    static let NonSelectedColor             = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)   //9B9B9B
    static let PlaceHolderColor             = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)   //9B9B9B
    static let ShadowColor                  = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2297535211)
    static let BorderColor                  = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1) //#ECECEC
    static let ButtonShadowColor            = #colorLiteral(red: 0.2666666667, green: 0.4470588235, blue: 0.768627451, alpha: 0.41)
    static let ButtonBgColor                = #colorLiteral(red: 0.4862745098, green: 0.7176470588, blue: 0.6901960784, alpha: 1)  //#7cb7b0

    static let BackgroundColor              = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 0.8) //EBE8FC
    static let TextColor                    = #colorLiteral(red: 0.9215686275, green: 0.9098039216, blue: 0.9882352941, alpha: 1) //#EBE8FC
    static let DarkTextColor                = #colorLiteral(red: 0.2980392157, green: 0.3019607843, blue: 0.3098039216, alpha: 1)

    static let TitleColor                   = #colorLiteral(red: 0.8039215686, green: 0.7960784314, blue: 0.8470588235, alpha: 1) //#CDCBD8
    static let PlaceholderColor             = #colorLiteral(red: 0.5882352941, green: 0.5843137255, blue: 0.6784313725, alpha: 1) //#9695AD
    static let TitleColorOrange             = #colorLiteral(red: 0.9725490196, green: 0.6235294118, blue: 0.003921568627, alpha: 1) //##F89F01
    static let ButtonTextColor              = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9764705882, alpha: 1) //##F6F6F9
    static let RedGoogle                    = #colorLiteral(red: 0.9137254902, green: 0.2588235294, blue: 0.2078431373, alpha: 1) //#E94235
    static let BlueFacebook                 = #colorLiteral(red: 0.2392156863, green: 0.3294117647, blue: 0.5568627451, alpha: 1) //#3D548E
    static let BlackApple                   = #colorLiteral(red: 0.09803921569, green: 0.09019607843, blue: 0.09411764706, alpha: 1) //#191718
    static let HeaderColor                  = #colorLiteral(red: 0.2235294118, green: 0.2235294118, blue: 0.2235294118, alpha: 1) //#393939
    static let RadioUnselected              = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1) //#999999
    static let White                        = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //#FFFFFF
    static let popupbar                     = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1) //#D8D8D8
    static let popTitle                     = #colorLiteral(red: 0.1333333333, green: 0.1411764706, blue: 0.1647058824, alpha: 1) //#22242A
    static let TitleColorBlue             = #colorLiteral(red: 0.5019607843, green: 0.6862745098, blue: 0.9137254902, alpha: 1) //#80AFE9
    static let TitleColorGreen             = #colorLiteral(red: 0.5882352941, green: 0.8392156863, blue: 0.4039215686, alpha: 1) //#96D667
    
    static var ThemeColor: UIColor {
        get {
            //            if AppConstants.themeType == 1 {
            //                return #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1) //#313131
            //            } else {
            return #colorLiteral(red: 0.09019607843, green: 0.07450980392, blue: 0.2705882353, alpha: 1) //#171345
            //            }
        }
    }
    
}

extension UIColor {
    convenience init(_ hexString: String, alpha: Double = 1.0) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0)
        }
        self.init(displayP3Red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(255 * alpha) / 255)
    }
}
