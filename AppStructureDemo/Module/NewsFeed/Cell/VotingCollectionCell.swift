//
//  VotingCollectionCell.swift
//  CommonBase
//
//  Created by Romil Dhanani on 19/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class VotingCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(model: PostModel){
        imgImage.setImageForURL(url: URL( string: model.thumbnail ?? "" )!, placeHolder: UIImage (named: "Logo")) 
    }

}
