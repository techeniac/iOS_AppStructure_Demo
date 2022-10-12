//
//  ProfileVCViewController.swift
//  CommonBase
//
//  Created by Romil Dhanani on 20/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var tblProfileInfo: UITableView!
    @IBOutlet weak var viewProfiePicture: UIView!
    @IBOutlet weak var btnProfiePicture: UIButton!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var viewSubmit: UIView!
    
    var userModel : UserModel = UserModel()
    var arrData = [CellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialConfig()
        
    }
    
    private func initialConfig() {
        
        tblProfileInfo.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        tblProfileInfo.tableHeaderView = viewProfiePicture
        tblProfileInfo.tableFooterView = viewSubmit
        userModel = ApplicationData.user
        imgProfile.setUserProfilePic()
        prepareDataSource()
        
    }
    
    func prepareDataSource()
    {
        arrData.removeAll()
        arrData.append(CellModel.getModel(placeholder: "KHintFirstName".localized, text: userModel.first_name, userText1: "KLblFirstName".localized,type: .UserFirstName, keyBoardType: UIKeyboardType.default, isRequired: true, apiKey: "firstName", errorMsg: "KMsgEmptyFirstname".localized))
        arrData.append(CellModel.getModel(placeholder: "KHintLatsName".localized, text: userModel.last_name, userText1: "KLblLatsName".localized,type: .UserLastName, keyBoardType: UIKeyboardType.default, isRequired: true, apiKey: "lastName", errorMsg: "KMsgEmptyLastname".localized))
        arrData.append(CellModel.getModel(placeholder: "KHintBio".localized, text: userModel.about, userText1: "KLblBio".localized,type: .UserBio, keyBoardType: UIKeyboardType.default, isRequired: false, apiKey: "bio", errorMsg: "KMsgEmptyBio".localized))
        arrData.append(CellModel.getModel(placeholder: "KHintEmail".localized, text: userModel.email, userText1: "KLblEmail".localized,type: .UserEmail, keyBoardType: UIKeyboardType.default, isRequired: true, apiKey: "email", errorMsg: "KMsgEmptyemail".localized))
        arrData.append(CellModel.getModel(placeholder: "KHintUsername".localized, text: userModel.username, userText1: "KLblUsername".localized,type: .UserUserName, keyBoardType: UIKeyboardType.default, isRequired: true, apiKey: "username", errorMsg: "KMsgEmptyUsername".localized))
        arrData.append(CellModel.getModel(text: "KLblLogout".localized ,type: .Logout, isRequired: true, apiKey: "logout"))
        
        tblProfileInfo.reloadData()
        
        
    }
    
    @IBAction func btnSubmit_Click(_ sender : UIButton){
        print("Submit CLick...")
    }
    @IBAction func btnUpdate_Click(_ sender : UIButton){
        print("Submit CLick...")
        callApiUpdateProfile()
        
    }
    @IBAction func btnProfilePicture_Click(_ sender : UIButton){
        print("Submit CLick...")
        Utilities.open_galley_or_camera(delegate: self, mediaType: ["public.image"], sender: self.view)
        
    }
}
//MARK: Tableview methods
extension ProfileVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = arrData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.setData(model)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableview did select")
        
        //        if arrData[indexPath.row].cellType == .Logout{
        //            UIViewController.current().view.showConfirmationPopupWithMultiButton(title: StringConstants.LoginScreen.KLblLogout, message: StringConstants.Common.kMsglogout, cancelButtonTitle: StringConstants.ButtonTitles.KCancel, confirmButtonTitle: StringConstants.ButtonTitles.kSubmit, onConfirmClick: {
        //                print("Submit")
        //
        //                ApplicationData.sharedInstance.logoutUser()
        //
        //             }, onCancelClick: {
        //                print("cancel")
        //            })
        //
        //           }
    }
    func getRequest() -> [String:String]{
        
        var req = [String:String]()
        for model in arrData{
            
            if model.cellType == .UserFirstName{
                req["first_name"] = model.userText
            }else if model.cellType == .UserLastName{
                req["last_name"] = model.userText
            }else if model.cellType == .UserBio{
                req["about"] = model.userText
            }else if model.cellType == .UserUserName{
                req["username"] = model.userText
            }else if model.cellType == .UserEmail{
                req["email"] = model.userText
            }
        }
        
        
        //        req["profileImage"] = self.userInfo.profileImage ?? ""
        
        return req
    }
    
    func callApiUpdateProfile(){
        print(getRequest())
        NetworkClient.sharedInstance.request(AppConstants.serverURL, command: AppConstants.URL.UpdateProfile, method: .post, parameters: getRequest(), headers: ApplicationData.sharedInstance.authorizationHeaders) { response, message in
            if var dic = response as? [String:Any] {
                
                self.userModel = Mapper<UserModel>().map(JSON: dic)!
                self.initialConfig()
            }
        } failure: { failureMessage, failureCode in
            self.reloadList()
            
        }
        
    }
    //Reload Data
    func reloadList()  {
        
        if self.arrData.count == 0{
            self.tblProfileInfo.loadNoDataFoundView(message: LanguageManager.localizedString("KLblUnableToFetchData"), image: "", isShowButton:  true) {
                
                self.tblProfileInfo.removeLoadAPIFailedView()
                self.prepareDataSource()
            }
            
        }else {
            self.tblProfileInfo.removeLoadAPIFailedView()
        }
        
        tblProfileInfo.reloadData()
    }
    
}
extension ProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) {
            var imagesList : [(String, UIImage)] = []
            imagesList.append(("profile_picture", info[.originalImage] as? UIImage ?? UIImage()))
            imagesList.append(("thumbnail", info[.originalImage] as? UIImage ?? UIImage()))
            if let pickedImage = info[.originalImage] as? UIImage {
                UploadManager.sharedInstance.uploadFile(AppConstants.serverURL, command: AppConstants.URL.UploadProfile, images: imagesList, fileURLs: [], uploadParamKey: "", params: nil , headers: ApplicationData.sharedInstance.authorizationHeaders,isPregress : true, success: { (response, message) in
                    
                    if let data = response as? [String:Any]{
                        
                        if let dict = data["data"] as? [String:Any]{
                            ApplicationData.sharedInstance.updateLoginData(data: dict)
                            self.imgProfile.setUserProfilePic()
                        }
                    }
                }) { (failureMessage) in
                    Utilities.showAlertView(title: AppConstants.AppName, message: failureMessage)
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
