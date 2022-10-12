//
//  LoginVC.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var txtUsername : UITextFiledCommon!
    @IBOutlet weak var txtPassword : UITextFiledCommon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSubmit_Click() {
        callLoginApi()
    }
    func initialConfig(){
        txtUsername.delegate = self
        txtUsername.isIcon = false
        txtUsername.textField.delegate = self
        txtUsername.textFiledType = .email
        txtUsername.textField.returnKeyType = .next
        txtUsername.placeholder = LanguageManager.localizedString("KHintUsername") as NSString
        txtUsername.lblTitle.text = LanguageManager.localizedString("KLblUsername") as String

        txtPassword.delegate = self
        txtPassword.isIcon = false
        txtPassword.textField.delegate = self
        txtUsername.textFiledType = .password
        txtPassword.textField.returnKeyType = .done
        txtPassword.placeholder = LanguageManager.localizedString("KHintPassword") as NSString
        txtPassword.lblTitle.text = LanguageManager.localizedString("KLblPassword") as String
        
        
#if DEBUG
        txtUsername.text = "bhargav.techeniac@gmail.com"
        txtPassword.text = "123"
#endif
        

    }
    
    func  callLoginApi(){
        var param = Parameters()
        param["email"] = txtUsername.textField.text?.removeWhiteSpaces()
        param["password"] = txtPassword.textField.text?.removeWhiteSpaces()
        param["login_type"] = "email"
        
        NetworkClient.sharedInstance.request(AppConstants.serverURL, command: AppConstants.URL.Login, method: .post, parameters: param, headers: ApplicationData.sharedInstance.authorizationHeaders) { response, message in
            if let dictResponse = response as? [String:Any]{
                ApplicationData.sharedInstance.saveLoginData(data: dictResponse)
                ApplicationData.sharedInstance.moveToHome()
            }
            
        } failure: { message, code in
            print(message)
        }
        
    }
}
extension LoginVC : TextFieldDelegate, UITextFieldDelegate{
    func didBeginEditing(textField: UITextField) {
        
    }
    
    func didEndEditing(textField: UITextField) {
        
    }
    
    func shouldReturn(textField: UITextField) {
        if textField == txtUsername.textField{
            txtPassword.textField.becomeFirstResponder()
        }
        else if textField == txtPassword.textField{
            textField.resignFirstResponder()
        }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        return true
    }
    
}
