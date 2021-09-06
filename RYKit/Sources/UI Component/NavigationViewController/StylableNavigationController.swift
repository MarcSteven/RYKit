//
//  StylableNavigationController.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/14.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit
/// NavigationController 风格
public enum NavigationControllerStyle {
    ///默认
    case `default`
    /// 深色
    case darkTinted(tintColor: UIColor)
    /// 浅色
    case lightTinted(tintColor: UIColor)
    /// 自定义
    case custom(style: Stylable)
}
/// NavigationBar可风格化协议
public protocol NavigationBarStylable:class {
    /// navigationBar风格
    var navigationBarStyle:NavigationControllerStyle? {get}
}

public extension NavigationBarStylable {
    /// navigationBar style的默认实现
    var NavigationBarStylable:NavigationControllerStyle? {
        return .default

    }
}
/// 可风格化的导航控制器
open class StylableNavigationController:UINavigationController {
   
     // Apply status bar style for ViewController
        open override var preferredStatusBarStyle: UIStatusBarStyle {
            guard
                let viewController = topViewController as? NavigationBarStylable,
                let navBarStyle = viewController.navigationBarStyle
            else {
                return super.preferredStatusBarStyle
            }
            switch navBarStyle {
            case .darkTinted:
                return .lightContent
            case .lightTinted:
                if #available(iOS 13.0, *) {
                    return .default
                } else {
                    return .default
                }
            case let .custom(style):
                return style.statusBarStyle
            default:
                return .default
            }
        }
        /// 视图生命周期方法
        open override func viewDidLoad() {
            super.viewDidLoad()
            guard let rootViewController = self.viewControllers.first else { return }
            setNavigationBarStyleFor(rootViewController)
        }
        
        open override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.setNeedsStatusBarAppearanceUpdate()
        }
        // push 控制器
        open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            self.setNavigationBarStyleFor(viewController)
            super.pushViewController(viewController, animated: animated)
        }
        /// pop控制器
        open override func popViewController(animated: Bool) -> UIViewController? {
            
            if let style = self.previousViewController {
                self.setNavigationBarStyleFor(style)
            }
            
            // Let's start pop action or we can't get transitionCoordinator()
            let popViewController = super.popViewController(animated: animated)
            
            // Secure situation if user cancelled transition
            transitionCoordinator?.animate(alongsideTransition: nil, completion: { [weak self] _ in
                guard let style = self?.topViewController else { return }
                self?.setNavigationBarStyleFor(style)
            })
            
            return popViewController
        }
        // 设置NavigationBar appearance更新
        open func setNeedsNavigationBarAppearanceUpdate() {
            guard let topViewController = topViewController else { return }
            self.setNavigationBarStyleFor(topViewController)
        }
    }

    private extension StylableNavigationController {
        /// 原来的控制器
        var previousViewController: UIViewController? {
            guard viewControllers.count > 1 else { return nil }
            return viewControllers[viewControllers.count - 2]
        }
        
        // Apply navigation bar style for ViewController
        func setNavigationBarStyleFor(_ viewController: UIViewController) {
            guard
                let stylableController = viewController as? NavigationBarStylable,
                let style = stylableController.navigationBarStyle
            else { return }
            self.applyNavigationBarStyle(style, for: viewController)
        }
        // 申请导航栏风格
        func applyNavigationBarStyle(_ style: NavigationControllerStyle, for viewController: UIViewController) {
            switch style {
            case .default:
                self.navigationBar.applyColors(barColor: nil, barTintColor: .black)
            case let .darkTinted(tintColor):
                self.navigationBar.applyColors(barColor: tintColor, barTintColor: .white)
                self.view.backgroundColor = tintColor
            case let .lightTinted(tintColor):
                self.navigationBar.applyColors(barColor: tintColor, barTintColor: .black)
                self.view.backgroundColor = tintColor
            case let .custom(style):
                self.navigationBar.apply(style)
                self.view.backgroundColor = style.barColor
            }
            
        }
}
