//
// MemoryChainkIT

// Copyright © 2017 Marc Steven
// MIT license, see LICENSE file for details
//


import UIKit

/// 动画状态

/// 开始，取消，结束
public enum AnimationStatus {
    /// 开始，取消，结束
    case began,cancelled,end
}

/// 动画方向
public enum AnimationDirection {
    /// in , out
    case `in`,out
}

/// 渐变动画器
open class TransitionAnimator:NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    
    /// 渐变方向
    open var direction:AnimationDirection = .in
    
    /// 动画控制器
    /// - Parameters:
    ///   - presented: 呈现的视图控制器
    ///   - presenting: 正在呈现的视图控制器
    ///   - source: 源视图控制器
    /// - Returns: 视图控制器动画的渐变
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        direction = .in
        return self
    }
    
    /// 动画控制器消失
    /// - Parameter dismissed: 消失的视图控制器
    /// - Returns: 返回视图控制器动画的渐变
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        direction = .out
        return self
    }
    
    /// 动画的渐变
    /// - Parameter transitionContext: 使用渐变的上下文
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let context = TransitionContext(transitionContext: transitionContext) else {
            return transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        context.from.view.frame = context.containerView.bounds
        context.to.view.frame = context.containerView.bounds
        if direction == .in  {
            //add destination view to Container
            context.containerView.addSubview(context.to.view)
            
        }
        transition(context, direction: direction)
                }
    
    /// 渐变
    /// - Parameters:
    ///   - context: 渐变上下文
    ///   - direction: 动画的方向
    open func transition(_ context:TransitionContext,
                     direction:AnimationDirection) {
    fatalError(because: .subclassMustImplement)

    }
    
    /// 渐变间隔
    /// - Parameter transitionContext: 视图控制器上下文渐变
    /// - Returns: 渐变的时间间隔
    open func transitionDuration(using transitionContext:UIViewControllerContextTransitioning?) ->TimeInterval {
        fatalError(because: .subclassMustImplement)
    }
}

