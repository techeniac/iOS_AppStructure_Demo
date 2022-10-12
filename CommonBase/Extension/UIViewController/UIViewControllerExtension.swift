//
//  UIViewControllerExtension.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//
import UIKit
import Foundation

extension UIViewController {

    //MARK: Rotate screen
    func rotateScreen(_ orientation : UIInterfaceOrientation) {
        
        if  orientation == .landscapeLeft{
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.shouldRotate = true
                appDelegate.myOrientation = .landscapeRight
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            }
        }else if  orientation == .landscapeRight{
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.shouldRotate = true
                appDelegate.myOrientation = .landscapeLeft
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            }
        }else{
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.shouldRotate = false
                appDelegate.myOrientation = .portrait
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            }
        }
        
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}
//MARK: https://magz.techover.io/2021/07/25/method-swizzling-in-swift/
// swizzling Method Call before Navigation
extension UIViewController {
    @objc func viewDidLoadSwizzlingMethod() {
        // 2
        self.viewDidLoadSwizzlingMethod()
        
        // 3
        print(String(describing: self))
        print(Screen.statusBarHeight)
        print(Screen.height)
        let StatusBar = UIView(frame: CGRect(x: 0, y: 0, width: Screen.width, height:Screen.statusBarHeight))
        StatusBar.backgroundColor = .white
        view.addSubview(StatusBar)
        debugPrint("Swizzleeee. Call NEW view did load ")
       
    
    
    }
    static func startSwizzlingViewDidLoad() {
            // 1
            let defaultSelector = #selector(viewDidLoad)
            let newSelector = #selector(viewDidLoadSwizzlingMethod)

            // 2
            let defaultInstace = class_getInstanceMethod(UIViewController.self, defaultSelector)
            let newInstance = class_getInstanceMethod(UIViewController.self, newSelector)
            
            // 3
            if let instance1 = defaultInstace, let instance2 = newInstance {
                debugPrint("Swizzlle for all view controller success")
                method_exchangeImplementations(instance1, instance2)
            }
        }
}
//MARK: Show BottomSheet Popup
extension UIViewController{
    
    func showBottomSheetPopup(_ arrList : [Int], _ selected : Bool = false, isFromDetail: Bool = false, isLandscape: Bool = false, module : String = "",  completion : ((_ value : Int) -> ())?){
//
//        let vc = BottomPopup(nibName: "BottomPopup", bundle: nil)
//        vc.arrList = arrList
//        vc.isLandscape = isLandscape
//        vc.isFromDetail = isFromDetail
//        vc.isButtonSelected = selected
//        vc.module = module
//        vc.didSelecet = { value in
//            completion?(value)
//        }
//        vc.modalPresentationStyle = .custom
//        vc.modalTransitionStyle = .crossDissolve
//        UIViewController.current()?.present(vc, animated: false, completion: {
//        })
    }
    
    func showStatusPopup(_ selectedValue : ((_ cellModel : CellModel) -> ())?){
        
//        let vc =  StatusPopupVC(nibName: "StatusPopupVC", bundle: nil)
//        vc.didSelect = { model in
//            selectedValue?(model)
//        }
//
//        vc.modalPresentationStyle = .custom
//        vc.modalTransitionStyle = .crossDissolve
//        UIViewController.current()?.present(vc, animated: true, completion: {
//        })
    }
    
//    func showAddCommentPopup(_ title : String? = nil, cancelButtonTitle : String? = nil, confirmButtonTitle : String? = nil, placeholderTitle : String? = nil, msg : String? = nil , colorCode : String? = nil , moduleType : ModuleType = .DiamondList, isoffer : Bool? = false, isSelectDays : Bool? = false,  confirmBtnClick : ((_ remark : String, _ colorCode: String) -> ())?){
        
        
//        let vc =  AddCommentPopupVC(nibName: "AddCommentPopupVC", bundle: nil)
//        vc.isConfirmClick = { (model, colorCode) in
//            confirmBtnClick?(model, colorCode)
//        }
//        vc.isSelectDays = isSelectDays ?? false
//        vc.moduleType = moduleType
//        vc.strMsg = msg
//        if msg?.count ?? 0 > 0{
//            vc.strTitle = "KLblUpdateComments".localized
//        }else{
//            vc.strTitle = title
//        }
//        vc.colorCode = colorCode
//        vc.btnCancelTitle = cancelButtonTitle
//        vc.btnConfirmTitle = confirmButtonTitle
//        vc.placeholderTitle = placeholderTitle
//
//        vc.modalPresentationStyle = .custom
//        vc.modalTransitionStyle = .crossDissolve
//        UIViewController.current()?.present(vc, animated: true, completion: {
//        })
//    }
    
//    func showAddCommentPopupForMakeOffer(_ title : String? = nil, cancelButtonTitle : String? = nil, confirmButtonTitle : String? = nil, placeholderTitle : String? = nil, msg : String? = nil , colorCode : String? = nil , moduleType : ModuleType = .DiamondList, trackType: Int = 0, isSelectDays : Bool? = false, carat: Double? = 0.0, confirmBtnClick : ((_ remark : String, _ newAmount: Double, _ newPricePerCarat: Double, _ selectedDate: String) -> ())?){
        
        
//        let vc =  AddCommentPopupVC(nibName: "AddCommentPopupVC", bundle: nil)
//        vc.isConfirmOfferClick = { (remark, newAmount, newPricePerCarat, dateSelected) in
//            confirmBtnClick?(remark, newAmount, newPricePerCarat, dateSelected)
//        }
//        vc.carat = carat
//        vc.trackType = trackType
//        vc.isSelectDays = isSelectDays ?? false
//        vc.moduleType = moduleType
//        vc.strMsg = msg
//        vc.colorCode = colorCode
//        vc.strTitle = title
//        vc.btnCancelTitle = cancelButtonTitle
//        vc.btnConfirmTitle = confirmButtonTitle
//        vc.placeholderTitle = placeholderTitle
//
//        vc.modalPresentationStyle = .custom
//        vc.modalTransitionStyle = .crossDissolve
//        UIViewController.current()?.present(vc, animated: true, completion: {
//        })
//    }
    
    
    //Show ExcelDownlaod PopUp
   
    
    
    func showDownloadingProgressPopup(_ filterCriteria : [String:Any]? = nil, sortKey : String){
        
//        let vc =  DownloadingProgressPopup(nibName: "DownloadingProgressPopup", bundle: nil)
//        vc.filterCriteria = filterCriteria
//        vc.sortKey = sortKey
//
//        vc.modalPresentationStyle = .custom
//        vc.modalTransitionStyle = .crossDissolve
//        UIViewController.current()?.present(vc, animated: true, completion: {
//        })
    }
    
    
}

import MessageUI

extension UIViewController: MFMailComposeViewControllerDelegate {
    
    func openMail(toMail: String, subject: String, body: String){
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([toMail])
        mailComposerVC.setSubject(subject)
        mailComposerVC.setMessageBody(body, isHTML: true)
        self.present(mailComposerVC, animated: true, completion: nil)
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
     
}
