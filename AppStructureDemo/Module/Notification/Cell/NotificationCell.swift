//
//  NotificationCell.swift
//  CommonBase
//
//  Created by Romil Dhanani on 21/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var imgProfile : UIImageView!
    @IBOutlet weak var lblDesc : UILabel!
    @IBOutlet weak var imgPost : UIImageView!
    @IBOutlet weak var lblTime : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(model : NotificationModel){
        lblDesc.text = model.body
        lblTime.text = model.notificationTime
        imgProfile.setImageForURL(url: URL(string: (model.sentBy?.thumbnail ?? ""))!, placeHolder: UIImage(named: "Logo"))
        imgPost.setImageForURL(url: URL(string: model.post?.thumbnail ?? "")!, placeHolder: UIImage(named: "Logo"))
    }
}
