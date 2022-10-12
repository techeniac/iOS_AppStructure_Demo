//
//  ExtensionClass.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension Data {
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

extension UIButton{
    
    @IBInspectable
    var TextColorKey: NSString   {
        
        get {
            return  "nil"
        }
        
        set {
            
            setTitleColor(ColorScheme.colorFromConstant(textColorConstant: newValue as String), for: .normal)
        }
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        
        layer.addSublayer(border)
    }
}

extension UITextField{
    
    @IBInspectable
    var PlaceHolderColorKey: NSString   {
        
        get {
            return  "nil"
        }
        
        set {
            
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: ColorScheme.colorFromConstant(textColorConstant: newValue as String)])
        }
        
    }
    
    @IBInspectable
    var TextColorKey: NSString   {
        
        get {
            return  "nil"
        }
        
        set {
            
            textColor = ColorScheme.colorFromConstant(textColorConstant: newValue as String)
        }
    }
    
    @IBInspectable
    var placeholderText: NSString {
        
        get {
            return (placeholder ?? "") as NSString
        }
        set {
            placeholder = LanguageManager.localizedString(newValue as String)
        }
    }
    
    func textFieldLeftPadding(padding : CGFloat) {
        // Create a padding view
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftViewMode = .always//For left side padding
    }
    
    func textFieldRightPadding(padding : CGFloat) {
        // Create a padding view
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.rightViewMode = .always//For left side padding
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

// Statusbar background color
extension UIApplication {
    var statusBarView: UIView? {
        
        if #available(iOS 13.0, *) {

            if let frame = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame {
                let statusBar1 =  UIView()
                statusBar1.frame = frame
                UIApplication.shared.keyWindow?.addSubview(statusBar1)
                return statusBar1
            }
            
        }
        
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

extension Array {
    
    func groupBy<G: Hashable>(groupClosure: (Element) -> G) -> [G: [Element]] {
        var dictionary = [G: [Element]]()
        
        for element in self {
            let key = groupClosure(element)
            var array: [Element]? = dictionary[key]
            
            if (array == nil) {
                array = [Element]()
            }
            
            array!.append(element)
            dictionary[key] = array!
        }
        
        return dictionary
    }
}

extension UINavigationController{
    
    func popAllAndSwitch(to : UIViewController){
        
        self.setViewControllers([to], animated: false)
    }
}

extension UIViewController {
    
    func isPresented() -> Bool {
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
    //MARK:- IBActions
    func showLeftMenu(){
        
        let btnMenu = UIButton(frame : CGRect(x: 0, y: 0, width: 25, height: 25))
        btnMenu.setImage(#imageLiteral(resourceName: "menu-button"), for: .normal)
        btnMenu.addTarget(self, action: #selector(btnMenu_Click), for: .touchUpInside)
        btnMenu.tintColor = UIColor.white
        let menu = UIBarButtonItem(customView: btnMenu)
        self.navigationItem.setLeftBarButton(menu, animated: true)
    }
    
    @objc func btnMenu_Click(){
        
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
}

extension UITableView {
    
    func addScrollToTopButton(_ tralingSpace : CGFloat = 0){
        
        //let btn = UIButton(frame: CGRect(x: self.frame.size.width - 60, y: self.frame.size.height - 50, width: 70, height: 50))
        
        
        let btn = UIButton(frame: CGRect(x: AppConstants.ScreenSize.SCREEN_WIDTH - 50 - tralingSpace, y: AppConstants.ScreenSize.SCREEN_HEIGHT - 180, width: 50, height: 30))
        btn.tag = 1002
        btn.isHidden = true
        btn.addTarget(self, action: #selector(self.btnScroll(_:)), for: .touchUpInside)
        btn.setImage(UIImage(named : "UpScroll"), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIViewController.current().view.addSubview(btn)
        }
    }
    
    @objc func btnScroll(_ sender: UIButton){
        
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func handleScrollPosition(scrollView: UIScrollView){
        
        if scrollView.contentOffset.y > (self.frame.size.height - 300) {
            
            let btn = UIViewController.current().view.viewWithTag(1002)
            btn?.isHidden = false
        }
        else{
            
            let btn = UIViewController.current().view.viewWithTag(1002)
            btn?.isHidden = true
        }
    }
}
