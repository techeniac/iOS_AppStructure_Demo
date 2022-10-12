//
//  AppConstants.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    static let AppName                              = "Common Base"

    #if DEBUG
//    static let serverURL                            = "http://mvd.coruscate.work:7079" //Live
    static let serverURL                            = "http://15.184.130.128/api" //Live
    #else
    static let serverURL                            = "http://admin.simgems.com" //Live
    #endif

    static let DeviceTypeIphone                     = 3

    struct PageLimit{
        static let page                             = 1
        static let limit                            = 100
        static let exclusiveDiamondLimit            = 100
        static let Cartlimit                        = 5000
    }

    //MARk: Social
    struct social {
        
        static let faceBook                             = "https://www.facebook.com/HKDiamonds"
        static let instaGram                            = "https://www.instagram.com/hkdiamonds"
        static let youTube                              = "https://www.youtube.com/c/DiamondByHK"
        static let twitter                              = "https://www.twitter.com/HKDiamonds"
        static let linkedIn                             = "https://www.linkedin.com/company/hkdiamonds/"
        static let google                               = "https://plus.google.com/+Diamondbyhk"
    }
    
    //MARK:  API
    struct URL {
        
        static let Login                            = "/user/login"
        static let Logout                           = "/user/logout"
        static let Newsfeed                         = "/user/all-time-favourite-posts"
        static let VotingPending                    = "/user/get-user-post/{tab}"
        static let Notification                     = "/user/notifications"
        static let UpdateProfile                    = "/user/update-profile"
        static let UploadProfile                    = "/user/upload-profile-picture"
    }
    //MARK:  User Default
    struct UserDefaultKey {
        
        static let isUserLoggedIn                    = "isUserLoggedIn"
        static let isIntroDone                       = "isIntroDone"
        static let userInfo                          = "userInfo"
        static let GuestUserId                       = "GuestUserId"
        static let tokenKey                          = "token"
        static let SkipUpdate                        = "SkipUpdate"
        static let Username                          = "Username"
        static let Password                          = "Password"
        static let SelectedLanguageKey               = "SelectedLanguageKey"
        static let languageChange                    = "languageChange"
        
    }
    struct ScreenSize
    {
        static var SCREEN_WIDTH: CGFloat {
            get {
                return UIScreen.main.bounds.size.width
            }
        }
        
        static var SCREEN_HEIGHT: CGFloat {
            get {
                return UIScreen.main.bounds.size.height
            }
        }
        
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    struct DeviceType {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
        static let IS_IPHONE_XS         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
        static let IS_IPHONE_XR         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
        static let IS_IPHONE_XS_MAX     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
        
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad
    }
    static var hasSafeArea: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        
        return false
    }
    struct BottomMenuConstants {
        static let NewsFeed                 = 1
        static let Favorite                 = 2
        static let Notification             = 3
        static let Profile                  = 4
    }
    


}
