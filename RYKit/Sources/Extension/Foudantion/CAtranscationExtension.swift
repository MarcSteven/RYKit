//
//  CAtranscationExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/19.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import QuartzCore
import UIKit
/// CATranscation 扩展方法
extension CATransaction {
    /// 动画
    /// Parameters:
    /// - animations: 动画
    /// - completionHandle:完成句柄
    public static func animation(_ animations:() ->Void,completinonHandler:(() ->Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completinonHandler)
        animations()
        CATransaction.commit()
        
    }
    /// 无动画执行
    
    /// Parameters:
    /// - actionsWithouAnimation:没有动画的行为
    public static func performWithoutAnimation(_ actionsWithouAnimation:()->Void) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        actionsWithouAnimation()
        CATransaction.commit()
    }
}
extension CATransitionType {
    /// none
    public static let none = CATransitionType(rawValue: "")
    
}
