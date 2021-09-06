//
//  FadeAnimator.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit



/// 褪色动画反弹
public protocol FadeAnimatorBounceable {
    
    /// 褪色动画反弹到容器视图
    func fadeAnimatorBounceContainerView() -> UIView
}
/// 褪色动画器
open class FadeAnimator: TransitionAnimator {
    
    /// fade in时间间隔
    open var fadeInDuration: TimeInterval = 0.3
    
    /// fade out 时间间隔
    open var fadeOutDuration: TimeInterval = 0.25
    
    /// 是否fade in
    open var fadeIn = true
    
    /// 是否fade out
    open var fadeOut = true
    /// 渐变间隔时间
    open override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        direction == .in ? fadeInDuration : fadeOutDuration
    }
    
    /// 渐变
    /// - Parameters:
    ///   - context: 渐变上下文
    ///   - direction: 动画方向
    open override func transition(_ context: TransitionContext, direction: AnimationDirection) {
        switch direction {
            case .in:
                if fadeIn {
                    animateBounceFadeInOrFadeIn(context: context)
                } else {
                    context.completeTransition()
                }
            case .out:
                if fadeOut {
                    animateBounceFadeOutOrFadeOut(context: context)
                } else {
                    context.completeTransition()
                }
        }
    }

 
    
    /// 动画反弹fadeIn或者fadeOut
    /// - Parameter context: 渐变上下文
    private func animateBounceFadeInOrFadeIn(context: TransitionContext) {
        guard let bounceContainerView = (context.to as? FadeAnimatorBounceable)?.fadeAnimatorBounceContainerView() else {
            animateFadeIn(context: context)
            return
        }

        context.to.view.alpha = 0
        bounceContainerView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: fadeInDuration, animations: {
            context.to.view.alpha = 1
            bounceContainerView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                bounceContainerView.transform = .identity
            }, completion: { _ in
                context.completeTransition()
            })
        })
    }
    
    /// 动画fadeIn
    /// - Parameter context: 渐变上下文
    private func animateFadeIn(context: TransitionContext) {
        context.to.view.alpha = 0
        UIView.animate(withDuration: fadeInDuration, animations: {
            context.to.view.alpha = 1
        }, completion: { _ in
            context.completeTransition()
        })
    }

    
    /// 动画fadeIn或者FadeOut
    /// - Parameter context: 渐变上下文
    private func animateBounceFadeOutOrFadeOut(context: TransitionContext) {
        guard let bounceContainerView = (context.from as? FadeAnimatorBounceable)?.fadeAnimatorBounceContainerView() else {
            animateFadeOut(context: context)
            return
        }

        UIView.animate(withDuration: fadeOutDuration, animations: {
            context.from.view.alpha = 0
            bounceContainerView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { _ in
            context.completeTransition()
        })
    }
    
    /// 动画fadeOut
    /// - Parameter context: 渐变上下文
    private func animateFadeOut(context: TransitionContext) {
        UIView.animate(withDuration: fadeOutDuration, animations: {
            context.from.view.alpha = 0
        }, completion: { _ in
            context.completeTransition()
        })
    }
}

