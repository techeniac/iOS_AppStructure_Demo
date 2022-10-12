//
//  StringConstants.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import Foundation
struct StringConstants {
    
    ///// DO NOT CHANGE ANY CONSTANT WITHOUT DISCUSSION OF TEAM ///////////
    static let pageLimit                                = 20
    static let CountryCode                              = "+91"
    
    struct ExpandableLabelConstant {
        
        static let attribute = [ NSAttributedString.Key.font: FontScheme.kRegularFont(size: 15), .foregroundColor:UIColor.blue ]
        
        static let attributedMoreText           = NSAttributedString(string: "Read More", attributes: attribute)
        static let attributedLessText           = NSAttributedString(string: "Less", attributes: attribute)
        
    }
    
    struct SplashScreen {
        static var KLblWelcome: String{
            get { return LanguageManager.localizedString("KLblWelcome") }
        }
    }

    struct LoginScreen{
        static var KLblGoogle: String{
            get { return LanguageManager.localizedString("KLblGoogle") }
        }
        static var KLblFacebook: String{
            get { return LanguageManager.localizedString("KLblFacebook") }
        }
        static var KLblApple: String{
            get { return LanguageManager.localizedString("KLblApple") }
        }
        static var KLblForgotYourPassword: String{
            get { return LanguageManager.localizedString("KLblForgotYourPassword") }
        }
        static var KLblLogin: String{
            get { return LanguageManager.localizedString("KLblLogin") }
        }
        
        static var KLblLogout: String{
            get { return LanguageManager.localizedString("KLblLogout") }
        }
                static var KLblSignup : String {
            get { return LanguageManager.localizedString("KLblSignup") }
        }

    }
    
    struct TaabBar{
        static var KLblMenuNewsFeed: String{
            get { return LanguageManager.localizedString("KLblMenuNewsFeed") }
        }
        static var KLblMenuFavorite: String{
            get { return LanguageManager.localizedString("KLblMenuFavorite") }
        }
        static var KLblMenuNotifications: String{
            get { return LanguageManager.localizedString("KLblMenuNotifications") }
        }
        static var KLblProfile: String{
            get { return LanguageManager.localizedString("KLblProfile") }
        }

    }
    
    //Common
    struct Common {

        static var kMsglogout: String{
            get {return LanguageManager.localizedString("KMsgLogout")}
        }

        static var kOpenSettings : String {
            get { return LanguageManager.localizedString("kOpenSettings") }
        }
        
        static var kCameraPermission : String {
            get { return LanguageManager.localizedString("kCameraPermission") }
        }
        
        static var kFailedToGetCamera : String {
            get { return LanguageManager.localizedString("kFailedToGetCamera") }
        }
        
        static var SomethingWrong : String {
            get { return LanguageManager.localizedString("kLblSomethingWentWrong") }
        }

        static var kAccessDenied : String {
            get { return LanguageManager.localizedString("kAccessDenied") }
        }
                
        static var KMsgReloadList : String {
            get { return LanguageManager.localizedString("KMsgReloadList") }
        }
        static var KLblNotification: String{
            get { return LanguageManager.localizedString("KLblNotification") }
        }

        
    }

    struct ButtonTitles {
        static var kClear : String {
            get { return LanguageManager.localizedString("KLblClear") }
        }
        
        static var KConfirm : String {
            get { return LanguageManager.localizedString("KLblConfirm") }
        }
        
        static var KCancel : String {
            get { return LanguageManager.localizedString("KLblCancel") }
        }
        
        static var kRemove : String {
            get { return LanguageManager.localizedString("KLblRemove") }
        }
        
        static var kYes : String {
            get { return LanguageManager.localizedString("KLblYes") }
        }
        
        static var kNo : String {
            get { return LanguageManager.localizedString("KLblNo") }
        }
        
        static var kAll : String {
            get { return LanguageManager.localizedString("KLblAll") }
        }
        
        static var kCurrent : String {
            get { return LanguageManager.localizedString("KLblCurrent") }
        }
        
        static var kClose : String {
            get { return LanguageManager.localizedString("KLblClose") }
        }
        
        static var kView : String {
            get { return LanguageManager.localizedString("KLblView") }
        }
        
        static var kRetry : String {
            get { return LanguageManager.localizedString("KLblRetry") }
        }
        
        static var kApply : String {
            get { return LanguageManager.localizedString("KLblApply") }
        }
        
        static var kDone : String {
            get { return LanguageManager.localizedString("KLblDone") }
        }
        
        
        static var kNext : String {
            get { return LanguageManager.localizedString("KLblNext") }
        }
        
        static var kSubmit : String {
            get { return LanguageManager.localizedString("KLblSubmit") }
        }
        
        static var KOk : String {
            get { return LanguageManager.localizedString("KLblOk") }
        }
        
        static var KDelete : String {
            get { return LanguageManager.localizedString("KLblDelete") }
        }
        
        static var kRefersh : String {
            get { return LanguageManager.localizedString("KLblRefresh") }
        }
        
        static var kAdd : String {
            get { return LanguageManager.localizedString("KLblAdd") }
        }
        
        static var KTryAgain : String {
            get { return LanguageManager.localizedString("KLblTryAgain") }
        }
    }
    //NoData
    struct Nodata {
        
        static var NoDataFound : String {
            get { return LanguageManager.localizedString("KMsgNoDataFound") }
        }
        
        static var NoFavourite : String {
            get { return LanguageManager.localizedString("KMsgNoFavouriteFound") }
        }
        
        static var NoDiamondFound : String {
            get { return LanguageManager.localizedString("KMsgNoDiamondFound") }
        }
        
        static var NoAddressFound : String {
            get { return LanguageManager.localizedString("KMsgNoAddressFound") }
        }
        
        static var kNoInternet : String {
            get { return LanguageManager.localizedString("KMsgNoInternetConnection") }
        }
        
        static var kNoSearch : String {
            get { return LanguageManager.localizedString("KMsgNoSearchFound") }
        }
        
        static var kNoOrder : String {
            get { return LanguageManager.localizedString("KMsgNoOrderFound") }
        }
        
        static var kNoAppointment : String {
            get { return LanguageManager.localizedString("KMsgNoAppointmentFound") }
        }
        
        static var kProducts : String {
            get { return LanguageManager.localizedString("KMsgNoProductsFound") }
        }
        
        static var kNoDemands : String {
            get { return LanguageManager.localizedString("KMsgNoDemandFound") }
        }
        
        static var kNoHistory : String {
            get { return LanguageManager.localizedString("KMsgNoHisoryFound") }
        }
        
        static var kNoPurchase : String {
            get { return LanguageManager.localizedString("KMsgNoPurchaseFound") }
        }
        
        static var kNoNotification : String {
            get { return LanguageManager.localizedString("KMsgNoNotificationFound") }
        }
        
        static var kNoUserFound : String {
            get { return LanguageManager.localizedString("kNoUserFound") }
        }
    }

}
