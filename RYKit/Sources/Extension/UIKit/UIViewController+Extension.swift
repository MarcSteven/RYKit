//
//  UIViewController+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/5/22.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


public extension UIViewController {
    /**
           * height of status bar + navigationBar(if navigationBar is existing)
     */
    @available(iOS 13.0, *)
    var topBarHeight:CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) + (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
public extension  UIViewController {
    
    /// install child view controller
    /// - Parameter child: child controller
    func install(_ child:UIViewController) {
        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(child.view)
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        child.didMove(toParent: self)
    }
    /// embed inNavigationController
    func embedInNavigationControllerIfNeeded() ->UIViewController {
        guard canBeEmbededInNavigationController else {
            return self
        }
        return NavigationController(rootViewController: self)
    }
    
    /// can be embeded in navigation controller
    private var canBeEmbededInNavigationController:Bool {
        switch self {
        case is NavigationController, is UITabBarController:
            return false
            
        default:
            return true
        }
    }
    /// Removes the view controller from its parent.
     func removeFromContainerViewController() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }

    /// A boolean value to determine whether the view controller is the root view controller of
    /// `UINavigationController` or `UITabBarController`.
     var isRootViewController: Bool {
        if let rootViewController = navigationController?.rootViewController {
            return rootViewController == self
        }

        return tabBarController?.isRootViewController(self) ?? false
    }

    /// A boolean value to determine whether the view controller is being popped or is showing a subview controller.
     var isBeingPopped: Bool {
        if isMovingFromParent || isBeingDismissed {
            return true
        }

        if let viewControllers = navigationController?.viewControllers, viewControllers.contains(self) {
            return false
        }

        return false
    }
    
    /// is Modal
     var isModal: Bool {
        if presentingViewController != nil {
            return true
        }

        if presentingViewController?.presentedViewController == self {
            return true
        }

        if let navigationController = navigationController, navigationController.presentingViewController?.presentedViewController == navigationController {
            return true
        }

        if (tabBarController?.presentingViewController?.isKind(of: UITabBarController.self)) != nil {
            return true
        }

        return false
    }

    /// A boolean value indicating whether the view is currently loaded into memory
    /// and presented on the screen.
     var isPresented: Bool {
        isViewLoaded && view.window != nil
    }

    /// A boolean value indicating whether the home indicator is currently present.
    
     var isHomeIndicatorPresent: Bool {
        if #available(iOS 11.0, *) {
           return view.safeAreaInsets.bottom > 0
        } else {
            // Fallback on earlier versions
            return false
        }
    }

    /// Only `true` iff `isDeviceLandscape` and `isInterfaceLandscape` both are `true`; Otherwise, `false`.
     var isLandscape: Bool {
        isDeviceLandscape && isInterfaceLandscape
    }

     var isInterfaceLandscape: Bool {
        UIApplication.sharedOrNil?.statusBarOrientation.isLandscape ?? false
    }

    /// Returns the physical orientation of the device.
     var isDeviceLandscape: Bool {
        UIDevice.current.orientation.isLandscape
    }

    /// This value represents the physical orientation of the device and may be different
    /// from the current orientation of your application’s user interface.
    ///
    /// - seealso: `UIDeviceOrientation` for descriptions of the possible values.
     var deviceOrientation: UIDeviceOrientation {
        UIDevice.current.orientation
    }

    
    /// add full screen
    /// - Parameter child: child view controller
    func addFullScreen(childViewController child:UIViewController) {
        guard child.parent == nil else {
            return
        }
        addChild(child)
        view.addSubview(child.view)
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            view.leadingAnchor.constraint(equalTo: child.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: child.view.trailingAnchor),
            view.topAnchor.constraint(equalTo: child.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: child.view.bottomAnchor)
        ]
        constraints.forEach {$0.isActive = true}
        view.addConstraints(constraints)
        
        child.didMove(toParent: self)
    }
    
    /// remove child view controller
    /// - Parameter child: child view controller
    func remove(childViewController child:UIViewController?) {
        guard let child = child else {
            return
        }
        guard child.parent != nil else {
            return
        }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    /// hide keyboard on tap
    func hideKeyBoardOnTap() {
        self.view.addGestureRecognizer(self.endEdittingRecongnizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEdittingRecongnizer())
        
    }
    
    /// end editting recongnizer
    /// - Returns: return gestureRecognizer
    private func endEdittingRecongnizer() ->UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        
        return tap
    }
    func configureBackButton(_ imageName:String) {
        let backImage = UIImage(named: imageName)
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
    }
    
    func configureNavigationBarButton(_ imageName:String,
                                      direction:Direction) {
        var image = UIImage(named: imageName)
        image = image?.withRenderingMode(.alwaysOriginal)
        switch direction {
        case .left:
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(goBack))
            
            
        case .right:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        }
        
    }
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
        
    }
    enum Direction {
        case left, right
    }
}
//MARK: - remove the backBarButton item title
extension UIViewController {
    open override  func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
