//
//  UserDefaultExtension.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults

extension UserDefaults {
    
    //     UserModel Default Keys
    subscript(key: DefaultsKey<UserModel?>) -> UserModel? {
        get { return unarchive(key) }
        set { archive(key, newValue) }
    }
    
    subscript(key: DefaultsKey<UserCategoryModel?>) -> UserCategoryModel? {
        get { return unarchive(key) }
        set { archive(key, newValue) }
    }

    
    static func removeAllData() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
}

// MARK: - Default keys
extension DefaultsKeys {
    
    static let isUserLoggedIn       = DefaultsKey<Bool>(AppConstants.UserDefaultKey.isUserLoggedIn)
    
    // User models
    static let userInfo             = DefaultsKey<UserModel?>(AppConstants.UserDefaultKey.userInfo)
    
    // Token
    static let accessToken          = DefaultsKey<String?>(AppConstants.UserDefaultKey.tokenKey)
    
    //Lang Key
    static let selectedLanguageKey  = DefaultsKey<String?>(AppConstants.UserDefaultKey.SelectedLanguageKey)
}
