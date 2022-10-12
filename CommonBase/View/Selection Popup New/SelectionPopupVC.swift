//
//  LanguageManager.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class SelectionPopupVC: UIViewController {

    // MARK: - Variables
    var strHeading : String?
    var arrData = [SelectionPopupModel]()
    var didSelect : ((SelectionPopupModel) -> Void)?
    var didMultiSelect : (([SelectionPopupModel]) -> Void)?
    var isActionPopUp : Bool = false
    var strSubmitText : String = ""
    var validationMessage : String?
    var isClearOption = false
    
    // MARK: - Outlet
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet var lblHeading: UILabel!
    @IBOutlet weak var constraintHeightViewTable: NSLayoutConstraint!
    @IBOutlet weak var constraintBottomViewMain: NSLayoutConstraint!
    @IBOutlet weak var viewSubmit: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    // MARK:- Controller's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        intialConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Utilities.setNavigationBar(controller: self, isHidden: true)
    }
    
    // MARK:- Private Methods
    func intialConfig() {
        
        if AppConstants.hasSafeArea{
            constraintBottomViewMain.constant = 20
        }
        
        setPopUpSize()
        viewMain.setCornerRadius(radius: 10.0)
        tableView.register(UINib(nibName: "SelectionPopupCell", bundle: nil), forCellReuseIdentifier: "SelectionPopupCell")
        
        lblHeading.text = strHeading
        
        tableView.reloadData()
        
        let arr = arrData.filter { $0.isSelected == true }
        if arr.count > 0 {
            let index = arrData.firstIndex(of: arr.first ?? SelectionPopupModel())
            tableView.scrollToRow(at: IndexPath(row: index ?? 0, section: 0), at: .middle, animated: true)
        }
        
        constraintHeightViewTable.constant = CGFloat(arrData.count * 50)
        
        if strSubmitText.count > 0 {
            viewSubmit.isHidden = false
            btnSubmit.setTitle(strSubmitText, for: .normal)
        }
        else if isClearOption {
            viewSubmit.isHidden = false
            btnSubmit.setTitle(StringConstants.ButtonTitles.kClear, for: .normal)
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        setPopUpSize()
    }
    
    func setPopUpSize() {
        
        if isActionPopUp {
            
            let height = 75 + (arrData.count * 80)
            self.preferredContentSize = CGSize(width: 330, height: height)
        }
        else{
           
            let currentOrientation = UIDevice.current.orientation
            
            if currentOrientation == .landscapeLeft || currentOrientation == .landscapeRight{
                
                self.preferredContentSize = CGSize(width: AppConstants.ScreenSize.SCREEN_WIDTH - 470, height: AppConstants.ScreenSize.SCREEN_HEIGHT - 110)
            }
            else if currentOrientation == .portrait || currentOrientation == .portraitUpsideDown || currentOrientation == .faceUp || currentOrientation == .faceDown{
                
                self.preferredContentSize = CGSize(width: AppConstants.ScreenSize.SCREEN_WIDTH - 110, height: AppConstants.ScreenSize.SCREEN_HEIGHT - 500)
            }
        }
    }
    
    //MARK:-  IBAction
    
    @IBAction func btnback_Click(_ sender: UIButton) {
        dismissPopup()
    }
    
    @IBAction func btnSubmit_Click(_ sender: UIButton) {
        
        if isClearOption {
         
            for model in arrData{
                model.isSelected = false
            }
            self.dismiss(animated: true) {
                self.didSelect?(SelectionPopupModel())
            }
            return
        }
        
        if (self.arrData.filter { $0.isSelected}.count) > 0{
            self.dismiss(animated: true) {
                self.didMultiSelect?(self.arrData.filter {$0.isSelected})
                self.didSelect?(self.arrData.filter {$0.isSelected}.first!)
            }
        }
        else if let msg = validationMessage,msg.count > 0{
            
            let vc = self.view.returnConfirmationPopup(title: "", message:  msg, confirmButtonTitle: StringConstants.ButtonTitles.KOk, onConfirmClick: {})
            let nav = UINavigationController(rootViewController: vc)
            
            vc.modalPresentationStyle = .custom
            vc.modalTransitionStyle = .crossDissolve
            self.present(nav, animated: true, completion: {
            })
        }
    }
}

extension SelectionPopupVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = arrData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionPopupCell", for: indexPath) as? SelectionPopupCell
        
        cell?.setData(model: model)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if strSubmitText.count == 0 {
            
            for model in arrData{
                model.isSelected = false
            }
            arrData[indexPath.row].isSelected = true
            tableView.reloadData()
            
            self.dismiss(animated: true) {
                self.didSelect?(self.arrData[indexPath.row])
            }
        }
        else{
            
            arrData[indexPath.row].isSelected = !arrData[indexPath.row].isSelected
            tableView.reloadData()
        }
    }
    
}

extension SelectionPopupVC {
    
    func dismissPopup() {
        self.dismiss(animated: true, completion: nil)
    }
}
