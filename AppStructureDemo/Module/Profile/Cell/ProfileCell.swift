//
//  ProfileCell.swift
//  CommonBase
//
//  Created by Romil Dhanani on 20/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell  {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var txtTextfeild : UITextFiledCommon!
    @IBOutlet weak var btnClick : UIButtonCommon!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtTextfeild.delegate = self
        txtTextfeild.textField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setData(_ model: CellModel){
        //        lblTitle.text = model.userText1
        if model.cellType == .Logout{
            btnClick.isHidden = false
            txtTextfeild.isHidden = true
            btnClick.button.backgroundColor = ColorConstants.ThemeColor
            btnClick.CornerRadius = btnClick.frame.height / 2
            btnClick.text = LanguageManager.localizedString("KLblLogout") as! NSString
            btnClick.click = {
                print("Submit")
            // Multi Button
                UIViewController.current().view.showConfirmationPopupWithMultiButton(title: StringConstants.LoginScreen.KLblLogout, message: StringConstants.Common.kMsglogout, cancelButtonTitle: StringConstants.ButtonTitles.KCancel, confirmButtonTitle: StringConstants.ButtonTitles.kSubmit, onConfirmClick: {
                    print("Submit")
                
                    ApplicationData.sharedInstance.logoutUser()
                
                 }, onCancelClick: {
                    print("cancel")
                })
                // Single Button
//                UIViewController.current().view?.showConfirmationPopupWithSingleButton(title: StringConstants.LoginScreen.KLblLogout, message: StringConstants.Common.kMsglogout, confirmButtonTitle: StringConstants.ButtonTitles.kSubmit, onConfirmClick: {
//                    print("Submit")
//
//                    ApplicationData.sharedInstance.logoutUser()
//
//                 })


            }
        }else{
            txtTextfeild.isIcon = false
            txtTextfeild.showBottomBorder = false
            txtTextfeild.lblTitle.text = model.userText1!
            txtTextfeild.textField.text = model.userText
            txtTextfeild.textField.placeholderText = model.placeholder! as NSString
        }
        
    }
    
}
extension ProfileCell :TextFieldDelegate, UITextFieldDelegate {
    func didBeginEditing(textField: UITextField) {
        
    }
    
    func didEndEditing(textField: UITextField) {
        
    }
    
    func shouldReturn(textField: UITextField) {
        
    }
    
    
}
