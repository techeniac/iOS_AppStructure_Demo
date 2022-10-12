//
//  BottomCell.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class BottomCell: UICollectionViewCell {

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellData(model: CellModel) {
        lblCount.CornerRadius = lblCount.frame.height / 2
        lblCount.text = "\(UserDefaults.standard.integer(forKey: "badge"))"

        lblName.text = model.placeholder
        
        lblCount.isHidden = true

        if UserDefaults.standard.integer(forKey: "badge") > 0 && model.placeholder == "Notifications" {
            lblCount.isHidden = false
        }
        

        
        imgIcon.image = UIImage.init(named: model.imageName ?? "")

        if model.classType == .TabbarVC {
            
            if model.isSelected {
                lblName.isHidden = false
                lblName.textColor = ColorScheme.colorFromConstant(textColorConstant: "kThemeColor")
                imgIcon.tintColor = ColorConstants.TitleColorOrange
            } else {
                lblName.isHidden = false
                lblName.textColor = ColorScheme.colorFromConstant(textColorConstant: "kGrayColor")
                imgIcon.tintColor = ColorConstants.TextColor
            }
            
        }
        
    }

}
