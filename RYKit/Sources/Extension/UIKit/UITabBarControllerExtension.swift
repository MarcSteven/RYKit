//
//  UITabBarControllerExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/17.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit




extension UITabBarController {
    
    /// set tabBar hidden
    /// - Parameters:
    ///   - isHidden: isHidden
    ///   - animated: animated
    open func setTabBarHidden(_ isHidden:Bool,
                              animated:Bool) {
        let frame = tabBar.frame
        let offsetY = isHidden ? frame.size.height : -frame.size.height
        var newFrame = frame
        newFrame.origin.y = view.frame.maxY + offsetY
        tabBar.isHidden = false
        UIView.animate(withDuration: animated ? 0.35 : 0.0, delay: 0, options:UIView.AnimationOptions.beginFromCurrentState , animations: {
            self.tabBar.frame = newFrame
        }) { complete  in
            if complete {
                self.tabBar.isHidden = isHidden
            }
        }
    }
}
public  extension UITabBarController {
    
    /// is root view controller
    /// - Parameter viewController: view controller
    /// - Returns: if it's root view controller.return true
    func isRootViewController(_ viewController:UIViewController) ->Bool {
        guard let viewControllers = viewControllers else {
            return false
        }
        if let navigationController =  viewController.navigationController {
            return viewControllers.contains(navigationController)
        }
        return viewControllers.contains(viewController)
    }
    func hasRootViewController(_ viewController:UIViewController) ->Bool {
        guard let viewControllers = viewControllers else {
            return false
        }
        if let navigationController = viewController.navigationController {
            return viewControllers.contains(navigationController)
        }
        return viewControllers.contains(viewController)
    }
    
    /// hide tabBar
    /// - Parameters:
    ///   - isHidden: is hidden
    ///   - animated: animated
    func hideTabBar(_ isHidden:Bool,animated:Bool) {
        let frame = tabBar.frame
        let offsetY = isHidden ? frame.size.height : -frame.size.height
        var newFrame = frame
        newFrame.origin.y = view.frame.maxY + offsetY
        tabBar.isHidden = false
        UIView.animate(withDuration: animated ? 0.35 :0.0, delay: 0, options: .beginFromCurrentState, animations: {
            self.tabBar.frame = newFrame
        }, completion: {completion in
            if completion {
                self.tabBar.isHidden = isHidden
            }
        })
    }
}

