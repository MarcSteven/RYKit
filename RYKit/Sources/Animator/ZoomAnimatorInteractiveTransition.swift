//
// MemoryChainkIT

// Copyright © 2017 Marc Steven
// MIT license, see LICENSE file for details
//


import UIKit


/// 放大动画器交互渐变
final class ZoomAnimatorInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    /// 导航控制器
    weak var navigationController: UINavigationController?
    
    /// 放大pop手势
    weak var zoomPopGestureRecognizer: UIScreenEdgePanGestureRecognizer?
    
    /// 视图控制器
    private weak var viewController: UIViewController?
    
    /// 是否交互
    private var interactive = false
    
    /// 交互控制器
    var interactionController: ZoomAnimatorInteractiveTransition? {
        interactive ? self : nil
    }
    
    /// 处理屏幕边Pan手势
    /// - Parameter recognizer: 屏幕边pan手势
    @objc func handle(recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
            case .changed:
                guard let view = recognizer.view else { return }
                let progress = recognizer.translation(in: view).x / view.bounds.width
                update(progress)
            case .cancelled, .ended:
                guard let view = recognizer.view else { return }
                let progress = recognizer.translation(in: view).x / view.bounds.width
                let velocity = recognizer.velocity(in: view).x
                if progress > 0.33 || velocity > 1000.0 {
                    finish()
                } else {
                    if let viewController = viewController {
                        navigationController?.viewControllers.append(viewController)
                        update(0)
                    }
                    cancel()

                    if let viewController = viewController as? ZoomAnimatorDestination {
                        viewController.zoomAnimatorDestinationStateChanged(state: .cancelled)
                    }
                    if let viewController = navigationController?.viewControllers.last as? ZoomAnimatorSource {
                        viewController.zoomAnimatorSourceStateChanged(state: .cancelled)
                    }
                }
                interactive = false
            default:
                break
        }
    }
}

//MARK - 手势代理
extension ZoomAnimatorInteractiveTransition: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController = navigationController, navigationController.viewControllers.count > 1 else {
            return false
        }

        let count = navigationController.viewControllers.count
        let fromVC = navigationController.viewControllers[count - 1]
        let toVC = navigationController.viewControllers[count - 2]
        let zoomVCs1 = fromVC is ZoomAnimatorSource && toVC is ZoomAnimatorDestination
        let zoomVCs2 = fromVC is ZoomAnimatorDestination && toVC is ZoomAnimatorSource
        let zoomVCs = zoomVCs1 || zoomVCs2

        if gestureRecognizer === navigationController.interactivePopGestureRecognizer {
            return !zoomVCs
        } else if gestureRecognizer === zoomPopGestureRecognizer {
            if zoomVCs {
                interactive = true
                viewController = navigationController.popViewController(animated: true)
                return true
            }
        }
        return false
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        otherGestureRecognizer === navigationController?.interactivePopGestureRecognizer
    }
}
