//
//  UIButtonCommon.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit
 

class UIButtonCommon: UIView {
    
    @IBOutlet weak var viewBackground: SoftUIView!
    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var button: UIButton!
    var click:(()->())?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit()  {
        
        Bundle.main.loadNibNamed("UIButtonCommon", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
     
        button.setTitleColor(ColorConstants.ButtonTextColor, for: .normal)
        
        viewBackground.tintColor = ColorConstants.ThemeColor
        viewBackground.type = .pushButton
        viewBackground.cornerRadius = viewBackground.frame.height / 2
    }
    
    
    func addShadow() {
        
        contentView.layer.shadowColor = ColorConstants.ButtonShadowColor.cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize.zero
        contentView.layer.shadowRadius = 2.0
        contentView.layer.cornerRadius = 4
        button.backgroundColor = ColorConstants.ButtonBgColor
//        button.applyButtonGradient(colours: [#colorLiteral(red: 0.1725490196, green: 0.2392156863, blue: 0.6392156863, alpha: 1),#colorLiteral(red: 0.1098039216, green: 0.1607843137, blue: 0.4784313725, alpha: 1)])
    }
    
    @IBAction func button_Click(_ sender: UIButton) {
        if let cc = click {
            cc()
        }
    }
    
    //MARK: IBInspectable
    @IBInspectable
    var text: NSString {
        
        get {
            return  ""
        }
        set {
            button.setTitle(LanguageManager.localizedString(newValue as String), for: .normal)
        }
    }
    
    
    //MARK: IBInspectable
    @IBInspectable
    var Name: NSString {
        
        get {
            return  ""
        }
        set {
            button.setTitle(LanguageManager.localizedString(newValue as String), for: .normal)
        }
    }

    //MARK: IBInspectable
    @IBInspectable
    var imageRight: NSString {
        
        get {
            return  ""
        }
        set {
            
            if newValue.length > 0 {
                button.setImage(UIImage(named: newValue as String), for: .normal)
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            }
        }
    }
}
