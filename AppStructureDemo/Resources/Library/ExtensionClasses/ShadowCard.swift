//
//  ShadowCard.swift
//  PTE
//
//  Created by CS-MacSierra on 14/09/17.
//  Copyright © 2017 CS-Mac-Mini. All rights reserved.
//

import UIKit

@IBDesignable

class ShadowCard: UIView {
   
   @IBInspectable
    var index: Int = 0
    @IBInspectable
    var maxHeight: CGFloat = 0.0
    @IBInspectable
    var minHeight: CGFloat = 0.0
    @IBInspectable
    var noCorener: Bool = false
    @IBInspectable
    var viewCornerRadius: CGFloat = 4.0
    @IBInspectable
    var mainBGColor: UIColor = UIColor.white
    @IBInspectable
    var shadowColor: String = "kShadowColor"
    
    override func layoutSubviews() {
        let view1 = self.viewWithTag(123456)
        view1?.removeFromSuperview()

        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        if noCorener {
            view.layer.cornerRadius = 0.0
        }
        else {
            view.layer.cornerRadius = viewCornerRadius
        }
        insertSubview(view, at: 0)
        view.tag = 123456
        view.backgroundColor = mainBGColor
        layer.shadowColor = ColorScheme.colorFromConstant(textColorConstant: shadowColor).cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 4.5
        layer.shadowOpacity = 1
        if noCorener {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 0.0).cgPath
        }
        else {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: viewCornerRadius).cgPath
        }
        layer.masksToBounds = false
        layer.backgroundColor = UIColor.clear.cgColor
        backgroundColor = UIColor.clear
    }
}
