//
//  NewsFeedVC.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit
import AVFoundation

class NewsFeedVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addPostView: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnMenu: UIButton!
    
    var page : Int = 1
    var totalCount : Int = 0
    var isShowLeftMenu : Bool = false
    var arrPost : [PostModel] = [PostModel]()
    var arrVoting : [PostModel] = [PostModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        SyncManager.sharedInstance.callAnalytics(page: PageAnalytics.NOTIFICATION, section: SectionAnalytics.LIST, action: ActionAnalytics.OPEN)
        initialConfig()
        callApiforList()
        //        callApiVotingPendingList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        Utilities.setNavigationBar(controller: self, isHidden: true)
    }
    
    func initialConfig(){
        
        if isShowLeftMenu{
            btnMenu.setImage(UIImage(named : "menu"), for: .normal)
        }
        
        tableView.register(UINib(nibName: "NewsFeedCellTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsFeedCellTableViewCell")
        
        tableView.es.addPullToRefresh {
            self.resetPagination()
        }
        
        tableView.es.addInfiniteScrolling {
            if self.arrPost.count == self.totalCount{
                self.tableView.es.stopLoadingMore()
                self.tableView.es.stopPullToRefresh()
            }else{
                self.page = self.page + 1
                self.callApiforList()
            }
        }
        collectionView.register(UINib(nibName: "VotingCollectionCell", bundle: nil), forCellWithReuseIdentifier: "VotingCollectionCell")
        imgProfile.setUserProfilePic()
    }
    
    //MARK: Button action methods
    @IBAction func btnMenu_Click(_ sender: UIButton) {
        
//        if isShowLeftMenu{
//            present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
//        }else{
//            self.navigationController?.popViewController(animated: true)
//        }
    }
    @IBAction func btnNotification_Click(_ sender: UIButton) {
        
        let vc = NotificationVC()
        UIViewController.current().navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnSetting_Click(_ sender: UIButton) {
        
print("Open Setting")
    }
}
//MARK: Tableview methods
extension NewsFeedVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedCellTableViewCell", for: indexPath) as! NewsFeedCellTableViewCell
        let postData = arrPost[indexPath.row]
        cell.setCellData(postData)
        
        if (postData.post ?? "").isVideo(){
            cell.imgPost.isHidden = true
            let avPlayer = AVPlayer(url: URL(string:postData.post ?? "")!)  		
            cell.viewPlayer?.playerLayer.player = avPlayer;
        }else{
            cell.viewPlayer.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let url = arrPost[indexPath.row].post ?? ""
//        if url.isVideo(){
//            let videoURL = URL(string: arrPost[indexPath.row].post!)
//            let player = AVPlayer(url: videoURL!)
//            let playerLayer = AVPlayerLayer(player: player)
//            playerLayer.frame = tableView.cellForRow(at: indexPath)!.bounds
//            self.view.layer.addSublayer(playerLayer)
//            player.play()
//        }else{
//            print("not video")
//        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = (cell as? NewsFeedCellTableViewCell) else { return };
        let visibleCells = tableView.visibleCells;
        let minIndex = visibleCells.startIndex;
        if tableView.visibleCells.firstIndex(of: cell) == minIndex {
            videoCell.viewPlayer.player?.play();
        }
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = cell as? NewsFeedCellTableViewCell else { return };
        videoCell.viewPlayer.player?.pause();
        videoCell.viewPlayer.player = nil;
    }
    
    
}

//MARK: CollectionView methods
extension NewsFeedVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrVoting.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VotingCollectionCell", for: indexPath) as! VotingCollectionCell
        cell.setData(model: arrVoting[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60, height: 60)
    }
    
    
}

//MARK: Api call
extension NewsFeedVC{
    
    func callApiforList(){
        
        var param : [String:Any] = [:]
        param["page"] = page
        param["limit"] = AppConstants.PageLimit.limit
        param["categories"] = "1,2,3"
        if (page == 1) { NetworkClient.sharedInstance.showIndicator("", stopAfter: 0.0) }
        NetworkClient.sharedInstance.request(AppConstants.serverURL, command: AppConstants.URL.Newsfeed, method: .get, parameters: param, headers: ApplicationData.sharedInstance.authorizationHeaders, success: { (response, message) in
            
            if let dictResponse = response as? [[String:Any]]{
                //
                //                if let count = dictResponse["count"] as? Int{
                //                    self.totalCount = count
                //                }
                
                //                if let list = dictResponse["list"] as? [[String:Any]]{
                for item in dictResponse{
                    self.arrPost.append(Mapper<PostModel>().map(JSON: item)!)
                }
                //                }
            }
            
            self.reloadList()
            self.callApiVotingPendingList()
            
        }) { (failureMessage, failureCode) in
            print("failureMessage",failureMessage)
            self.reloadList()
        }
    }
    func callApiVotingPendingList(){
        var param : [String:Any] = [:]
        param["tab"] = 1
        if (page == 1) { NetworkClient.sharedInstance.showIndicator("", stopAfter: 0.0) }
        NetworkClient.sharedInstance.request(AppConstants.serverURL, command: AppConstants.URL.VotingPending, method: .get, parameters: param, headers: ApplicationData.sharedInstance.authorizationHeaders, success: { (response, message) in
            
            if let dictResponse = response as? [[String:Any]]{
                for item in dictResponse{
                    self.arrVoting.append(Mapper<PostModel>().map(JSON: item)!)
                }
            }
            self.collectionView.reloadData()
        }) { (failureMessage, failureCode) in
            print("failureMessage",failureMessage)
            self.reloadList()
        }
    }
    
    //Reload Data
    func reloadList()  {
        
        self.tableView.es.stopLoadingMore()
        self.tableView.es.stopPullToRefresh()
        
        if self.arrPost.count == 0{
            //no_Post
            self.tableView.loadNoDataFoundView(message: StringConstants.Nodata.kNoNotification, image: "no_Diamond", isShowButton: true) {
                
                self.tableView.removeLoadAPIFailedView()
                self.resetPagination()
            }
            
        }else {
            self.tableView.removeLoadAPIFailedView()
        }
        
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    func resetPagination(){
        page = 1
        totalCount = 0
        arrPost.removeAll()
        callApiforList()
        tableView.reloadData()
    }
}
