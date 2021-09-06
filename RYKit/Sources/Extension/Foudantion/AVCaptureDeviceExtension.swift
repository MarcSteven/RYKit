//
//  AVCaptureDeviceExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import AVFoundation

public extension AVCaptureDevice.Position {
    
    /// capture device opposite
    /// - Returns: return positon
    func opposite() -> AVCaptureDevice.Position {
        switch self {
        case .back:
            return .front
        case .front:
            return .back
        default:
            return self
        }
    }
}

