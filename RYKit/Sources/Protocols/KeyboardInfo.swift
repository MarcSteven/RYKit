//
//  KeyboardInfo.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/10/13.
//  Copyright © 2019 Memory Chain network technology(China) co,LTD. All rights reserved.
//

import UIKit

/// Keyboard info
struct KeyboardInfo {
    //MARK: - properties
    
    /// Animation cure
    let animationCure:UIView.AnimationCurve
    
    /// Animation duration
    let animationDuration:Double
    
    /// is local
    let isLocal:Bool
    
    /// begin frame
    let beginFrame:CGRect
    
    /// end frame
    let endFrame :CGRect
    
    /// animation curve key
    let animationCurveKey = UIResponder.keyboardAnimationCurveUserInfoKey
    
    /// animation duration key
    let animationDurationKey = UIResponder.keyboardAnimationDurationUserInfoKey
    
    /// isLocal key
    let isLocalKey = UIResponder.keyboardIsLocalUserInfoKey
    
    /// beigin frame key
    let beginFrameKey = UIResponder.keyboardFrameBeginUserInfoKey
    
    /// end frame key
    let endFrameKey = UIResponder.keyboardFrameEndUserInfoKey
    
    /// - method
    init?(_ notification:Notification) {
        guard let userInfo = notification.userInfo else {
            return nil
        }
        guard let animationCurveUserInfo = userInfo[animationCurveKey],
        let animationCureRaw = animationCurveUserInfo as? Int,
            let animationCurve = UIView.AnimationCurve(rawValue: animationCureRaw)
        
        else {
            return nil
        }
        self.animationCure = animationCurve
        guard let animationDurationUserInfo = userInfo[animationDurationKey],
        let animationDuration = animationDurationUserInfo as? Double
        else {
            return nil
            
        }
        self.animationDuration = animationDuration
        guard let isLocalUserInfo = userInfo[isLocalKey],
        let isLocal = isLocalUserInfo as? Bool
            else {
            return nil
        }
        self.isLocal = isLocal
        guard let beginFrameUserInfo = userInfo[beginFrameKey],
        let beginFrame = beginFrameUserInfo as? CGRect
        else {
            return nil
        }
        self.beginFrame = beginFrame
        guard let endFrameUserInfo = userInfo[endFrameKey],
        let endFrame = endFrameUserInfo as? CGRect
        else {
            return nil
        }
        self.endFrame = endFrame
    }
}
