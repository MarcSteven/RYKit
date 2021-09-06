//
//  UIApplicationExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/9.
//  Copyright © 2020 Marc Zhao All rights reserved.
//

import UIKit


public extension UIApplication {
    
    /// shared or nil
    static var sharedOrNil:UIApplication? {
        let sharedApplicaitonSelector = NSSelectorFromString("sharedApplication")
        guard UIApplication.responds(to: sharedApplicaitonSelector) else {
            return nil
        }
        guard let unmanagedSharedApplication = UIApplication.perform(sharedApplicaitonSelector) else {
            return nil
        }
        return unmanagedSharedApplication.takeUnretainedValue() as? UIApplication
    }
    
    /// is first launch
    /// - Returns: bool. if it's the first time. return true
    class func isFirstToLaunch() ->Bool {
        if !UserDefaults.standard.bool(forKey: "HasAtLeastLaunchedOnce") {
            UserDefaults.standard.set(true, forKey: "HasAtLeastLaunchedOnce")
            UserDefaults.standard.synchronize()
            return true
        }
        return false
        
    }
        
func topViewController(_ base:UIViewController? = UIApplication.sharedOrNil?.keyWindow?.rootViewController) ->UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selectedViewController = tab.selectedViewController {
                return topViewController(selectedViewController)
            }
        }
        if let presentedViewController = base?.presentedViewController {
            return topViewController(presentedViewController)
        }
        return base
    }
    
    /// is keyboard presented
    var isKeyboardPresented:Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),
            self.windows.contains(where: {$0.isKind(of: keyboardWindowClass)}) {
            return true
        } else {
            return false
        }
    }
    
    /// show network activity
func showNetworkActivity() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    /// hide network activity
func hideNetworkActivity() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false 
        }
    }

}
// MARK: TopViewController

extension UIApplication {
    
    /// top view controller
    /// - Parameter base: base
    /// - Returns: uiviewcontroller
    open class func topViewController(_ base: UIViewController? = UIApplication.sharedOrNil?.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }

        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }

        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }

        return base
    }

    
    /// Iterates through `windows` from top to bottom and returns the visible window.
    ///
    /// - Returns: Returns an optional window object based on visibility.
    /// - Complexity: O(_n_), where _n_ is the length of the `windows` array.
    open var visibleWindow: UIWindow? {
        windows.reversed().first { !$0.isHidden }
    }
    
    
}

// MARK: UIWindow - TopViewController

//MARK: - status Bar height
public extension UIApplication {
    
    /// navigation bar height
    static var navigationBarHeight:CGFloat {
        var statusBarHeight:CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        }else {
            statusBarHeight = shared.statusBarFrame.height
        }
        return statusBarHeight
    }
}
public extension UIApplication {
    
    /// key window in connected scenes
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
}
