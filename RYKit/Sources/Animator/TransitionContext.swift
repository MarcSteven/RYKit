//
//  TransitionContext.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit


/// 渐变上下文
open class TransitionContext {
    
    /// 视图控制器上下文渐变
    public let context:UIViewControllerContextTransitioning
    
    /// 到哪个VC
    public let to:UIViewController
    
    /// 从哪个VC
    public let from:UIViewController
    
    /// 容器视图
    public let containerView:UIView
    
    /// 初始化器
    /// - Parameter transitionContext: 渐变的上下文
    public init?(transitionContext:UIViewControllerContextTransitioning){
        guard let to = transitionContext.viewController(forKey: .to),
            let from = transitionContext.viewController(forKey: .from)
            else {
            return nil
        }
        self.context = transitionContext
        self.to = to
        self.from = from
        self.containerView = transitionContext.containerView
        
    }
    
    /// 完成渐变
    open func completeTransition() {
        context.completeTransition(!context.transitionWasCancelled)
    }
}
