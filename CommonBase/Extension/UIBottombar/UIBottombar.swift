//
//  UIButtonCommon.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class UIBottombar: UIView {
    
    // MARK: - Variables
    var arrList : [Int] = [0]
    var arrBottomData = [CellModel]()
    var didSelecet : ((_ value : Int) -> ())?
    
    // MARK: - Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var contentView : UIView!

    @IBOutlet weak var viewTabBar: SoftUIView!
    @IBOutlet weak var viewBorder: SoftUIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit()  {
    
        Bundle.main.loadNibNamed("UIBottombar", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BottomCell", bundle: nil), forCellWithReuseIdentifier: "BottomCell")
        
        viewTabBar.type = .toggleButton
        viewTabBar.cornerRadius = 30
        
        viewBorder.type = .toggleButton
        viewBorder.cornerRadius = 30
        viewBorder.isSelected = true
        
        viewBorder.shadowOffset = .init(width: 1, height: 1)

    }

    
    
    // MARK:- Private Methods
    func prepareDatasource(arrList: [Int]) {
        
        arrBottomData.removeAll()
        
//        if arrList.contains(AppConstants.BottomMenuConstants.WatchList) {
//            arrBottomData.append(CellModel.getModel(placeholder: "KLblTrack".localized, type: .BottomTrack, imageName: "Track", cellObj: AppConstants.BottomMenuConstants.WatchList))
//            
//        }
//        
//        if arrList.contains(AppConstants.BottomMenuConstants.Reminder) {
//            arrBottomData.append(CellModel.getModel(placeholder: "KLblReminder".localized, type: .BottomReminder, imageName: "Reminder-1", cellObj: AppConstants.BottomMenuConstants.Reminder))
//            
//        }
//        
//        if arrList.contains(AppConstants.BottomMenuConstants.Comment) {
//            arrBottomData.append(CellModel.getModel(placeholder: "KLblComment".localized, type: .BottomNote, imageName: "note", cellObj: AppConstants.BottomMenuConstants.Comment))
//            
//        }
//        
//        if arrList.contains(AppConstants.BottomMenuConstants.Enquiry) {
//            arrBottomData.append(CellModel.getModel(placeholder: "KLblEnquiry".localized, type: .BottomEnquiry, imageName: "enquiry", cellObj: AppConstants.BottomMenuConstants.Enquiry))
//            
//        }
//        
//        if arrList.contains(AppConstants.BottomMenuConstants.Compare) {
//            arrBottomData.append(CellModel.getModel(placeholder: "KLblCompare".localized, type: .BottomCompare, imageName: "compare", cellObj: AppConstants.BottomMenuConstants.Compare))
//            
//        }
//        
//        if arrList.contains(AppConstants.BottomMenuConstants.PlaceOrder) {
//            arrBottomData.append(CellModel.getModel(placeholder: "KLblOrder".localized, type: .BottomPlaceOrder, imageName: "order", cellObj: AppConstants.BottomMenuConstants.PlaceOrder))
//            
//        }
        
        collectionView.reloadData()
    }
    
}
    // MARK:- collectionView Methods
extension UIBottombar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrBottomData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: AppConstants.ScreenSize.SCREEN_WIDTH / CGFloat(arrBottomData.count), height: collectionView.frame.size.height);
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCell", for: indexPath) as! BottomCell
        cell.setCellData(model: arrBottomData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = arrBottomData[indexPath.row]
        if let intValue = model.cellObj as? Int{
                self.didSelecet?(intValue)
        }
        
    }
}
