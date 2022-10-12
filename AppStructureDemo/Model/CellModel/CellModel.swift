//
//  CellModel.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class CellModel: NSObject {
    
    var placeholder : String?
    var placeholder2 : String?
    var userText : String?
    var userText1 : String?
    var cellType : CellType?
    var classType : ClassType?
    var cellObj : Any?
    var cellObj1 : Any?
    var imageName: String?
    var keyboardType: UIKeyboardType?
    var isSelected : Bool = false
    var isNoBgmSelected : Bool = false
    var isTHREEEXSelected : Bool = false
    var isTWOEXSelected : Bool = false
    var isTHREEVGSelected : Bool = false
    var selectedDate : Date?
    var dataArr = [Any]()
    var dataArr1 = [Any]()
    var dataArr2 = [Any]()
    var textFieldReturnType: UIReturnKeyType?
    var floatValue : CGFloat?
    var message : String?
    var apiKey : String?
    var errorMsg : String?
    var isRequired : Bool = false
    var isExpand:Bool = false
    var isColor:Bool = false
    var date:Date? = nil
    var isAllSelected : Bool = false
    var isAllSelected1 : Bool = false
    var isAllSelected2 : Bool = false
    
    var from : String?
    var to : String?
    
    var filterGroupTag : Int = 0
    var count : Int = 0
    var isContains : Bool = true

    override init() {
    }
    
    //Get From TO request
    func getFromToRequest() -> [String : Any]? {
        
        var request = [String : Any]()
        
        if let from = from,from.count > 0 {
            request[">="] = from
        }
        
        if let to = to,to.count > 0 {
            request["<="] = to
        }
        
        return request.count > 0 ? request : nil
    }
    
    
    class func getSelectedId(masters : [SelectionPopupModel]) -> [String]? {
        
        var ids = [String]()
        for item in masters {
            if item.isSelected {
                ids.append(item.id ?? "")
            }
        }
        
        if ids.count > 0{
            return ids
        }
        
        return nil
    }
    
    
    //Get Model
    
    class func getModel(placeholder : String? = nil,placeholder2:String? = nil, text : String? = nil, userText1: String? = nil,type : CellType, classType: ClassType? = nil, imageName:String? = nil,cellObj:Any? = nil,dataArr : [Any] = [Any](),keyBoardType : UIKeyboardType? = .default,textFieldReturnType: UIReturnKeyType? = .default, isRequired : Bool = false,  apiKey : String = "", errorMsg : String = "", isSelected:Bool = false, date:Date? = nil,dataArr1 : [Any] = [Any](),dataArr2 : [Any] = [Any](), isExpand:Bool = false, isColor:Bool = false, filterGroupTag:Int = 0, count: Int = 0) -> CellModel {
        
        let model = CellModel()
        model.placeholder = placeholder
        model.placeholder2 = placeholder2
        model.userText = text
        model.cellType = type
        model.classType = classType
        model.cellObj = cellObj
        model.imageName = imageName
        model.keyboardType = keyBoardType
        model.textFieldReturnType = textFieldReturnType
        model.apiKey = apiKey
        model.errorMsg = errorMsg
        model.isRequired = isRequired
        model.isSelected = isSelected
        model.date = date
        model.dataArr1 = dataArr1
        
        model.dataArr2 = dataArr2
        model.userText1 = userText1
        model.isExpand = isExpand
        model.isColor = isColor
        model.filterGroupTag = filterGroupTag
        model.count = count
        
        if dataArr.count > 0
        {
            model.dataArr = dataArr
        }
        
        return model
    }
  
    class func getLeftMenuModel(text : String,type : CellType,imageName:String) -> CellModel {
        
        let model = CellModel()
        model.userText = text
        model.cellType = type
        model.imageName = imageName
        return model
    }
}
