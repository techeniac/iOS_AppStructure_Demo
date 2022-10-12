//
//  LanguageManager.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit
import ObjectMapper

class SelectionPopupModel: NSObject, Mappable {

    @objc dynamic var id : String?
    @objc dynamic var name : String?
    @objc dynamic var isSelected : Bool = false
    @objc dynamic var isAllSelected : Bool = false
    @objc dynamic var obj:Any?
    
    @objc dynamic var toDateTime : String?
    @objc dynamic var selectedDate : Date?
    
    @objc dynamic var existingList : [String]?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id                             <- map["id"]
        name                           <- map["name"]
        name                           <- map["title"]
        isAllSelected                  <- map["isAllSelected"]
        isSelected                     <- map["isSelected"]
        obj                            <- map["obj"]
        toDateTime                     <- map["toDateTime"]
        selectedDate                   <- map["selectedDate"]
        existingList                   <- map["existingList"]
    }
    
    class func getSelectionPopupModel(id: String = "", name: String, isSelected:Bool = false, obj:Any? = nil) -> SelectionPopupModel {
        let model = SelectionPopupModel()
        model.id = id
        model.name = name
        model.isSelected = isSelected
        model.obj = obj
        return model
    }
    
}
