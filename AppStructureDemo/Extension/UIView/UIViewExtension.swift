//
//  UIViewExtension.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

//MARK: UIView IBInspactable
extension UIView {
    
    //-------- Language Support
    @IBInspectable
    var NSLanguageKey: NSString   {
        
        get {
            return  "nil"
        }
        
        set {
            let localizedString = LanguageManager.localizedString(newValue as String)
            
            //UILabel
            if let lbl = self as? UILabel{
                lbl.text = localizedString
            }
            
            //UIButton
            if let btn = self as? UIButton{
                btn.setTitle(localizedString, for: .normal)
            }
            
            //UITextField
            if let txt = self as? UITextField{
                txt.text = localizedString
            }
        }
    }
    
    @IBInspectable
    var BackgroundColorKey: NSString   {
        
        get {
            return  "nil"
        }
        
        set {
            backgroundColor = ColorScheme.colorFromConstant(textColorConstant: newValue as String)
        }
    }
    
    @IBInspectable
    var TintColorKey: NSString   {
        
        get {
            return  "nil"
        }
        
        set {
            self.tintColor = ColorScheme.colorFromConstant(textColorConstant: newValue as String)
        }
    }
        
    @IBInspectable
    var BorderColorKey: NSString   {
        
        get {
            return  "nil"
        }
        
        set {
            layer.borderColor = ColorScheme.colorFromConstant(textColorConstant: newValue as String).cgColor
        }
    }
    
