//
//  KMActivityindicator.swift
//  HkConcept
//
//  Created by Mayur on 09/10/19.
//  Copyright © 2019 MayurMacmini. All rights reserved.
//

import UIKit
import Lottie

class KMActivityindicator: UIView {

    var lottieVw: AnimationView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        
        lottieVw = AnimationView(name: "loader")
        lottieVw.contentMode = .scaleAspectFit
        lottieVw.backgroundBehavior = .pauseAndRestore
        lottieVw.frame = CGRect(x: (AppConstants.ScreenSize.SCREEN_WIDTH / 2)-60, y: (AppConstants.ScreenSize.SCREEN_HEIGHT / 2)-60, width: 120, height: 120)
//        lottieVw.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        lottieVw.play(fromProgress: 0,
                           toProgress: 1,
                           loopMode: LottieLoopMode.loop,
                           completion: { (finished) in
        })
        
        self.addSubview(lottieVw)
    }
    
    func startAnimating() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.layer.isHidden = false
    }
    
    func stopAnimating() {
        self.layer.isHidden = true
    }
    
    
    //Start Animating
    class func startAnimating() {
        
        let vc = UIViewController.current()
        
        let indicator = KMActivityindicator(frame: CGRect(x: 0, y: 0, width: AppConstants.ScreenSize.SCREEN_WIDTH, height: AppConstants.ScreenSize.SCREEN_HEIGHT))
        
        indicator.tag = NSIntegerMax
        indicator.startAnimating()
        vc?.view.addSubview(indicator)
    }
    
    //Stop Animating
    class func stopAnimating() {
        
        if let vc = UIViewController.current() {
            
            if let view = (vc.view.viewWithTag(NSIntegerMax)) as? KMActivityindicator{
                view.stopAnimating()
                view.removeFromSuperview()
            }
        }
    }
}
