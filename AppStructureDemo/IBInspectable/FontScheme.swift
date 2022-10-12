//
//  FontScheme.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

//MARK:  Font Constant

class FontScheme: NSObject {

    struct FontConstant {
        
        static let kRegularFont                     = "Poppins-Regular"
        static let kLightFont                       = "Poppins-Light"
        static let kMediumFont                      = "Poppins-Medium"
        static let kBoldFont                        = "Poppins-Bold"
        static let kSemiBoldFont                    = "Poppins-SemiBold"
    }
    
    static func fontFromConstant(fontType:Int = 0, fontName: String,size : CGFloat) -> UIFont {
        
        var result = UIFont()
        if fontType > 0 && fontType < 6 {
            switch fontType {
            case 1: // Section header
                result = self.kLightFont(size: size)
                break
            case 2: // header
                result = self.kRegularFont(size: size)
                break
            case 3: // Sub header
                result = self.kMediumFont(size: size)
                break
            case 4: // Description
                result = self.kSemiBoldFont(size: size)
                break
            case 5: // Description
                result = self.kBoldFont(size: size)
                break
            default:
                break
            }
        }
        else {
            switch fontName {
            case "kRegularFont":
                result = self.kRegularFont(size: size)
                break
            case "kMediumFont":
                result = self.kMediumFont(size: size)
                break
            case "kBoldFont":
                result = self.kBoldFont(size: size)
                break
            case "kSemiBoldFont":
                result = self.kSemiBoldFont(size: size)
                break
            case "kLightFont":
                result = self.kLightFont(size: size)
                break
            default:
                result = self.kRegularFont(size: size)
            }
            
        }
        
        
        return result
    }
    
    //Regular
    static func kRegularFont(size : CGFloat) -> UIFont  {
        
        return UIFont(name: FontConstant.kRegularFont, size: size)!
    }
    
    //Light
    static func kLightFont(size : CGFloat) -> UIFont  {
        
        return UIFont(name: FontConstant.kLightFont, size: size)!
    }
    
    //Medium
    static func kMediumFont(size : CGFloat) -> UIFont  {
        
        return UIFont(name: FontConstant.kMediumFont, size: size)!
    }
    
    //Bold
    static func kBoldFont(size : CGFloat) -> UIFont  {
        
        return UIFont(name: FontConstant.kBoldFont, size: size)!
    }
    
    //SemiBold
    static func kSemiBoldFont(size : CGFloat) -> UIFont  {
        
        return UIFont(name: FontConstant.kSemiBoldFont, size: size)!
    }
    
}
