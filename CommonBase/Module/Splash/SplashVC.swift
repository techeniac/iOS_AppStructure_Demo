//
//  SplashVC.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit
import RealmSwift

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

                    
            // temp flow for uploadtest flight
            intialConfig()
    }

    //IntialConfig
    func intialConfig() {
        if ApplicationData.isUserLoggedIn {
            
            //ApplicationData.sharedInstance.registerToDrift()
            ApplicationData.sharedInstance.moveToHome()
        }
        else {
            print("not Login")
            Utilities.sideMenuGesture(isEnable: true)
            let vc = LoginVC.init(nibName: "LoginVC", bundle: nil)
            self.navigationController?.popAllAndSwitch(to: vc)
        }
    }

}
