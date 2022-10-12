//
//  ApplicationData.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

/** This singleton class is used to store application level data. */
class ApplicationData: NSObject {
    
    // A Singleton instance
    static let sharedInstance = ApplicationData()
    
    // Checks if user is logged in
    static var isUserLoggedIn: Bool {
        get {
            return Defaults[.isUserLoggedIn]
            //            return Defaults.bool(forKey: AppConstants.UserDefaultKey.isUserLoggedIn)
        }
    }
    
    // returns logged in user's information
    static var user: UserModel {
        get {
            return Defaults[.userInfo] ?? UserModel()
        }
    }
    
    //     returns Token
    static var accessToken: String? {
        get {
            return Defaults[.accessToken]
        }
    }
    //
    //    // returns Token
    //    static var guestId: String? {
    //        get {
    //            return Defaults[.GuestUserId]
    //        }
    //    }
    //
    //    //guest
    //    static var isGuestUser : Bool {
    //        get {
    //            return (ApplicationData.guestId != nil)
    //        }
    //    }
    //
    //    //TouchId
    //    static var isTouchId : Bool {
    //        get {
    //            return Defaults[.touchId]
    //        }
    //    }
    //
    //    //Watchlist Name
    //    static var watchListName : [String] {
    //        get {
    //            if let str = Defaults[.watchListName],str.count > 0 {
    //                if let arr = Utilities.objectFromJsonString(str: str) as? [String] {
    //                    return arr
    //                }
    //            }
    //
    //            return []
    //        }
    //    }
    
    // returns Current Time Zone
    static var timeZone: String {
        get {
            let timeZone = NSTimeZone.local
            return timeZone.localizedName(for: .standard, locale: .current) ?? ""
        }
    }
    
    //retun device Id
    static var deviceId: String {
        get {
            return UIDevice.current.identifierForVendor!.uuidString
        }
    }
    
    //retun device Name
    static var deviceName: String {
        get {
            return UIDevice.current.localizedModel
        }
    }
    
    
    //retun device version
    static var deviceVersion: String {
        get {
            return UIDevice.current.systemVersion
        }
    }
    
