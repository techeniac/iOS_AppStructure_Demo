//
//  PlayerView.swift
//  CommonBase
//
//  Created by Romil Dhanani on 20/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

class PlayerView: UIView {
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self;
    }

    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer;
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player;
        }
        set {
            playerLayer.player = newValue;
        }
    }
}
