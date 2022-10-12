//
//  UITextViewCommon.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit


protocol TextViewDelegate {
    
    func didBeginEditing(textField: UITextView)
    func didEndEditing(textField: UITextView)
}

class UITextViewCommon: UIView {
    
    @IBOutlet weak var txtHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var widthIcon: NSLayoutConstraint!
    @IBOutlet weak var heightIcon: NSLayoutConstraint!
    @IBOutlet weak var leadingIcon: NSLayoutConstraint!
    @IBOutlet weak var leadingLine: NSLayoutConstraint!
    
    var textFiledType : TextFieldType = .defaultType
    
    var delegate : GrowingTextViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit()  {
    
        Bundle.main.loadNibNamed("UITextViewCommon", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.textView.delegate = self
        self.textView.keyboardType = .default
        self.textView.placeholderColor = ColorConstants.PlaceHolderColor
        
        textView.minHeight = 30
        textView.maxHeight = 150
    }

    //Set TextFiled Type
    func setTextFiledProperty()  {
        self.textView.keyboardType = .default
    }

    //get Text
    func getText() -> String? {
        return textView.text
    }
    
    //Set Text
    func setText(text : String?)  {
        textView.text = text
    }
    
    //MARK: IBInspectable
    @IBInspectable
    var text: NSString {
        
        get {
            return  ""
        }
        set {
           textView.text = newValue as String
        }
    }
    
    @IBInspectable
    var placeholder: NSString {
        
        get {
            return (textView?.placeholder ?? "") as NSString
        }
        set {
           textView.placeholder = LanguageManager.localizedString(newValue as String)
            changeLabel()
        }
    }
    
    @IBInspectable
    var textcolor: NSString {
        
        get {
            return  ""
        }

        set {
            textView.textColor = ColorScheme.colorFromConstant(textColorConstant: newValue as String)
        }
    }
    
    @IBInspectable
    var textFieldBackGroundColor: UIColor = ColorConstants.BgColor{
        
        didSet{
            self.viewMain.backgroundColor = textFieldBackGroundColor
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
    var isIcon: Bool = true {
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
            
            self.setTextFiledProperty()
        }
    }
    
    var editingOrSelected = false
    
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
}

extension UITextViewCommon: GrowingTextViewDelegate {
    
    // MARK: - Helpers
    
    fileprivate func titleOrPlaceholder() -> String? {
        return placeholder as String
    }
    
    fileprivate func selectedTitleOrTitlePlaceholder() -> String? {
        return placeholder as String
    }
    
    func changeLabel() {
        guard let titleLabel = lblTitle else {
            return
        }
               
        var titleText: String? = nil
        if editingOrSelected {
            titleText = selectedTitleOrTitlePlaceholder()
            if titleText == nil {
                titleText = titleOrPlaceholder()
            }
            titleLabel.textColor = ColorConstants.ThemeColor
        } else {
            titleText = titleOrPlaceholder()
            titleLabel.textColor = ColorConstants.PlaceHolderColor
        }
        titleLabel.text = titleText
        
        updateTitleVisibility()
    }
    
    open func isTitleVisible() -> Bool {
        return editingOrSelected || (getText()?.count ?? 0 > 0)
    }
    
    fileprivate func updateTitleVisibility(_ animated: Bool = false, completion: ((_ completed: Bool) -> Void)? = nil) {
        let alpha: CGFloat = isTitleVisible() ? 1.0 : 0.0
        let updateBlock = { () -> Void in
            self.lblTitle.alpha = alpha
        }
        if animated {
            let animationOptions: UIView.AnimationOptions = .curveEaseOut
            let titleFadeInDuration: TimeInterval = 0.2
            let duration = titleFadeInDuration
            UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: { () -> Void in
                updateBlock()
            }, completion: completion)
        } else {
            updateBlock()
            completion?(true)
        }
    }
    
    func textViewDidBegin(_ textView: GrowingTextView) {
        editingOrSelected = true
        changeLabel()
        self.delegate?.textViewDidBegin?(textView)
    }
    
    func textViewDidEnd(_ textView: GrowingTextView) {
        editingOrSelected = false
        changeLabel()
        self.delegate?.textViewDidEnd?(textView)
    }
    
    // *** Call layoutIfNeeded on superview for animation when changing height ***
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            
            self.txtHeight.constant = height
            
            self.setNeedsLayout()
            self.setNeedsDisplay()
            self.layoutIfNeeded()
            
            self.delegate?.textViewDidChangeHeight?(textView, height: height)
            
        }, completion: nil)
    }
}

//MARK: textField delegate methods
extension UITextViewCommon : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if !text.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        
        if self.textFiledType == .email || self.textFiledType == .password || self.textFiledType == .mobile {
            if text == " " { return false }
        }
        
        if range.location == 0{
            
            if text == " " {
                return false
            }
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.setText(text: textView.text)
    }
}


