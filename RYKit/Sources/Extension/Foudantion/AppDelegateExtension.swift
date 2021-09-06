//
//  AppDelegateExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/17.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit
import AVFoundation

public extension UIApplicationDelegate {
    
    /// support background mode
    func supportBackgroundMode() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        }catch {
            fatalError("\(error.localizedDescription)")
        }
    }
}