    static func buildVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        //let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "V \(build)"
    }
    
    static var ipAddress : String {
        
        get {
            
            var address : String?
            
            // Get list of all interfaces on the local machine:
            var ifaddr : UnsafeMutablePointer<ifaddrs>?
            guard getifaddrs(&ifaddr) == 0 else { return "" }
            guard let firstAddr = ifaddr else { return "" }
            
            // For each interface ...
            for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
                let interface = ifptr.pointee
                
                // Check for IPv4 or IPv6 interface:
                let addrFamily = interface.ifa_addr.pointee.sa_family
                
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    // Check interface name:
                    let name = String(cString: interface.ifa_name)
                    
                    if  name == "en0" || name == "pdp_ip0"  {
                        
                        // Convert interface address to a human readable string:
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
            return address ?? ""
        }
    }
    
    //return UUID
    func getUUID() -> String {
        return UUID().uuidString
    }
    
    /// Default headers to be passed in CenterAPI requests
    var authorizationHeaders: HTTPHeaders {
        
        get{
            var headers: HTTPHeaders = [:]
            if ApplicationData.isUserLoggedIn{
                headers = [NetworkClient.Constants.HeaderKey.Authorization:"Bearer \(ApplicationData.accessToken!)", "devicetype" : "3","uuid" : ApplicationData.deviceId,"utcOffset" : TimeZone.current.offsetFromUTC(),"appversion" : Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String]
            }else{
                headers = ["devicetype" : "3","uuid" : ApplicationData.deviceId,"utcOffset" : TimeZone.current.offsetFromUTC(),"appversion" : Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String]
            }
            return headers
        }
    }
    
    //Move To Home
    func moveToHome() {
        
        
        Utilities.sideMenuGesture(isEnable: true)
        
        //SyncManager.sharedInstance.deleteOfflineStock()
        
        let vc = TabbarVC.init(nibName: "TabbarVC", bundle: nil)
        UIViewController.current()?.navigationController?.popAllAndSwitch(to: vc)
        
    }
    
    //     Save user details
    func saveLoginData(data: [String : Any]) {
        
        //        if let permission = data["userPermissions"] as? [String:Any]{
        //
        //            if let list = permission["data"] as? [[String:Any]],list.count > 0 {
        //                SyncManager.sharedInstance.insertPermission(list: list)
        //            }
        //        }
        
        updateLoginData(data: data)
        
        //        if let dictToken = data["token"] as? [String:Any]{
        Defaults[.accessToken] = data["access_token"] as? String ?? ""
        //        }
        
        Defaults[.isUserLoggedIn] = true
    }
    
    // Update user details
    func updateLoginData(data: [String : Any]) {
        
        //        if let dictUser = data["user"] as? [String:Any]{
        let userInfo = Mapper<UserModel>().map(JSON: data)
        Defaults[.userInfo] = userInfo
        //        }
    }
    //
    //    // Save guest user details
    //    func saveGuestLoginData(data: [String : Any]) {
    //
    //        if let dict = data["user"] as? [String:Any], let id = dict["id"] {
    //            Defaults[.GuestUserId] = "\(id)"
    //        }
    //
    //        saveLoginData(data: data)
    //    }
    //
    //    //Register To Drift
    //    func registerToDrift() {
    //
    //        Drift.registerUser(ApplicationData.user.userId ?? "", email: ApplicationData.user.email, userJwt: ApplicationData.accessToken)
    //    }
    //
        // Logout User
        func logoutUser() {
            ApplicationData.sharedInstance.callLogoutAPI()
        }
    //
    //Clear Database And User Data
    func clearUserData() {
        
        //        let rememberMe = Defaults[.RememberMe]
        //        let username = Defaults[.Username]
        //        let password = Defaults[.Password]
        //        let playerId = Defaults[.playerID]
        //        let selectedLanguageKey = Defaults[.selectedLanguageKey]
        //        let homeTakeTour = Defaults[.HomeScreenTakeTour]
        //        let listTakeTour = Defaults[.DiamondListTakeTour]
        //        let profileTakeTour = Defaults[.ProfileTakeTour]
        //        let MenuTakeTour = Defaults[.LeftMenuTakeTour]
        //        let demandListTour = Defaults[.DemandList]
        //        let peopleListTour = Defaults[.PeopleList]
        //        let tradeListTour = Defaults[.TradeList]
        //        let trackListTour  = Defaults[.TrackScreenTakeTour]
        //        let filterTakeTour  = Defaults[.FilterTakeTour]
        //        let filterSavedSearchTakeTour  = Defaults[.FilterSavedSearchTakeTour]
        //        let diamondDetailTakeTour  = Defaults[.DiamondDetailTakeTour]
        //        let compareTakeTour  = Defaults[.CompareTakeTour]
        //        let enquiryTakeTour  = Defaults[.EnquiryTakeTour]
        
        // user default clear
        UserDefaults.removeAllData()
        Defaults.removeAll()
        
        //        if rememberMe == true{
        //            Defaults[.RememberMe] = rememberMe
        //            Defaults[.Username] = username
        //            Defaults[.Password] = password
        //        }
        //
        //        Defaults[.selectedLanguageKey] = selectedLanguageKey
        //        Defaults[.LeftMenuTakeTour] = MenuTakeTour
        //        Defaults[.HomeScreenTakeTour] = homeTakeTour
        //        Defaults[.DiamondListTakeTour] = listTakeTour
        //        Defaults[.ProfileTakeTour] = profileTakeTour
        //        Defaults[.DemandList] = demandListTour
        //        Defaults[.PeopleList] = peopleListTour
        //        Defaults[.TradeList] = tradeListTour
        //        Defaults[.TrackScreenTakeTour] = trackListTour
        //        Defaults[.FilterTakeTour] = filterTakeTour
        //        Defaults[.FilterSavedSearchTakeTour] = filterSavedSearchTakeTour
        //        Defaults[.DiamondDetailTakeTour] = diamondDetailTakeTour
        //        Defaults[.CompareTakeTour] = compareTakeTour
        //        Defaults[.EnquiryTakeTour] = enquiryTakeTour
        //
        //        Defaults[.playerID] = playerId
    }
    
    func callLogoutAPI() {
        
        var request = Parameters()
        //        request["player_id"] = Defaults[.playerID]
        NetworkClient.sharedInstance.showIndicator("", stopAfter: 0.0)
        NetworkClient.sharedInstance.request(AppConstants.serverURL, command: AppConstants.URL.Logout, method: .post, parameters: request, headers: ApplicationData.sharedInstance.authorizationHeaders, success: { (_, _) in
            
            Utilities.sideMenuGesture(isEnable: false)
            
//            Drift.logout()
            self.clearUserData()
            //            SyncManager.sharedInstance.clearDataBase()
            Defaults[.isUserLoggedIn] = false
            
            // redirect to Login Screen
            self.moveToLogin()
            
        }) { (_, _) in
            print("Fail")
        }
    }
    //
    func moveToLogin(){
                        let vc  = LoginVC(nibName: "LoginVC", bundle: nil) as LoginVC
                UIViewController.current()?.navigationController?.popAllAndSwitch(to: vc)
    }
}
