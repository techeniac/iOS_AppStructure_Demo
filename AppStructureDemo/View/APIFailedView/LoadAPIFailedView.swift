//
//  LoadAPIFailedView.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class LoadAPIFailedView: UIView {
    
    //MARK: IBOutlet
    @IBOutlet var btnRefresh: UIButton!
    @IBOutlet var lblNoDataFound: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var heightImg: NSLayoutConstraint!
    @IBOutlet weak var viewtemp: UIView!
    
    //MARK: Variables
    var isShowRefreshButton = true
    var message = ""
    var image : String?
    var btnRefreshClick : (() -> Void)?
    
    //MARK: View Life Cycle
    override func awakeFromNib() {
        
    }
    
    override func layoutSubviews() {
                
        guard (NetworkReachabilityManager()?.isReachable)! else {
            self.lblNoDataFound.text = StringConstants.Nodata.kNoInternet
            self.btnRefresh.setTitle(StringConstants.ButtonTitles.kRetry, for: .normal)
            self.imgView.image = UIImage(named: "no_internet")
            return
        }
        
        if(isShowRefreshButton){
            if message == StringConstants.Common.SomethingWrong{
                btnRefresh.setTitle(StringConstants.ButtonTitles.KTryAgain, for: .normal)
            }
            self.btnRefresh.isHidden = false
            //self.lblNoDataFound.isHidden = true
        }else{
            self.btnRefresh.isHidden = true
            //self.lblNoDataFound.isHidden = false
        }
        self.lblNoDataFound.text = message
        
        if let tempImage = image,tempImage.count > 0 {
            imgView.image = UIImage(named: tempImage)
        }
        else{
            imgView.isHidden = true
            heightImg.constant = 0
        }
        
    }
    
    @IBAction func btnRefresh_Click(_ sender: UIButton) {
        
        if let click = btnRefreshClick {
            click()
        }
    }
}
