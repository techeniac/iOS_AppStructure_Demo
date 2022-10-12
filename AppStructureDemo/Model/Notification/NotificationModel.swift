//
//  NotificationModel.swift
//  CommonBase
//
//  Created by Romil Dhanani on 21/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import Foundation
import ObjectMapper

class NotificationModel: Mappable {
    var id: Int?
    var userID: Int?
    var typeID: Int?
    var sentBy: SendByModel?
    var type: String?
    var title: String?
    var subTitle: String?
    var body: String?
    var isRead: Int?
    var notificationFor: String?
    var notificationTime: String?
    var post: PostModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        userID <- map["user_id"]
        typeID <- map["type_id"]
        sentBy <- map["sent_by"]
        type <- map["type"]
        title <- map["title"]
        subTitle <- map["sub_title"]
        body <- map["body"]
        isRead <- map["is_read"]
        notificationFor <- map["notification_for"]
        notificationTime <- map["notification_time"]
        post <- map["post"]
    }
    
    
}
class SendByModel: Mappable{
    var id: Int?
    var firstName, lastName: String?
    var thumbnail: String?
    var timezone: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        thumbnail <- map["thumbnail"]
        timezone <- map["timezone"]
        
    }
    
}










