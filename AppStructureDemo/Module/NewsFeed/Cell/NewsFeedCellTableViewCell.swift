//
//  NewsFeedCellTableViewCell.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class NewsFeedCellTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewPlayer: PlayerView!
    @IBOutlet weak var imgPost: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellData(_ model : PostModel){
        
        lblTitle.text = model.user?.getFullName ?? "-"
        imgPost.setImageForURL(url: URL(string: model.thumbnail ?? "")!, placeHolder: UIImage(named: "Logo"))
        imgProfile.setImageForURL(url: URL(string: model.user?.thumbnail ?? "")!, placeHolder: UIImage(named: "Logo"))
    }

    
}