    @IBInspectable
    var CornerRadius: CGFloat {
        get {
            return  0.0
        }
        
        set {
            layer.cornerRadius = newValue as CGFloat
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var BorderWidth: CGFloat   {
        
        get {
            return  0.0
        }
        
        set {
            layer.borderWidth = newValue as CGFloat
        }
    }
    
    
    func dropShadow() {
        
        layer.shadowColor = ColorConstants.ShadowColor.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5.0
    }
    
    // set Corner Radius
    func setCornerRadius(radius:CGFloat)
    {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    // set Corner Radius
    func setBorderWidth(width : CGFloat)
    {
        self.layer.borderWidth = width
        self.layer.masksToBounds = true
    }
    
    // set Corner Radius
    func setBorderColor(color:UIColor)
    {
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
    
    func setCornerWithShadow(radius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.0
    }
    
    func customRoundCornerWithShadow(shadowColor: UIColor) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.0
    }
        
    //MARK: giving corner from particular side
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat ,width : CGFloat,height : CGFloat = AppConstants.ScreenSize.SCREEN_HEIGHT) {
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        let path = UIBezierPath(roundedRect: frame, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
    func addDashedBorderVertical(frame: CGRect, color : UIColor, isVertical : Bool = true) {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2,2]
        
        let path = CGMutablePath()
        if isVertical == true{
            path.addLines(between: [CGPoint(x: 0, y: 0),
                                    CGPoint(x: 0, y: frame.height)])
        }else{
            path.addLines(between: [CGPoint(x: 0, y: 0),
                                    CGPoint(x: AppConstants.ScreenSize.SCREEN_WIDTH - 40, y: 0)])
        }
        
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    // MARK: Show Confirmation Popup with Multiple Button
    func showConfirmationPopupWithMultiButton(title: String?,message:String,cancelButtonTitle:String, confirmButtonTitle:String, onConfirmClick: @escaping () -> (), onCancelClick: @escaping () -> ()){
        
        self.window?.rootViewController?.view.endEditing(true)
        
        let vc = ConfirmPopupVC(nibName: "ConfirmPopupVC", bundle: nil)

        vc.headerTitle = title
        vc.message = message
        vc.cancelButtonTitle = cancelButtonTitle
        vc.confirmButtonTitle = confirmButtonTitle
        vc.confirmClicked = {
            onConfirmClick()
        }
        vc.cancelBtnClicked = {
            onCancelClick()
        }

        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        UIViewController.current()?.present(vc, animated: true, completion: {
        })
    }
    

    // MARK: Show Confirmation Popup with Single Button
    func showConfirmationPopupWithSingleButton(title: String?, message:String,  confirmButtonTitle:String, onConfirmClick: @escaping () -> ()){
        
        self.window?.rootViewController?.view.endEditing(true)
        
        let vc = ConfirmPopupVC(nibName: "ConfirmPopupVC", bundle: nil)
        vc.headerTitle = title
        vc.message = message
        vc.isShowSingleButton = true
        vc.confirmButtonTitle = confirmButtonTitle
        vc.confirmClicked = {
            onConfirmClick()
        }

        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        UIViewController.current()?.present(vc, animated: true, completion: {
        })
    }
    
    func returnConfirmationPopup(title: String?, message:String,  confirmButtonTitle:String, onConfirmClick: @escaping () -> ()) -> UIViewController{
        
//        let vc = ConfirmPopupVC(nibName: "ConfirmPopupVC", bundle: nil)
//        vc.headerTitle = title
//        vc.message = message
//        vc.isShowSingleButton = true
//        vc.confirmButtonTitle = confirmButtonTitle
//        vc.confirmClicked = {
//            onConfirmClick()
//        }
//
        return UIViewController()
    }
    
    func returnSelectionPopup(arr:[SelectionPopupModel], title:String, btnSubmitTitle : String = "", onSubmitClick: @escaping (SelectionPopupModel) -> ()) -> UIViewController{
        
        let vc = SelectionPopupVC(nibName: "SelectionPopupVC", bundle: nil)
        vc.strHeading = title
        vc.strSubmitText = btnSubmitTitle
        vc.arrData = arr
        vc.didSelect = { model in
            onSubmitClick(model)
        }
        
        return vc
    }
    
    func showSelectionPopup(arr:[SelectionPopupModel], title:String, btnSubmitTitle : String = "",isClearShow : Bool = false, onSubmitClick: @escaping (SelectionPopupModel) -> ()){
        
        self.window?.rootViewController?.view.endEditing(true)
        
        let vc = SelectionPopupVC(nibName: "SelectionPopupVC", bundle: nil)
        vc.strHeading = title
        vc.isClearOption = isClearShow
        vc.strSubmitText = btnSubmitTitle
        vc.arrData = arr
        vc.didSelect = { model in
            onSubmitClick(model)
        }
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        UIViewController.current()?.present(vc, animated: true, completion: {
        })
        
    }
    
    func showMultiSelectionPopup(arr:[SelectionPopupModel], title:String, btnSubmitTitle : String,validationMsg : String = "", onSubmitClick: @escaping ([SelectionPopupModel]) -> ()){
        
        self.window?.rootViewController?.view.endEditing(true)
        
        let vc = SelectionPopupVC(nibName: "SelectionPopupVC", bundle: nil)
        vc.validationMessage = validationMsg
        vc.strHeading = title
        vc.strSubmitText = btnSubmitTitle
        vc.arrData = arr
        vc.didMultiSelect = { model in
            onSubmitClick(model)
        }
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        UIViewController.current()?.present(vc, animated: true, completion: {
        })
        
    }
    
    
    
    func removeLoadAPIFailedView() {
        
        for vw in self.subviews{
            if let myvw = vw as? LoadAPIFailedView {
                myvw.removeFromSuperview()
            }
        }
        
    }
    
    func loadNoDataFoundView(message:String,image : String? = nil,isShowButton : Bool = false, onRefreshClick: @escaping () -> ()) {
        
        self.window?.rootViewController?.view.endEditing(true)
        
        let APIFailedView = Bundle.main.loadNibNamed("LoadAPIFailedView", owner: self, options: nil)?[0] as! LoadAPIFailedView
        APIFailedView.isShowRefreshButton = isShowButton
        APIFailedView.message = message
        APIFailedView.image = image
        
        APIFailedView.frame =  CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)

        
        var isFound = false
//        for vw in self.subviews{
//            if vw is LoadAPIFailedView{
//                isFound = true
//            }
//        }
        
        if !isFound{
            self.addSubview(APIFailedView)
            APIFailedView.layoutIfNeeded()
        }
        
        APIFailedView.btnRefreshClick = {
            onRefreshClick()
        }
    }
    
    func addshadow(top: Bool,
                   left: Bool,
                   bottom: Bool,
                   right: Bool,
                   shadowRadius: CGFloat = 2.0, width : CGFloat = 0, height : CGFloat = 0) {
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.6
        
        let path = UIBezierPath()
        var x: CGFloat = 0
        var y: CGFloat = -5
        
        var viewWidth = width == 0 ? self.frame.width : width
        var viewHeight = height == 0 ? self.frame.height+2 : height
        
        // here x, y, viewWidth, and viewHeight can be changed in
        // order to play around with the shadow paths.
        if (!top) {
            y+=(shadowRadius+1)
        }
        if (!bottom) {
            viewHeight-=(shadowRadius+1)
        }
        if (!left) {
            x+=(shadowRadius+1)
        }
        if (!right) {
            viewWidth-=(shadowRadius+1)
        }
        // selecting top most point
        path.move(to: CGPoint(x: x, y: y))
        // Move to the Bottom Left Corner, this will cover left edges
        /*
         |☐
         */
        path.addLine(to: CGPoint(x: x, y: viewHeight))
        // Move to the Bottom Right Corner, this will cover bottom edge
        /*
         ☐
         -
         */
        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
        // Move to the Top Right Corner, this will cover right edge
        /*
         ☐|
         */
        path.addLine(to: CGPoint(x: viewWidth, y: y))
        // Move back to the initial point, this will cover the top edge
        /*
         _
         ☐
         */
        path.close()
        self.layer.shadowPath = path.cgPath
    }
    
    func applyGradient(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x : 0.0, y : 0.5)
        gradient.endPoint = CGPoint(x :1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyButtonGradient(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: AppConstants.ScreenSize.SCREEN_WIDTH, height: 100)
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x : 0.0, y : 0.0)
        gradient.endPoint = CGPoint(x :0.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyRoundedButtonGradient(colours: [UIColor], shadowColor: UIColor? =  UIColor.gray, startPoint: CGPoint? = CGPoint(x : 0.0, y : 0.0), endPoint: CGPoint? = CGPoint(x :0.0, y: 1.0)) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = startPoint!
        gradient.endPoint = endPoint!
        gradient.cornerRadius = self.bounds.height / 2
        self.layer.insertSublayer(gradient, at: 0)
        
        layer.cornerRadius = self.bounds.height / 2

        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 1
        layer.shadowRadius = 1

    }
    
    func applyRoundedButtonGradientShadow(colours: [UIColor], startPoint: CGPoint? = CGPoint(x : 0.0, y : 0.0), endPoint: CGPoint? = CGPoint(x :0.0, y: 1.0)) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = startPoint!
        gradient.endPoint = endPoint!
        gradient.cornerRadius = self.bounds.height / 2
        self.layer.insertSublayer(gradient, at: 0)
        

    }

    func addTopShadow(){
        self.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = CGPath(ellipseIn: CGRect(x: -10,
                                                             y: -10 * 0.5,
                                                             width: self.layer.bounds.width + 10 * 2,
                                                             height: 10),
                                           transform: nil)
    }
    
    func addShape(viewCard: UIView) {
        let frame = viewCard.frame
        
        let bezierPath = UIBezierPath()
        
          bezierPath.move(to: CGPoint(x: 10, y: 0))
        
        
        bezierPath.addArc(withCenter: CGPoint(x: 20, y: 20) , radius: 20, startAngle: CGFloat(3*(Double.pi/2)), endAngle: CGFloat(Double.pi), clockwise: false)


                bezierPath.addLine(to: CGPoint(x: 0, y: frame.height - 10))
                bezierPath.addArc(withCenter: CGPoint(x: 20, y: frame.height - 20) , radius: 20, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi/2), clockwise: false)
        bezierPath.addLine(to: CGPoint(x: 10, y: frame.height))

                bezierPath.addLine(to: CGPoint(x: frame.width - 40, y: frame.height))
                bezierPath.addArc(withCenter: CGPoint(x: frame.width, y: frame.height) , radius: 20, startAngle: CGFloat(Double.pi), endAngle: CGFloat(3*(Double.pi/2)), clockwise: true)
                bezierPath.addLine(to: CGPoint(x: frame.width, y: 10))
                bezierPath.addArc(withCenter: CGPoint(x: frame.width - 20, y: 20) , radius: 20, startAngle: CGFloat(0), endAngle: CGFloat(3*(Double.pi/2)), clockwise: false)
                bezierPath.addLine(to: CGPoint(x: frame.width - 10, y: 0))
                bezierPath.addLine(to: CGPoint(x: 10, y: 0))

                bezierPath.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
//        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2.0
        
        
        
        viewCard.layer.addSublayer(shapeLayer)

    }
    
}

