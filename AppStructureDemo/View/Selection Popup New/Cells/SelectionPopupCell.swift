//
//  LanguageManager.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class SelectionPopupCell: UITableViewCell {

    // MARK: - Variables
    
    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewMain: UIView!
    
    // MARK: - View's Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Set Data
    func setData(model: SelectionPopupModel) {
        
        lblTitle.text = model.name
        lblTitle.font = model.isSelected ? FontScheme.kMediumFont(size: 14) : FontScheme.kLightFont(size: 14)
        viewMain.backgroundColor = model.isSelected ? ColorConstants.ThemeColor.withAlphaComponent(0.2) : UIColor.white

    }
    
    func setCellData(model : CellModel) {
        
        lblTitle.text = model.placeholder
        viewMain.backgroundColor = model.isSelected ? ColorConstants.ThemeColor.withAlphaComponent(0.2) : UIColor.white
        lblTitle.font = model.isSelected ? FontScheme.kMediumFont(size: 14) : FontScheme.kLightFont(size: 14)
    }
    
}
