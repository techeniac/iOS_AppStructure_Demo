//
//  LanguageManager.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import Foundation
import UIKit

let kLMDefaultLanguage = "en"
//let kLMEnglish = "en"
//let kLMFrench  = "fr"

let appSupportedLanguage = ["en", "de", "es", "fr", "he", "it", "ja", "zh"]

class LanguageManager: NSObject {
    
    // A Singleton instance
    static let sharedInstance = LanguageManager()
    
    var arrLangs = [SelectionPopupModel]()
    
    var selectedLangKey : String?

    //get current app language
    class func getCurrentLanguage() -> String
    {
        let language = Defaults[.selectedLanguageKey]
        
        if language == nil || language!.isEmpty {
            return kLMDefaultLanguage
        }
        return language ?? kLMDefaultLanguage
    }
    
    //get localized string
    class func localizedString(_ key: String) -> String {
        let selectedLanguage: String = LanguageManager.selectedLanguage()
        // Get the corresponding bundle path.
        let path: String? = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj")
        // Get the corresponding localized string.
        let languageBundle = Bundle(path: path!)
        let str = languageBundle?.localizedString(forKey: key, value: "", table: nil)
        
        if str == nil
        {
            return ""
        }else
        {
            return str!
        }
    }
    
    //check selected language supported or not
    class func isSupportedLanguage(_ language: String) -> Bool {
        return appSupportedLanguage.contains(language)
    }
    
    //store language if supported
    class func setSelectedLanguage(_ language: String) {
        // Check if desired language is supported.
        if self.isSupportedLanguage(language) {
            self.sharedInstance.selectedLangKey = language
            Defaults[.selectedLanguageKey] = language
        }
        else {
            self.sharedInstance.selectedLangKey = nil
            // if desired language is not supported, set selected language to nil.
            Defaults[.selectedLanguageKey] = nil
        }
    }
    
    class func selectedLanguage() -> String {
        
        if let langKey = self.sharedInstance.selectedLangKey {
            return langKey
        }
        
        // Get selected language from user defaults.
        var selectedLanguage: String? = Defaults[.selectedLanguageKey]
        // if the language is not defined in user defaults yet...
        if selectedLanguage == nil {
            selectedLanguage = kLMDefaultLanguage
            
            if self.isSupportedLanguage(selectedLanguage!) {
                self.setSelectedLanguage(selectedLanguage!)
            }
            else {
                // Set the LanguageManager default language as selected language.
                self.setSelectedLanguage(kLMDefaultLanguage)
            }
        }
        
        let newLangkey = Defaults[.selectedLanguageKey]
        self.sharedInstance.selectedLangKey = newLangkey
        return newLangkey ?? kLMDefaultLanguage
    }
}
// Lang Change Popup
extension LanguageManager {
    
    func getLanguageList(completion: @escaping ((Bool, String?)->Void)) {
        
        if (self.arrLangs.count > 0) {
            var langName : String?
            let currentlangId = LanguageManager.getCurrentLanguage()
            
            self.arrLangs = self.arrLangs.map({ (model) -> SelectionPopupModel in
                if model.id == currentlangId {
                    langName = model.name
                }
                return model
            })
            
            completion(true, langName)
            return
        }
        
        // Get Data From lang json File
        if let path = Bundle.main.path(forResource: "language", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                if let list = jsonResult as? [[String:Any]] {
                    self.arrLangs = Mapper<SelectionPopupModel>().mapArray(JSONArray: list)
                }
                
                let currentlangId = LanguageManager.getCurrentLanguage()
                var langName : String?
                
                self.arrLangs = self.arrLangs.map({ (model) -> SelectionPopupModel in
                    if model.id == currentlangId {
                        model.isSelected = true
                        langName = model.name
                    }
                    return model
                })
                completion(true, langName)
            } catch {
                completion(false, nil)
            }
        }
    }
    
    func openLangSelectionPopup(view: UIView, completion: @escaping ((String?)->Void)) {
        
        getLanguageList { (status, langName) in
            if (status) {
                
                view.showSelectionPopup(arr: self.arrLangs, title: LanguageManager.localizedString("KLblSelectLanguage")) { (selectedModel) in
                    
                    completion(selectedModel.name ?? "")
                    
                    LanguageManager.setSelectedLanguage(selectedModel.id ?? kLMDefaultLanguage)
//RD Comment
                    let vc  = SplashVC(nibName: "SplashVC", bundle: nil)
                    UIViewController.current()?.navigationController?.pushViewController(vc, animated: true)
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstants.UserDefaultKey.languageChange), object: nil, userInfo: nil)
                    
                    self.arrLangs = self.arrLangs.map({ (model) -> SelectionPopupModel in
                        if model.id == selectedModel.id {
                            model.isSelected = true
                        }
                        else {
                            model.isSelected = false
                        }
                        return model
                    })
                }
            }
        }
    }
}
