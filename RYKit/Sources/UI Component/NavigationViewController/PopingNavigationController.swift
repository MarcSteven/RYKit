//
//  PopingNavigationController.swift
//  MCCalendarView
//
//  Created by Marc Steven on 2019/6/16.
//  Copyright © 2019 Marc Steven. All rights reserved.
//

import UIKit
/// Pop 导航控制器
open class PopingNavigationController:UINavigationController {
    ///交互Pop的渐变
    var interactivePopTransition:UIPercentDrivenInteractiveTransition!
    /// view已经加载
    override open func viewDidLoad() {
        self.delegate = self
    }
}
// UINavigationDelegate

extension PopingNavigationController:UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
       
       addPanGestrue(viewController: viewController)
    }
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (operation == .pop) {
            return PopTransition()
        }
        else {
            return nil
        }
    }
    /// 添加手势
    func addPanGestrue(viewController:UIViewController) {
        let popGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanRecognizer(recognier:)))
        viewController.view.addGestureRecognizer(popGestureRecognizer)
    }
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController.isKind(of: PopTransition.self) {
            return interactivePopTransition
        }
        else {
            return nil
        }
    }
    /// 手势处理
    @objc
    func handlePanRecognizer(recognier:UIPanGestureRecognizer) {
        
        // calculate how far the user has dragged accross the view
        var progress = recognier.translation(in: self.view).x / self.view.bounds.size.width
        progress = min(1, max(0, progress))
        
        if recognier.state == .began {
            // create a interactive transition and pop the view controller
            self.interactivePopTransition = UIPercentDrivenInteractiveTransition()
            self.popViewController(animated: true)
        }else if( recognier.state == .changed) {
            //update the interactive transition's progress
            if self.interactivePopTransition != nil {
                interactivePopTransition.finish()
            }
        }else {
            if self.interactivePopTransition != nil {
                interactivePopTransition.cancel()
            }
        }
        interactivePopTransition = nil
        
        
        
    }
}
