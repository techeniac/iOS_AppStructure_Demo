//
//  Utilities.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit
import MapKit
import LocalAuthentication
import MessageUI

struct PickerMediaType {
    
    static let image = kUTTypeImage as String
    static let video = kUTTypeMovie as String
}

class Utilities: NSObject {
    
    //Get BioMetricType
    static func biometricType() -> LABiometryType {
        let authContext = LAContext()
        if #available(iOS 11, *) {
            let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch(authContext.biometryType) {
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            default:
                return .touchID
            }
        } else {
            return .touchID
        }
    }
    
    
    //Convert To html
    class func convertToHtml(str : String) -> NSAttributedString{
        
        var attributedString: NSMutableAttributedString? = nil
        if let anEncoding = str.data(using: .unicode) {
            
            attributedString = try? NSMutableAttributedString(data: anEncoding, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            
        }
        
        return attributedString ?? NSAttributedString()
    }
    
    static func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
    }
    
    //MARK: JSON
    static func jsonToString(json: Any) -> String?{
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            return convertedString
        } catch let myJSONError {
            print(myJSONError)
        }
        
        return nil
    }
    
    static func objectFromJsonString(str:String) -> Any?{
        
        let jsonString = str
        let jsonData = jsonString.data(using: .utf8)
        let dict = try? JSONSerialization.jsonObject(with: jsonData!, options: .mutableLeaves)
        return dict
    }
    
    class func convertToDollar(number : Double,isSymbol : Bool? = true,digits : Int = 2) -> String {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        currencyFormatter.currencyCode = "USD"
        if isSymbol == false{
            currencyFormatter.currencySymbol = ""
        }
        
        currencyFormatter.maximumFractionDigits = digits
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        return currencyFormatter.string(from: NSNumber(value: number))!
    }
    
    //MARK: get doouble value
    class func toDoubleString(value : Double, numberOfDigits : Int = 2) -> String{
        
        //let disValue = dis.toDouble()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.maximumFractionDigits = numberOfDigits
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.locale = Locale(identifier: "en_US")
        let disValue =  numberFormatter.string(from: NSNumber(value:value)) ?? ""
        
        if disValue != "0.0" && disValue != "0.00" && disValue != "0" {
            
            return "\(disValue)"
        }
        
        return "0.0"
    }
    
    class func toDoubleStringWithDash(value : Double, numberOfDigits : Int = 2) -> String{
           
       //let disValue = dis.toDouble()
       let numberFormatter = NumberFormatter()
       numberFormatter.numberStyle = .decimal
       numberFormatter.usesGroupingSeparator = true
       numberFormatter.maximumFractionDigits = numberOfDigits
       numberFormatter.minimumFractionDigits = 0
       numberFormatter.locale = Locale(identifier: "en_US")
       let disValue =  numberFormatter.string(from: NSNumber(value:value)) ?? ""
       
       if disValue != "0.0" && disValue != "0.00" && disValue != "0" {
           
           return "\(disValue)"
       }
       
       return "-"
   }
    
    class func toDoubleStringWithAnyValue(value : Any?, numberOfDigits : Int = 2) -> String{
        
        let dblValue = self.getDoubleValue(value: value ?? 0)
        
        //let disValue = dis.toDouble()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.maximumFractionDigits = numberOfDigits
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.locale = Locale(identifier: "en_US")
        let disValue =  numberFormatter.string(from: NSNumber(value:dblValue)) ?? ""
        
        if disValue != "0.0" && disValue != "0.00"{
            
            return "\(disValue)"
        }
        
        return "0.0"
    }
    
    class func toDoubleStringWithoutComma(value : Any?, numberOfDigits : Int = 2) -> String{
        
        let dblValue = self.getDoubleValue(value: value ?? 0)
                
        let disValue =  String(format : "%0.\(numberOfDigits)f", dblValue)
        if disValue != "0.0" && disValue != "0.00"{
            
            return "\(disValue)"
        }
        
        return "0.0"
    }
    
    
    //MARK: Read Json file
    class func getDataFromJsonFile(_ fileName : String) -> Any? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult1 = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                if let arr = jsonResult1 as? [[String : Any]] {
                    
                    return arr
                }
                
                if let dict = jsonResult1 as? [String : Any] {
                    
                    return dict
                }
                
            } catch {
                return nil
            }
        }
        return nil
    }
    
    //MARK: NavigationBar
    
    static func setNavigationBar(controller : UIViewController,isHidden : Bool, isHideBackButton : Bool = false, title : String? = nil,isStausColor:Bool? = true) {
        
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: FontScheme.kRegularFont(size: 18)
        ]
        
        if isStausColor == true{
            
            if #available(iOS 13.0, *) {

                if let frame = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame {
                    let statusBar1 =  UIView()
                    statusBar1.frame = frame
                    statusBar1.backgroundColor = UIColor.clear
                    UIApplication.shared.keyWindow?.addSubview(statusBar1)
                }

            } else {

               let statusBar: UIView = UIApplication.shared.statusBarView!
               if statusBar.responds(to: #selector(setter: UIView.backgroundColor)){
                   statusBar.backgroundColor = UIColor.clear
               }
            }
        }
        else{
            
            if #available(iOS 13.0, *) {

                if let frame = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame {
                    let statusBar1 =  UIView()
                    statusBar1.frame = frame
                    statusBar1.backgroundColor = ColorConstants.BgColor
                    UIApplication.shared.keyWindow?.addSubview(statusBar1)
                }

            } else {

               let statusBar: UIView = UIApplication.shared.statusBarView!
               if statusBar.responds(to: #selector(setter: UIView.backgroundColor)){
                   statusBar.backgroundColor = ColorConstants.BgColor
               }
            }
        }
        
        controller.navigationController?.navigationBar.titleTextAttributes = attrs
        controller.navigationController?.isNavigationBarHidden = isHidden
        controller.navigationController?.navigationBar.isHidden = isHidden

        
        controller.navigationController?.navigationBar.barTintColor = ColorConstants.NavigationBarColor
        controller.navigationController?.navigationBar.tintColor = .white
        controller.navigationController?.navigationBar.isTranslucent = false
        
        //controller.title = title
        
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 22))

        let label = UILabel()
        label.text = title
        label.textColor = UIColor.white
        label.font = FontScheme.kRegularFont(size: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(label)
        
        let leftButtonWidth: CGFloat = 65 // left padding
        let rightButtonWidth: CGFloat = CGFloat((controller.navigationItem.rightBarButtonItems?.count ?? 0) * 32) // right padding
        let width = controller.view.frame.width - leftButtonWidth - rightButtonWidth
        let offset = (rightButtonWidth - leftButtonWidth) / 2
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: -offset),
            label.widthAnchor.constraint(equalToConstant: width)
            ])
        
        controller.navigationItem.titleView = container
        
    }
    
    class func configureExpandableLabel(label: ExpandableLabel) {
        label.expandedAttributedLink = StringConstants.ExpandableLabelConstant.attributedLessText
        label.collapsedAttributedLink = StringConstants.ExpandableLabelConstant.attributedMoreText
        label.font = FontScheme.kRegularFont(size: 14)
        label.shouldCollapse = true
        label.textReplacementType = .word
        label.numberOfLines = 3
    }
    
    class func showValueWithPer(dis : Double) -> String{
        
        let disValue = String(format: "%0.2f",dis)
        if disValue != "0.0" && disValue != "0.00"{
            
            return "\(disValue) %"
        }
        return "-"
    }
    
    //MARK: Text Height
    class func getLabelHeight(constraintedWidth width: CGFloat, font: UIFont,text:String) -> CGFloat {
        
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = text
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
    
    class func getLabelWidth(constraintedheight: CGFloat, font: UIFont,text:String) -> CGFloat {
        
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: .greatestFiniteMagnitude, height: constraintedheight))
        label.numberOfLines = 1
        label.text = text
        label.font = font
        label.sizeToFit()
        
        return label.frame.width
    }
    
    class func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    //MARK: Get UIColor from hex color
    
    static func colorWithHexString (hex:String) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //MARK: Strings
    static func checkStringEmptyOrNil(str : String?) -> Bool{
        let trimmedStr = str?.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
        if trimmedStr?.isEmpty == nil || trimmedStr?.count == 0{
            return true
        }
        return false
    }
    
    //MARK: Show Alert View
    
    class func showAlertView(title: String? = AppConstants.AppName, message: String?) {
        
        UIViewController.current()?.view.showConfirmationPopupWithSingleButton(title: "", message: message ?? "", confirmButtonTitle: StringConstants.ButtonTitles.KOk, onConfirmClick: {
            
        })
    }
    
    class func showAlertWithButtonAction(title: String,message:String,buttonTitle:String,onOKClick: @escaping () -> ()){
        
        DispatchQueue.main.async {
            
            UIViewController.current()?.view.showConfirmationPopupWithSingleButton(title: "", message: message, confirmButtonTitle: buttonTitle, onConfirmClick: {
                
                onOKClick()
            })
        }
    }
    
    //Show Pop Over
    class func showPopOverView(str : String, sender : Any?){
        let label = UILabel()
        label.text = str
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.font = FontScheme.kRegularFont(size: 12)
        
        let popOver : NGSPopoverView = NGSPopoverView.init(cornerRadius: 10.0, direction: NGSPopoverArrowDirection.automatic, arrowSize: CGSize(width: 20, height: 10))
        popOver.contentView = label
        popOver.tintColor = UIColor.black
        popOver.show(from: sender as? UIView, animated: true)
    }
    
    
    //MARK: Call
    class func call(phoneNumber: String)
    {
        let trimPhone = phoneNumber.replacingOccurrences(of: " ", with: "")
        if  let url = URL(string: "tel://\(trimPhone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    //MARK: WhatsUp
    class func openWhatsUp(number : String, message : String) {
        
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(number)&text=\(message)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        }
        else {
            // Whatsapp is not installed
        }
    }
    
    //MARK: Open mail
    class func openEmail(email: String, detail: String)
    {

        let subject = "Diamond Detail"
        let bodyText = "Dear Sir / Madam \n Greetings of the day from SG Team. \n Please have a look at below diamond Detail . \n\n" + detail

        let coded = "mailto:\(email)?subject=\(subject)&body=\(bodyText)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let emailURL = URL(string: coded!)
        {
            if UIApplication.shared.canOpenURL(emailURL)
            {
                UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
            }
        }else{
            Utilities.showAlertView(message: LanguageManager.localizedString("KMsgMailError"))
        }

    }
    
    //MARK: - Open Skype
    class func openSkypeApp() {
        
        if let skypeURL = URL(string: "skype:"), UIApplication.shared.canOpenURL(skypeURL) {
            UIApplication.shared.open(skypeURL, options: [:], completionHandler: nil)
        } else {
            Utilities.showAlertView(message: LanguageManager.localizedString("KMsgSkypeError"))
        }
    }
    
    //WeChat
    class func openWeChatAppWithId(id : String) {
        
        if UIApplication.shared.canOpenURL(URL(string: "weixin:")!) {
            UIApplication.shared.open(URL(string: "weixin://\(id)")!, options: [:], completionHandler: nil)
        }
        else{
           Utilities.showAlertView(message: LanguageManager.localizedString("KMsgWeChatError"))
        }
    }
    
    //Skype
    class func openSkypeAppWithId(id : String) {
        
        if UIApplication.shared.canOpenURL(URL(string: "skype:")!) {
            UIApplication.shared.open(URL(string: "skype:\(id)")!, options: [:], completionHandler: nil)
        }
        else{
           Utilities.showAlertView(message: LanguageManager.localizedString("KMsgSkypeError"))
        }
    }
    
    //TODO
    class func openQQAppWithId(id : String) {
        
//        if UIApplication.shared.canOpenURL(URL(string: "mqq:")!) {
            UIApplication.shared.open(URL(string: "mqq://im/chat?chat_type=wpa&uin=\(id)&version=1&src_type=web")!, options: [:], completionHandler: nil)
//        }
//        else{
//           Utilities.showAlertView(message: LanguageManager.localizedString("KMsgQQError"))
//        }
    }
    
    //MARK: Open mail
    class func openSMS(phone: String)
    {
        if let url = URL(string: "sms:\(phone)"), UIApplication.shared.canOpenURL(url)  {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            Utilities.showAlertView(message: LanguageManager.localizedString("KMsgMessageError"))
        }
    }
    
    //MARK: Device Unique ID
    class func getDeviceUniqueID() -> String{
        
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    //MARK: Open Date Picker
    class func openDatePicker(datePicker:GMDatePicker, delegate:GMDatePickerDelegate,selectedDate : Date)
    {
        UIViewController.current().view.endEditing(true)
        datePicker.delegate = delegate
        datePicker.config.startDate = selectedDate
        datePicker.config.animationDuration = 0.5
        datePicker.config.cancelButtonTitle = LanguageManager.localizedString("KLblCancel")
        datePicker.config.confirmButtonTitle = LanguageManager.localizedString("KLblDone")
        datePicker.config.contentBackgroundColor = UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1)
        datePicker.config.headerBackgroundColor = ColorConstants.ThemeColor
        datePicker.config.confirmButtonColor = .white
        datePicker.config.cancelButtonColor = .white
        datePicker.config.confirmButtonFont = FontScheme.kBoldFont(size: 18)
        datePicker.config.cancelButtonFont = FontScheme.kBoldFont(size: 18)
        datePicker.show(inVC: UIViewController.current())
        
    }
    
    //MARK: Open Date Picker
    class func openDateTimerPicker(datePicker:GMDatePicker, delegate:GMDatePickerDelegate,selectedDate : Date)
    {
        UIViewController.current().view.endEditing(true)
        datePicker.delegate = delegate
        datePicker.config.startDate = selectedDate
        datePicker.config.datePickerMode = .dateAndTime
        datePicker.config.animationDuration = 0.5
        datePicker.config.cancelButtonTitle = "Cancel"
        datePicker.config.confirmButtonTitle = "Done"
        datePicker.config.contentBackgroundColor = UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1)
        datePicker.config.headerBackgroundColor = ColorConstants.ThemeColor
        datePicker.config.confirmButtonColor = .white
        datePicker.config.cancelButtonColor = .white
        datePicker.config.confirmButtonFont = FontScheme.kBoldFont(size: 18)
        datePicker.config.cancelButtonFont = FontScheme.kBoldFont(size: 18)
        datePicker.show(inVC: UIViewController.current())
        
    }
    
    //MARK: Imagepicker controller
    class func open_galley_or_camera(delegate : UIImagePickerControllerDelegate,mediaType:[String], sender:UIView = UIViewController.current().view){
        
        let actionSheetController: UIAlertController = UIAlertController(title: LanguageManager.localizedString("KLblChooseOption"), message: nil, preferredStyle:  AppConstants.DeviceType.IS_IPAD ? .alert : .actionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: LanguageManager.localizedString("KLblCancel"), style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: LanguageManager.localizedString("KCamera"), style: .default) { action -> Void in
            
            if(  UIImagePickerController.isSourceTypeAvailable(.camera))
            {
                let myPickerController = UIImagePickerController()
                myPickerController.navigationBar.isTranslucent = false
                myPickerController.navigationBar.barTintColor = ColorConstants.ThemeColor // Background color
                myPickerController.navigationBar.tintColor = UIColor.white // Cancel button ~ any UITabBarButton items
                myPickerController.navigationBar.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor : UIColor.white
                ]
                
                let BarButtonItemAppearance = UIBarButtonItem.appearance()
                
                BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
                BarButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for:UIBarMetrics.default)
                myPickerController.delegate = (delegate as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)
                myPickerController.sourceType = .camera
                myPickerController.mediaTypes = mediaType
                UIViewController.current().present(myPickerController, animated: true, completion: nil)
            }
            else
            {
                let actionController: UIAlertController = UIAlertController(title: LanguageManager.localizedString("KInvalidCamera"), message: "", preferredStyle: .alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: LanguageManager.localizedString("KLblOk"), style: .cancel) { action -> Void     in
                    //Just dismiss the action sheet
                }
                
                actionController.addAction(cancelAction)
                actionController.popoverPresentationController?.sourceView = sender
                UIViewController.current().present(actionController, animated: true, completion: nil)
                
            }
        }
        actionSheetController.addAction(takePictureAction)
        
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: LanguageManager.localizedString("KChooseGallery"), style: .default) { action -> Void in
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = (delegate as! UIImagePickerControllerDelegate & UINavigationControllerDelegate);
            myPickerController.sourceType = .photoLibrary
            myPickerController.mediaTypes = mediaType
            
            myPickerController.navigationBar.barTintColor = ColorConstants.ThemeColor // Background color
            myPickerController.navigationBar.tintColor = UIColor.white // Cancel button ~ any UITabBarButton items
            myPickerController.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            
            let BarButtonItemAppearance = UIBarButtonItem.appearance()
            
            BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
            BarButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for:UIBarMetrics.default)
            
            UIViewController.current().present(myPickerController, animated: true, completion: nil)
        }
        actionSheetController.addAction(choosePictureAction)
        actionSheetController.popoverPresentationController?.sourceView = sender
        
        //Present the AlertController
        UIViewController.current().present(actionSheetController, animated: true, completion: nil)
        
    }
    
    
    //MARK: VideoPicker controller
    class func openVideoPicker(delegate : UIImagePickerControllerDelegate){
        
        let actionSheetController: UIAlertController = UIAlertController(title: LanguageManager.localizedString("KLblChooseOption"), message: nil, preferredStyle: .actionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: LanguageManager.localizedString("KLblCancel"), style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: LanguageManager.localizedString("KCamera"), style: .default) { action -> Void in
            if(  UIImagePickerController.isSourceTypeAvailable(.camera))
                
            {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = (delegate as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)
                myPickerController.sourceType = .camera
                myPickerController.mediaTypes = [kUTTypeMovie as String]
                myPickerController.navigationBar.barTintColor = ColorConstants.ThemeColor // Background color
                myPickerController.navigationBar.tintColor = UIColor.white // Cancel button ~ any UITabBarButton items
                myPickerController.navigationBar.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor : UIColor.white
                ]
                
                let BarButtonItemAppearance = UIBarButtonItem.appearance()
                
                BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
                BarButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for:UIBarMetrics.default)
                UIViewController.current().present(myPickerController, animated: true, completion: nil)
            }
            else
            {
                let actionController: UIAlertController = UIAlertController(title: LanguageManager.localizedString("KInvalidCamera"), message: "", preferredStyle: .alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: LanguageManager.localizedString("KLblOk"), style: .cancel) { action -> Void     in
                    //Just dismiss the action sheet
                }
                
                actionController.addAction(cancelAction)
                actionController.popoverPresentationController?.sourceView = UIViewController.current().view
                UIViewController.current().present(actionController, animated: true, completion: nil)
                
            }
        }
        actionSheetController.addAction(takePictureAction)
        
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: LanguageManager.localizedString("KChooseGallery"), style: .default) { action -> Void in
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = (delegate as! UIImagePickerControllerDelegate & UINavigationControllerDelegate);
            myPickerController.sourceType = .photoLibrary
            myPickerController.mediaTypes = [kUTTypeMovie as String]
            myPickerController.navigationBar.barTintColor = ColorConstants.ThemeColor // Background color
            myPickerController.navigationBar.tintColor = UIColor.white // Cancel button ~ any UITabBarButton items
            myPickerController.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            
            let BarButtonItemAppearance = UIBarButtonItem.appearance()
            
            BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
            BarButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for:UIBarMetrics.default)
            UIViewController.current().present(myPickerController, animated: true, completion: nil)
        }
        actionSheetController.addAction(choosePictureAction)
        
        //Present the AlertController
        actionSheetController.popoverPresentationController?.sourceView = UIViewController.current().view
        UIViewController.current().present(actionSheetController, animated: true, completion: nil)
        
    }
    
    //MARK: Change Color
    class func changeStringColor(string : String, array : [String], colorArray : [UIColor],arrFont:[UIFont]) ->  NSAttributedString {
        
        let attrStr = NSMutableAttributedString(string: string)
        let inputLength = attrStr.string.count
        let searchString = array
        
        for i in 0...searchString.count-1
        {
            
            let string  = searchString[i]
            let searchLength = string.count
            var range = NSRange(location: 0, length: attrStr.length)
            
            while (range.location != NSNotFound) {
                range = (attrStr.string as NSString).range(of: string, options: [], range: range)
                if (range.location != NSNotFound) {
                    
                    if colorArray.count >= i{
                        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: colorArray[i], range: NSRange(location: range.location, length: searchLength))
                    }
                    
                    if arrFont.count >= i{
                        attrStr.addAttribute(NSAttributedString.Key.font, value: arrFont[i], range: NSRange(location: range.location, length: searchLength))
                    }
                    
                    range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
                    //                    return attrStr
                }
            }
        }
        
        return attrStr
    }
    
    class func changeStringUnderLine(attrStr : NSMutableAttributedString, array : [String]) -> NSAttributedString{
        
        let inputLength = attrStr.string.count
        let searchString = array
        for i in 0...searchString.count-1
        {
            
            let string  = searchString[i]
            let searchLength = string.count
            var range = NSRange(location: 0, length: attrStr.length)
            
            while (range.location != NSNotFound) {
                range = (attrStr.string as NSString).range(of: string, options: [], range: range)
                if (range.location != NSNotFound) {
                    attrStr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: range.location, length: searchLength))
                    range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
                    return attrStr
                }
            }
        }
        return NSAttributedString()
    }
    
    //Open apple map
    class func openMap(latitude:Double, longitude:Double) {
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")!, options: [:], completionHandler: nil)
        }
        else {
            let str = "https://maps.google.com/?q=\(latitude),\(longitude)&directionsmode=driving"
            Utilities.openURL(str)
        }
        
    }
    
    //MARK: get double value
    class func getDoubleValue<T>(value : T) -> Double{
        if let val = value as? NSNumber{
            return val.doubleValue
        }
        
        if let val = value as? Float{
            return Double(val)
        }
        
        if let val = value as? Double{
            return val
        }
        
        if let val = value as? Int{
            return Double(val)
        }
        
        if let val = value as? String{
            return Double(val) ?? 0
        }
        
        return 0
    }
    
    //MARK: get double value
    class func getIntValue<T>(value : T) -> Int{
        if let val = value as? NSNumber{
            return val.intValue
        }
        
        if let val = value as? Float{
            return Int(val)
        }
        
        if let val = value as? Int{
            return Int(val)
        }
        
        if let val = value as? Int{
            return val
        }
        
        if let val = value as? String{
            return Int(val) ?? 0
        }
        
        return 0
    }
    
    
    //Get totalHeight of view without safeView
    class func getOriginalViewHeight() -> CGFloat{
        if AppConstants.hasSafeArea{
            
            let safeAreaheight = Utilities.getTopSafeArea() - 20
            
            return ((AppConstants.ScreenSize.SCREEN_HEIGHT - 20) - (UIViewController.current()?.navigationController?.navigationBar.frame.size.height)! - safeAreaheight)
        }else{
            
            return ((AppConstants.ScreenSize.SCREEN_HEIGHT - 20) - (UIViewController.current()?.navigationController?.navigationBar.frame.size.height)!)
        }
    }
    
    
    
    //MARK:- Calling number
    class func openURL(_ strUrl : String) {
        if let url = URL(string: strUrl), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    //MARK:- Notch Bottom Area
    class func getBottomSafeArea() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.top ?? 0.0
        }
        return 0.0
    }
    
    class func getTopSafeArea() -> CGFloat {
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.top ?? 0.0
        }
        return 0.0
    }   
    
    class func toDouble(value : Double) -> String{
        
        //let disValue = dis.toDouble()
        let disValue = String(format: "%0.2f",value)
        if disValue != "0.0" && disValue != "0.00"{
            
            return "\(disValue)"
        }
        
        return "-"
    }
    
    class func sideMenuGesture(isEnable: Bool = true) {
        if let sideMenu = UIViewController.current()?.sideMenuViewController {
            sideMenu.panGestureEnabled = isEnable
        }
    }
    
    //MARK: Convert String To Dictionary
    class func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}

//Constraint multiplier
extension NSLayoutConstraint {
    
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem!,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = shouldBeArchived
        newConstraint.identifier = identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}


struct Screen {
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var statusBarHeight: CGFloat {
            return UIApplication.shared.statusBarFrame.height
    }
    
}
