//
//  PostModel.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import Foundation
import ObjectMapper

class UserModel : NSObject, Mappable, NSCoding {
    var id : Int?
    var app_no : String?
    var first_name : String?
    var last_name : String?
    var username : String?
    var email : String?
    var login_type : String?
    var gender : String?
    var profile_picture : String?
    var thumbnail : String?
    var about : String?
    var timezone : String?
    var gmt_time : String?
    var app_version : String?
    var is_allow_notification : Int?
    var is_term_condition : Int?
    var is_login : Int?
    var status : String?
    var user_category : [UserCategoryModel]?
    var access_token : String?
    
    override init() {
    }

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        app_no <- map["app_no"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        username <- map["username"]
        email <- map["email"]
        login_type <- map["login_type"]
        gender <- map["gender"]
        profile_picture <- map["profile_picture"]
        thumbnail <- map["thumbnail"]
        about <- map["about"]
        timezone <- map["timezone"]
        gmt_time <- map["gmt_time"]
        app_version <- map["app_version"]
        is_allow_notification <- map["is_allow_notification"]
        is_term_condition <- map["is_term_condition"]
        is_login <- map["is_login"]
        status <- map["status"]
        user_category <- map["user_category"]
        access_token <- map["access_token"]
    }
    //Decoding
    required init?(coder aDecoder: NSCoder) {
        
        id                  = aDecoder.decodeObject(forKey: "id") as? Int
        app_no              = aDecoder.decodeObject(forKey: "app_no") as?  String
        first_name          = aDecoder.decodeObject(forKey: "first_name") as?  String
        last_name           = aDecoder.decodeObject(forKey: "last_name") as?  String
        username            = aDecoder.decodeObject(forKey: "username") as?  String
        email               = aDecoder.decodeObject(forKey: "email") as?  String
        login_type          = aDecoder.decodeObject(forKey: "login_type") as?  String
        gender              = aDecoder.decodeObject(forKey: "gender") as?  String
        profile_picture     = aDecoder.decodeObject(forKey: "profile_picture") as? String
        thumbnail           = aDecoder.decodeObject(forKey: "thumbnail") as?  String
        about               = aDecoder.decodeObject(forKey: "about") as?  String
        timezone            = aDecoder.decodeObject(forKey: "timezone") as?  String
        gmt_time            = aDecoder.decodeObject(forKey: "gmt_time") as?  String
        app_version         = aDecoder.decodeObject(forKey: "app_version") as?  String
        is_allow_notification = aDecoder.decodeObject(forKey: "is_allow_notification") as?  Int
        is_term_condition   = aDecoder.decodeObject(forKey: "is_term_condition") as?  Int
        is_login            = aDecoder.decodeObject(forKey: "is_login") as?  Int
        status              = aDecoder.decodeObject(forKey: "status") as?  String
        user_category       = aDecoder.decodeObject(forKey: "user_category") as? [UserCategoryModel]
        access_token        = aDecoder.decodeObject(forKey: "access_token") as?  String
    }
    //Encoding
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(id, forKey: "id")
        aCoder.encode(app_no, forKey: "app_no")
        aCoder.encode(first_name, forKey: "first_name")
        aCoder.encode(last_name, forKey: "last_name")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(login_type, forKey: "login_type")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(profile_picture, forKey: "profile_picture")
        aCoder.encode(thumbnail, forKey: "thumbnail")
        aCoder.encode(about, forKey: "about")
        aCoder.encode(timezone, forKey: "timezone")
        aCoder.encode(gmt_time, forKey: "gmt_time")
        aCoder.encode(app_version, forKey: "app_version")
        aCoder.encode(is_allow_notification, forKey: "is_allow_notification")
        aCoder.encode(is_term_condition, forKey: "is_term_condition")
        aCoder.encode(is_login, forKey: "is_login")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(user_category, forKey: "user_category")
        aCoder.encode(access_token, forKey: "access_token")
    }

    
    
    public var getFullName : String? {
        var arr = [String]()
        
        if let fn = first_name {
            arr.append(fn.capitalized)
        }
        
        if let ln = last_name {
            arr.append(ln.capitalized)
        }
        
        return arr.joined(separator: " ")
    }

    
}
class PostModel : Mappable {
    var id : Int?
    var user_id : Int?
    var post_type : String?
    var post : String?
    var thumbnail : String?
    var masked_thumbnail : String?
    var description : String?
    var post_date : String?
    var post_time : String?
    var allow_commenting : Int?
    var is_self_liked : Int?
    var is_updated : Int?
    var is_reported : Int?
    var is_blocked : Int?
    var status : String?
    var user : UserModel?
    var total_likes : Int?
    var total_dislike : Int?
    var total_views : Int?
    var comments : [CommentModel]?
    var post_timestamp : Int?
    var days : String?
    var hours : String?
    var minutes : String?
    var shareable_link : String?
    var post_categories : [PostCategoriesModel]?
    var post_tags : [PostTagsModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {

        id <- map["id"]
        user_id <- map["user_id"]
        post_type <- map["post_type"]
        post <- map["post"]
        thumbnail <- map["thumbnail"]
        masked_thumbnail <- map["masked_thumbnail"]
        description <- map["description"]
        post_date <- map["post_date"]
        post_time <- map["post_time"]
        allow_commenting <- map["allow_commenting"]
        is_self_liked <- map["is_self_liked"]
        is_updated <- map["is_updated"]
        is_reported <- map["is_reported"]
        is_blocked <- map["is_blocked"]
        status <- map["status"]
        user <- map["user"]
        total_likes <- map["total_likes"]
        total_dislike <- map["total_dislike"]
        total_views <- map["total_views"]
        comments <- map["comments"]
        post_timestamp <- map["post_timestamp"]
        days <- map["days"]
        hours <- map["hours"]
        minutes <- map["minutes"]
        shareable_link <- map["shareable_link"]
        post_categories <- map["post_categories"]
        post_tags <- map["post_tags"]
    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
//        post_type = try values.decodeIfPresent(String.self, forKey: .post_type)
//        post = try values.decodeIfPresent(String.self, forKey: .post)
//        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
//        masked_thumbnail = try values.decodeIfPresent(String.self, forKey: .masked_thumbnail)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        post_date = try values.decodeIfPresent(String.self, forKey: .post_date)
//        post_time = try values.decodeIfPresent(String.self, forKey: .post_time)
//        allow_commenting = try values.decodeIfPresent(Int.self, forKey: .allow_commenting)
//        is_self_liked = try values.decodeIfPresent(Int.self, forKey: .is_self_liked)
//        is_updated = try values.decodeIfPresent(Int.self, forKey: .is_updated)
//        is_reported = try values.decodeIfPresent(Int.self, forKey: .is_reported)
//        is_blocked = try values.decodeIfPresent(Int.self, forKey: .is_blocked)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        user = try values.decodeIfPresent(UserModel.self, forKey: .user)
//        total_likes = try values.decodeIfPresent(Int.self, forKey: .total_likes)
//        total_dislike = try values.decodeIfPresent(Int.self, forKey: .total_dislike)
//        total_views = try values.decodeIfPresent(Int.self, forKey: .total_views)
//        comments = try values.decodeIfPresent([CommentModel].self, forKey: .comments)
//        post_timestamp = try values.decodeIfPresent(Int.self, forKey: .post_timestamp)
//        days = try values.decodeIfPresent(String.self, forKey: .days)
//        hours = try values.decodeIfPresent(String.self, forKey: .hours)
//        minutes = try values.decodeIfPresent(String.self, forKey: .minutes)
//        shareable_link = try values.decodeIfPresent(String.self, forKey: .shareable_link)
//        post_categories = try values.decodeIfPresent([PostCategoriesModel].self, forKey: .post_categories)
//        post_tags = try values.decodeIfPresent([PostTagsModel].self, forKey: .post_tags)
//    }
//
    
}

class CommentModel : Mappable {
    var id : Int?
    var commented_by : String?
    var comment : String?
    var created_at : String?
    var total_likes : Int?
    var total_dislikes : Int?
    var likes : [String]?
    var is_self_liked : Int?
    var profile_picture : String?
    var thumbnail : String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {

        id <- map["id"]
        commented_by <- map["commented_by"]
        comment <- map["comment"]
        created_at <- map["created_at"]
        total_likes <- map["total_likes"]
        total_dislikes <- map["total_dislikes"]
        likes <- map["likes"]
        is_self_liked <- map["is_self_liked"]
        profile_picture <- map["profile_picture"]
        thumbnail <- map["thumbnail"]
    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        commented_by = try values.decodeIfPresent(String.self, forKey: .commented_by)
//        comment = try values.decodeIfPresent(String.self, forKey: .comment)
//        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
//        total_likes = try values.decodeIfPresent(Int.self, forKey: .total_likes)
//        total_dislikes = try values.decodeIfPresent(Int.self, forKey: .total_dislikes)
//        likes = try values.decodeIfPresent([String].self, forKey: .likes)
//        is_self_liked = try values.decodeIfPresent(Int.self, forKey: .is_self_liked)
//        profile_picture = try values.decodeIfPresent(String.self, forKey: .profile_picture)
//        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
//    }
}

class PostCategoriesModel : Mappable {
    var id : Int?
    var post_id : Int?
    var category_id : Int?
    var category : String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {

        id <- map["id"]
        post_id <- map["post_id"]
        category_id <- map["category_id"]
        category <- map["category"]
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        post_id = try values.decodeIfPresent(Int.self, forKey: .post_id)
//        category_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
//        category = try values.decodeIfPresent(String.self, forKey: .category)
//    }

}

class PostTagsModel : Mappable {
    var id : Int?
    var post_id : Int?
    var tag_id : Int?
    var created_at : String?
    var tag : String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {

        id <- map["id"]
        post_id <- map["post_id"]
        tag_id <- map["tag_id"]
        created_at <- map["created_at"]
        tag <- map["tag"]
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        post_id = try values.decodeIfPresent(Int.self, forKey: .post_id)
//        tag_id = try values.decodeIfPresent(Int.self, forKey: .tag_id)
//        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
//        tag = try values.decodeIfPresent(String.self, forKey: .tag)
//    }

}
