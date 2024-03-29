//
//  Pulse.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/13.
//  Copyright © 2020 Marc Steven. All rights reserved.
//

import UIKit

///  脉冲协议
public protocol Pulse{}

/// UIButton集成脉冲协议
extension Pulse where Self:UIButton {
    /// 搏动的动画
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }

}
