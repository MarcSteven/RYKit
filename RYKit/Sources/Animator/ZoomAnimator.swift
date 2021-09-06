//
// MemoryChainkIT

// Copyright © 2017 Marc Steven
// MIT license, see LICENSE file for details
//


import UIKit


/// 放大动画器
open class ZoomAnimator: TransitionAnimator {
    
    /// 放大动画器源
    private let source: ZoomAnimatorSource
    
    /// 放大动画器目的地
    private let destination: ZoomAnimatorDestination
    
    /// 初始化方法
    /// - Parameters:
    ///   - source: 动画器来源
    ///   - destination: 动画器目的地
    ///   - direction: 动画方向
    public required init(source: ZoomAnimatorSource, destination: ZoomAnimatorDestination, direction: AnimationDirection) {
        self.source = source
        self.destination = destination
        super.init()
        self.direction = direction
    }
    
    /// 渐变间隔
    /// - Parameter transitionContext: 渐变上下文
    /// - Returns: 返回对应的渐变间隔
    open override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        direction == .in ? source.zoomAnimatorSourceDuration : destination.zoomAnimatorDestinationDuration
    }
    
    /// 渐变
    /// - Parameters:
    ///   - context: 渐变上下文
    ///   - direction: 动画方向
    open override func transition(_ context: TransitionContext, direction: AnimationDirection) {
        switch direction {
            case .in:
                animateTransitionForPush(context)
            case .out:
                animateTransitionForPop(context)
        }
    }
    /// push的动画渐变
    /// - Parameter context: 渐变上下文
    private func animateTransitionForPush(_ context: TransitionContext) {
        guard let sourceView = context.from.view, let destinationView = context.to.view else {
            return context.completeTransition()
        }

        let containerView = context.containerView
        let transitioningImageView = transitioningPushImageView()

        containerView.backgroundColor = sourceView.backgroundColor
        sourceView.alpha = 1
        destinationView.alpha = 0

        if direction == .out {
            containerView.insertSubview(destinationView, belowSubview: sourceView)
        }
        containerView.addSubview(transitioningImageView)

        source.zoomAnimatorSourceStateChanged(state: .began)
        destination.zoomAnimatorDestinationStateChanged(state: .began)
        let destinationViewFrame = destination.zoomAnimatorDestinationViewFrame(direction: direction)

        source.zoomAnimatorSourceAnimation(animations: {
            sourceView.alpha = 0
            destinationView.alpha = 1
            transitioningImageView.frame = destinationViewFrame
        }, completion: {
            sourceView.alpha = 1
            transitioningImageView.alpha = 0
            transitioningImageView.removeFromSuperview()
            self.source.zoomAnimatorSourceStateChanged(state: .end)
            self.destination.zoomAnimatorDestinationStateChanged(state: .end)
            context.completeTransition()
        })
    }
    
    /// pop的渐变动画
    /// - Parameter context: 渐变上下文
    private func animateTransitionForPop(_ context: TransitionContext) {
        guard let sourceView = context.to.view, let destinationView = context.from.view else {
            return context.completeTransition()
        }

        let containerView = context.containerView
        let transitioningImageView = transitioningPopImageView()

        containerView.backgroundColor = destinationView.backgroundColor
        destinationView.alpha = 1
        sourceView.alpha = 0

        if direction == .out {
            containerView.insertSubview(sourceView, belowSubview: destinationView)
        }
        containerView.addSubview(transitioningImageView)

        source.zoomAnimatorSourceStateChanged(state: .began)
        destination.zoomAnimatorDestinationStateChanged(state: .began)
        let sourceViewFrame = destination.zoomAnimatorDestinationViewFrame(direction: direction)

        if transitioningImageView.frame.maxY < 0 {
            transitioningImageView.frame.origin.y = -transitioningImageView.frame.height
        }

        destination.zoomAnimatorDestinationAnimation(animations: {
            destinationView.alpha = 0
            sourceView.alpha = 1
            transitioningImageView.frame = sourceViewFrame
        }, completion: {
            destinationView.alpha = 1
            transitioningImageView.removeFromSuperview()
            self.source.zoomAnimatorSourceStateChanged(state: .end)
            self.destination.zoomAnimatorDestinationStateChanged(state: .end)
            context.completeTransition()
        })
    }
 
    
    /// 渐变推出图片
    /// - Returns: 返回对应的imageView
    private func transitioningPushImageView() -> UIImageView {
        let imageView = source.zoomAnimatorSourceView().snapshotImageView(afterScreenUpdates:true)
    
       return imageView
    }
   
    
    /// 渐变pop图片
    /// - Returns: 返回图片视图
    private func transitioningPopImageView() -> UIImageView {
        let imageView = source.zoomAnimatorSourceView().snapshotImageView()
        imageView.frame = destination.zoomAnimatorDestinationViewFrame(direction: direction)
        return imageView
    }
}
