//
//  AVCaptureSessionExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/17.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import AVFoundation

public extension AVAudioSession {
    
    /// configure audio session
    func configureAudioSession() {
           let audioSession = AVAudioSession.sharedInstance()
           do {
               try audioSession.setCategory(.playback,mode: .moviePlayback,options: [])
           }catch {
               fatalError(because: .init("Failed to set audio session category"))
           }
       }
}
