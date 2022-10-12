//
//  ColorScheme.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class ColorScheme: NSObject {
    
    static func colorFromConstant(textColorConstant: String) -> UIColor {
        
        var result = UIColor()
        
        switch textColorConstant {
        case "kThemeColor":
            result = self.kThemeColor()
            break
        case "kGrayColor":
            result = self.kGrayColor()
            break

        case "kRedGoogle":
            result = self.kRedGoogle()
            break

        case "kBlueFacebook":
            result = self.kBlueFacebook()
            break

        case "kBlackApple":
            result = self.kBlackApple()
            break
        case "kButtonTextColor":
            result = self.kButtonTextColor()
            
        case "kWhiteColor":
            result = self.kWhiteColor()
        default:
            result = self.kThemeColor()
        }
        
        return result
    }
    
    //MARK: Private Methods
    
    static func kRedGoogle() -> UIColor{
        return ColorConstants.RedGoogle
    }
    static func kBlueFacebook() -> UIColor{
        return ColorConstants.BlueFacebook
    }
    static func kBlackApple() -> UIColor{
        return ColorConstants.BlackApple
    }
    static func kThemeColor() -> UIColor{
        return ColorConstants.ThemeColor
    }
    static func kGrayColor() -> UIColor{
        return ColorConstants.NonSelectedColor
    }
    static func kButtonTextColor() -> UIColor{
        return ColorConstants.ButtonTextColor
    }
    static func kWhiteColor() -> UIColor{
        return ColorConstants.White
    }
}
