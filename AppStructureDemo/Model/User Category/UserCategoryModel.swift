//
//  UserCategoryModel.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import Foundation
class UserCategoryModel : NSObject, Mappable, NSCoding {
    var id : Int?
    var name : String?
    var image : String?
    var thumbnail : String?
    var meta : String?
    var status : String?
    var is_selected : Bool?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        thumbnail <- map["thumbnail"]
        meta <- map["meta"]
        status <- map["status"]
        is_selected <- map["is_selected"]
    }
    required init?(coder aDecoder: NSCoder) {
        
        id                  = aDecoder.decodeObject(forKey: "id") as? Int
        name              = aDecoder.decodeObject(forKey: "name") as?  String
        image          = aDecoder.decodeObject(forKey: "image") as?  String
        thumbnail           = aDecoder.decodeObject(forKey: "thumbnail") as?  String
        meta            = aDecoder.decodeObject(forKey: "meta") as?  String
        status               = aDecoder.decodeObject(forKey: "status") as?  String
        is_selected          = aDecoder.decodeObject(forKey: "is_selected") as?  Bool
    }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(thumbnail, forKey: "thumbnail")
        aCoder.encode(meta, forKey: "meta")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(is_selected, forKey: "is_selected")

    }
    


}
