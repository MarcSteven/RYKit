//
// MemoryChainkIT

// Copyright © 2017 Marc Steven
// MIT license, see LICENSE file for details
//

import UIKit



/// 放大动画器导航控制器代理
final public class ZoomAnimatorNavigationControllerDelegate: NSObject {
    
    /// 放大交互渐变
    private let zoomInteractiveTransition = ZoomAnimatorInteractiveTransition()
    
    /// 放大pop手势
    private let zoomPopGestureRecognizer = UIScreenEdgePanGestureRecognizer()
}

// MARK: UINavigationControllerDelegate

extension ZoomAnimatorNavigationControllerDelegate: UINavigationControllerDelegate {
    
    /// navigationViewController did show
    /// - Parameters:
    ///   - navigationController: 导航控制器
    ///   - viewController: 视图控制器
    ///   - animated: 是否动画
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if zoomPopGestureRecognizer.delegate !== zoomInteractiveTransition {
            zoomPopGestureRecognizer.delegate = zoomInteractiveTransition
            zoomPopGestureRecognizer.addTarget(zoomInteractiveTransition, action: #selector(ZoomAnimatorInteractiveTransition.handle(recognizer:)))
            zoomPopGestureRecognizer.edges = .left
            navigationController.view.addGestureRecognizer(zoomPopGestureRecognizer)
            zoomInteractiveTransition.zoomPopGestureRecognizer = zoomPopGestureRecognizer
        }
        
        /// 交互的pop手势
        if let interactivePopGestureRecognizer = navigationController.interactivePopGestureRecognizer, interactivePopGestureRecognizer.delegate !== zoomInteractiveTransition {
            zoomInteractiveTransition.navigationController = navigationController
            interactivePopGestureRecognizer.delegate = zoomInteractiveTransition
        }
    }
    
    /// 导航控制器与动画控制器交互
    /// - Parameters:
    ///   - navigationController: 导航控制器
    ///   - animationController: 动画控制器
    /// - Returns: 返回视图控制器交互渐变
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        zoomInteractiveTransition.interactionController
    }
    
    /// 导航控制器对应的操作
    /// - Parameters:
    ///   - navigationController: 导航控制器
    ///   - operation: 导航操作
    ///   - fromVC: 从对应 的视图控制器
    ///   - toVC: 到对应的视图控制器
    /// - Returns: 返回视图控制器动画的渐变
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let source = fromVC as? ZoomAnimatorSource, let destination = toVC as? ZoomAnimatorDestination, operation == .push {
            return ZoomAnimator(source: source, destination: destination, direction: .in)
        } else if let source = toVC as? ZoomAnimatorSource, let destination = fromVC as? ZoomAnimatorDestination, operation == .pop {
            return ZoomAnimator(source: source, destination: destination, direction: .out)
        }
        return nil
    }
}
