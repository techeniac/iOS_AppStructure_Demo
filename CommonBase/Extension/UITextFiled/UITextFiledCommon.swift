//
//  UITextFiledCommon.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

enum TextFieldType
{
    case defaultType //0
    case email //1
    case password // 2
    case mobile //3
    case clickable //4
    case dropdown //4
}

protocol TextFieldDelegate {
    
    func didBeginEditing(textField:UITextField)
    func didEndEditing(textField:UITextField)
    func shouldReturn(textField:UITextField)
}

class UITextFiledCommon: UIView {
    
    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var viewTxt : UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewBottomBorder: UIView!
    @IBOutlet weak var btnTap: UIButton!

    @IBOutlet weak var widthIcon: NSLayoutConstraint!
    @IBOutlet weak var heightIcon: NSLayoutConstraint!
    @IBOutlet weak var leadingIcon: NSLayoutConstraint!
    @IBOutlet weak var leadingLine: NSLayoutConstraint!
    @IBOutlet weak var widthBtnEye: NSLayoutConstraint!
    @IBOutlet weak var tralingEyeBtn: NSLayoutConstraint!
    @IBOutlet weak var leadingEyeBtn: NSLayoutConstraint!
    
    
    var textFiledType : TextFieldType = .defaultType
    
    var delegate : TextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit()  {
    
        Bundle.main.loadNibNamed("UITextFiledCommon", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.textField.delegate = self
        self.textField.keyboardType = .default
    }

    //Set TextFiled Type
    func setTextFiledProperty()  {
        
        if self.textFiledType == .email {
            self.textField.keyboardType = .emailAddress
        }
        else if self.textFiledType == .password {
            self.textField.isSecureTextEntry = true
        }
        else if self.textFiledType == .mobile {
            self.textField.keyboardType = .numberPad
        }
        else{
            self.textField.keyboardType = .default
            self.textField.isSecureTextEntry = false
        }
        
        self.manageEyeButton()
    }
    
    //Manage Password Show Button
    func manageEyeButton() {
        
        if self.textFiledType == .password || self.textFiledType == .dropdown {
            widthBtnEye.constant = 30
//            tralingEyeBtn.constant = 0
        } else {
            widthBtnEye.constant = 0
//            tralingEyeBtn.constant = 16
        }
        
        if self.textFiledType == .dropdown {
            btnEye.isUserInteractionEnabled = false
            btnEye.tintColor = ColorConstants.DarkTextColor
            self.setRightIcon = "caret-down"
        }
    }
    
    //get Text
    func getText() -> String? {
    
        
        return textField.text
    }
    
    //Set Text
    func setText(text : String?)  {
        
        textField.text = text
    }
    
    //MARK: IBInspectable
    @IBInspectable
    var text: NSString {
        
        get {
            return  ""
        }
        set {
           textField.text = newValue as String
        }
    }
    
    @IBInspectable
    var placeholder: NSString {
        
        get {
            return  ""
        }
        set {
           textField.placeholder = LanguageManager.localizedString(newValue as String)
        }
    }
    
    @IBInspectable
    var textcolor: NSString {
        
        get {
            return  ""
        }

        set {
            textField.textColor = ColorScheme.colorFromConstant(textColorConstant: newValue as String)
        }
    }
    
    @IBInspectable
    var textFieldBackGroundColor: UIColor = ColorConstants.ThemeColor{
        
        didSet{
            self.viewMain.backgroundColor = .clear
        }
    }
    
    @IBInspectable
    var icon: NSString {
        
        get {
            return  ""
        }
        
        set {
            imgView.image = UIImage(named: newValue as String)
        }
    }
    
    @IBInspectable
    var isSecureText: Bool = false {
        
        didSet{
            textField.isSecureTextEntry = isSecureText as Bool
        }
    }
    
    @IBInspectable
    var setRightIcon: NSString {
        
        get {
            return ""
        }
        
        set{
            if widthBtnEye.constant == 0 {
                widthBtnEye.constant = 30
//                tralingEyeBtn.constant = 16
            }
            btnEye.setImage(UIImage(named: (newValue as String))?.withRenderingMode(.alwaysTemplate) , for: .normal)
        }
    }
    
    @IBInspectable
    var isIcon: Bool = false {
        didSet{
            
            if isIcon == false {
                widthIcon.constant = 0
                heightIcon.constant = 0
                leadingIcon.constant = 0
                leadingLine.constant = 0
                viewLine.isHidden = true
            }
        }
    }
    
    @IBInspectable
    var type: Int = 0 {
        didSet{
            
            if type == 1 {
                self.textFiledType = .email
            }
            else if type == 2 {
                self.textFiledType = .password
            }
            else if type == 3 {
                self.textFiledType = .mobile
            }
            else if type == 4 {
                self.textFiledType = .clickable
            }
            else if type == 5 {
                self.textFiledType = .dropdown
            }
            else {
                self.textFiledType = .defaultType
            }
            self.setTextFiledProperty()
        }
    }
    
    @IBInspectable
    var isBorder: Bool = false {
        didSet{
            if isBorder == true{
                viewMain.layer.borderColor = ColorConstants.BorderColor.cgColor
                viewMain.layer.borderWidth = 0.5
                viewMain.layer.cornerRadius = 5.0
            }
        }
    }
    
    @IBInspectable
    var showBottomBorder: Bool = false {
        didSet{
            if isBorder == false{
                viewBottomBorder.isHidden = true
            }
        }
    }

    //MARK: Action
    @IBAction func btnPasswordShow_Click(_ sender: UIButton) {
        
        if textField.isSecureTextEntry == true{
            sender.isSelected = true
            textField.isSecureTextEntry = false
        }else{
            sender.isSelected = false
            textField.isSecureTextEntry = true
        }
    }
    
    @IBAction func btnTapped(_ sender: UIButton) {
        textField.becomeFirstResponder()
    }
}

//MARK: textField delegate methods
extension UITextFiledCommon : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        
        if self.textFiledType == .email || self.textFiledType == .password || self.textFiledType == .mobile {
            if string == " " { return false }
        }

        if range.location == 0{
            
            if string == " " {
                return false
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.delegate?.shouldReturn(textField: textField)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.setText(text: textField.text)
        
        self.delegate?.didEndEditing(textField: textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if self.textFiledType == .clickable{
            
            self.delegate?.didBeginEditing(textField: textField)
            
        }
    }
}




