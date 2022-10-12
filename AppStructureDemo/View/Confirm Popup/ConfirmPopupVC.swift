//
//  ConfirmPopupVC.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class ConfirmPopupVC: UIViewController {

    //MARK: Variables
    var headerTitle:String?
    var message:String?
    var Stonids:String?
    var cancelButtonTitle:String?
    var confirmButtonTitle:String?
    var confirmClicked:(() -> ())?
    var cancelBtnClicked: (() -> ())?
    var isShowSingleButton = false
    var isAttributted : Bool = false
    var isStoneId : Bool = false

    //MARK: Outlets
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblStoneId: UILabel!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnConfirm: UIButton!
    @IBOutlet weak var topTitle: NSLayoutConstraint!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewCancel: UIView!
    @IBOutlet weak var constraintBottomViewMain: NSLayoutConstraint!
    @IBOutlet weak var viewConfirm: UIView!
    @IBOutlet weak var viewLineSeprator: UIView!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialConfig()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Utilities.setNavigationBar(controller: self, isHidden: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    //MARK: Private Methods
    func initialConfig(){
        
        if AppConstants.hasSafeArea{
            constraintBottomViewMain.constant = 20
        }
        
        viewConfirm.layer.cornerRadius = viewConfirm.frame.height / 2
        viewConfirm.backgroundColor = ColorConstants.ThemeColor.withAlphaComponent(0.1)
        lblTitle.text = headerTitle ?? ""
//        lblTitle.text = "DELETE STONE"
        btnCancel.titleLabel?.numberOfLines = 0
        btnCancel.titleLabel?.adjustsFontSizeToFitWidth = true
        btnCancel.titleLabel?.minimumScaleFactor = 0.5
//        btnCancel.setTitleColor(ColorConstants.bakc, for: .normal)
//        btnConfirm.setTitleColor(ColorConstants.Dark.White, for: .normal)
//        lblTitle.textColor = ColorConstants.Dark.popTitle
//        lblDescription.textColor = ColorConstants.Dark.PlaceholderColor
        lblStoneId.isHidden = true

        if isAttributted {
            lblDescription.attributedText = Utilities.convertToHtml(str: message ?? "")
        }
        else{
           lblDescription.text = message ?? ""
        }
    
        
        if cancelButtonTitle?.count ?? 0 > 0{
            btnCancel.setTitle(cancelButtonTitle, for: .normal)
        }else{
            btnCancel.setTitle(StringConstants.ButtonTitles.KCancel, for: .normal)
        }
        
        if confirmButtonTitle?.count ?? 0 > 0{
            
            if confirmButtonTitle == StringConstants.ButtonTitles.kYes{
                //btnConfirm.setTitleColor(ColorConstants.RedText, for: .normal)
            }
            btnConfirm.setTitle(confirmButtonTitle, for: .normal)
            btnConfirm.titleLabel?.numberOfLines = 0
            btnConfirm.titleLabel?.textAlignment = .center
        }else{
            btnConfirm.setTitle(StringConstants.ButtonTitles.KConfirm, for: .normal)
        }
        
        if let title = headerTitle,title.count > 0 {
            topTitle.constant = 35
            viewLineSeprator.isHidden = false
        }else{
            topTitle.constant = 0
            viewLineSeprator.isHidden = true
        }
        
        if isShowSingleButton == true {
            viewCancel.isHidden = true
        }
        if isStoneId == true{
            lblStoneId.isHidden = false
            lblStoneId.text = Stonids
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if UIApplication.shared.statusBarOrientation.isLandscape{
            let width = view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right
            viewMain.roundCorners([.topLeft, .topRight], radius: 25, width: width)
            
        }else{
            viewMain.roundCorners([.topLeft, .topRight], radius: 25, width: AppConstants.ScreenSize.SCREEN_WIDTH)
            
        }
    }
    
    //MARK: IBActions
    
    @IBAction func btnCancel_Clicked(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.cancelBtnClicked?()
        }
    }
    
    @IBAction func btnConfirm_Clicked(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            self.confirmClicked?()
        }        
    }
    
    @IBAction func btnDismissPopup_Click(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
    