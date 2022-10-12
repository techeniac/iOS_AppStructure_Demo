//
//  NotificationVC.swift
//  CommonBase
//
//  Created by Romil Dhanani on 21/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {
    @IBOutlet weak var viewNavigationBar : UIView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var tblNotification : UITableView!
    @IBOutlet weak var btnBack : UIButton!
    
    var arrNotification = [NotificationModel]()
    var page : Int = 1
    var totalCount : Int = 0
    var isBackBtn : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialConfig()
    }
    
    func initialConfig(){
        if isBackBtn{
            btnBack.setImage(UIImage(named : "menu"), for: .normal)
        }
        
        tblNotification.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        tblNotification.es.addPullToRefresh {
            print("addPullToRefresh")
            self.resetPagination()
        }
        
        tblNotification.es.addInfiniteScrolling {
            print("addInfiniteScrolling")
            if self.arrNotification.count == self.totalCount{
                self.tblNotification.es.stopLoadingMore()
                self.tblNotification.es.stopPullToRefresh()
            }else{
                self.page = self.page + 1
                self.callApiNotificationList()
            }
        }
        
        callApiNotificationList()
    }
    //MARK: Button action methods
    @IBAction func btnBack_Click(_ sender: UIButton) {
        
        if isBackBtn{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}

//MARK: Tableview methods
extension NotificationVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let postData = arrNotification[indexPath.row]
        cell.setCellData(model: postData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
}

extension NotificationVC{
    func callApiNotificationList(){
        
        NetworkClient.sharedInstance.request(AppConstants.serverURL, command: AppConstants.URL.Notification, method: .get, headers: ApplicationData.sharedInstance.authorizationHeaders, success: { responce, msg in
            if let dictResponse = responce as? [[String:Any]]{
                for item in dictResponse{
                    self.arrNotification.append(Mapper<NotificationModel>().map(JSON: item)!)
                }
            }
            self.reloadList()
        }, failure: {failureMessage,failureCode in
            Utilities.showAlertView(message: failureMessage)
        })
    }
    
    func reloadList(){
        self.tblNotification.es.stopLoadingMore()
        self.tblNotification.es.stopPullToRefresh()
        
        if self.arrNotification.count == 0{
            //no_Notification
            self.tblNotification.loadNoDataFoundView(message: StringConstants.Nodata.kNoNotification, image: "no_Data", isShowButton: true) {
                
                self.tblNotification.removeLoadAPIFailedView()
                self.resetPagination()
            }
            
        }else {
            self.tblNotification.removeLoadAPIFailedView()
        }
        
        tblNotification.reloadData()
    }
    
    func resetPagination(){
        page = 1
        totalCount = 0
        arrNotification.removeAll()
        callApiNotificationList()
        tblNotification.reloadData()
    }
    
}
