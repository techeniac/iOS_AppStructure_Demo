//
//  TabbarVC.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit
 

class TabbarVC: UIViewController {

    // MARK: - Variables
    var arrBottomData = [CellModel]()
    var count = UserDefaults.standard.integer(forKey: "badge")

    // MARK: - Outlet
    @IBOutlet weak var viewContainer: UIView!

    @IBOutlet weak var viewTabBar: SoftUIView!
    @IBOutlet weak var viewBorder: SoftUIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedIndex = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
        
    }

    //MARK: Private methods
    func initialConfig() {
        
        viewTabBar.type = .toggleButton
        viewTabBar.cornerRadius = 30
        
        viewBorder.type = .toggleButton
        viewBorder.cornerRadius = 30
        viewBorder.isSelected = true
        
        viewBorder.shadowOffset = .init(width: 1, height: 1)
        
        collectionView.register(UINib(nibName: "BottomCell", bundle: nil), forCellWithReuseIdentifier: "BottomCell")

        self.reloadView(type: AppConstants.BottomMenuConstants.NewsFeed)
        prepareDatasource()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.changeSearchTab(_:)), name: NSNotification.Name(rawValue: "changeSearchTab"), object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(self.changeDiamondListTab(_:)), name: NSNotification.Name(rawValue: "changeSavedSearchTab"), object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData(_:)), name: NSNotification.Name(rawValue: "reloadData"), object: nil)

//        count = 10

    }
    
    func prepareDatasource() {
        
        arrBottomData.removeAll()
        
        arrBottomData.append(CellModel.getModel(placeholder: "KLblMenuNewsFeed".localized, type: .BottomNewsFeed, classType: .TabbarVC, imageName: "ic_home", cellObj: AppConstants.BottomMenuConstants.NewsFeed, isSelected: true))
//        
        
        arrBottomData.append(CellModel.getModel(placeholder: "KLblMenuFavorite".localized, type: .BottomFavorite, classType: .TabbarVC, imageName: "ic_voting", cellObj: AppConstants.BottomMenuConstants.Favorite))
        
        
        arrBottomData.append(CellModel.getModel(placeholder: "KLblMenuNotifications".localized, type: .BottomNotification, classType: .TabbarVC, imageName: "ic_search", cellObj: AppConstants.BottomMenuConstants.Notification))
        
            arrBottomData.append(CellModel.getModel(placeholder: "KLblProfile".localized, type: .BottomProfile, classType: .TabbarVC, imageName: "ic_profile", cellObj: AppConstants.BottomMenuConstants.Profile))
        
//        arrBottomData.append(CellModel.getModel(placeholder: "KLblProfile".localized, type: .BottomFavorite, classType: .TabbarVC, imageName: "Profile", cellObj: AppConstants.BottomMenuConstants.Profile))
        
        
        collectionView.reloadData()
    }
    
//    @objc func changeSearchTab(_ notification: NSNotification) {
//        print(notification.userInfo ?? "")
//
//    }
//
//    @objc func changeDiamondListTab(_ notification: NSNotification) {
//        print(notification.userInfo ?? "")
////        if let dict = notification.userInfo as NSDictionary? {
////            let vc = DiamondListVC.init(nibName: "DiamondListVC", bundle: nil)
////            vc.isShowLeftMenu = false
////            vc.filterParameter = dict as! [String : Any]
////            self.navigationController?.pushViewController(vc, animated: true)
////        }
//
//    }
//
//    @objc func reloadData(_ notification: NSNotification) {
//        collectionView.reloadData()
//    }
    
    func reloadView(type: Int) {
        
        if let previousVC = self.children.first {
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
        
        
        switch type {
        case AppConstants.BottomMenuConstants.NewsFeed:
            let vc = NewsFeedVC()
            vc.view.frame = self.viewContainer.bounds;
            vc.willMove(toParent: self)
            self.viewContainer.addSubview(vc.view)
            self.addChild(vc)
            vc.didMove(toParent: self)
            break
            
        case AppConstants.BottomMenuConstants.Favorite:
            
//            let vc = FilterVC()
//            vc.view.frame = self.viewContainer.bounds;
//            vc.willMove(toParent: self)
//            self.viewContainer.addSubview(vc.view)
//            self.addChild(vc)
//            vc.didMove(toParent: self)

            break
            
        case AppConstants.BottomMenuConstants.Notification:
            
//            let vc = SavedSearchListVC()
//            vc.view.frame = self.viewContainer.bounds;
//            vc.willMove(toParent: self)
//            self.viewContainer.addSubview(vc.view)
//            self.addChild(vc)
//            vc.didMove(toParent: self)

            break
            
        case AppConstants.BottomMenuConstants.Profile:
            
            let vc = ProfileVC()
            vc.view.frame = self.viewContainer.bounds;
            vc.willMove(toParent: self)
            self.viewContainer.addSubview(vc.view)
            self.addChild(vc)
            vc.didMove(toParent: self)


            break
        default:
            break
        }
        
        collectionView.reloadData()
        
    }
}
// MARK: - UICollectionView
extension TabbarVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        prepareDatasource()

        arrBottomData.filter {$0.isSelected == true}.map {$0.isSelected = false}

        let model = arrBottomData[indexPath.row]
        selectedIndex = indexPath.row
        if let intValue = model.cellObj as? Int {
            model.isSelected = true
            self.reloadView(type: intValue)
        }
    }
}
