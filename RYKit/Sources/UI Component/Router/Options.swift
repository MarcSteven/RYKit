//
//  Optionns.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/9/23.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

extension Router.Route {
    public struct Options {
        public enum Transition {
            /// Use modal on iPad and push on iPhone.
            case automatic
            case push
            case modal
        }

        public let transition: Transition
        public let isAnimated: Bool

        public init(transition: Transition, animated: Bool = true) {
            self.transition = transition
            self.isAnimated = animated
        }
    }
}



extension Router.Route.Options {
    /// Automatic
    public static var automatic: Self {
        .automatic(animated: true)
    }
    
    /// automatic
    /// - Parameter animated: is animated
    /// - Returns: return Self
    public static func automatic(animated: Bool) -> Self {
        .init(transition: .automatic, animated: animated)
    }

    ///  Push
    public static var push: Self {
        .push(animated: true)
    }
    
    /// Push
    /// - Parameter animated: is animated
    /// - Returns: Self
    public static func push(animated: Bool) -> Self {
        .init(transition: .push, animated: animated)
    }

    /// Push the given route without animation.
    public static var notAnimated: Self {
        .push(animated: false)
    }

    /// Modal
    public static var modal: Self {
        .modal(animated: true)
    }
    
    /// modal
    /// - Parameter animated: is animated
    /// - Returns: Self
    public static func modal(animated: Bool) -> Self {
        .init(transition: .modal, animated: animated)
    }
}



extension Router.Route.Options {
    
    /// isModal
    private var isModal: Bool {
        switch transition {
            case .push:
                return false
            case .modal:
                return true
            case .automatic:
                return UIDevice.current.userInterfaceIdiom == .pad
        }
    }

    /// Show the view controller on the given navigation controller.
    func display(_ vc: UIViewController, navigationController: UINavigationController) {
        guard isModal else {
            navigationController.pushViewController(vc, animated: isAnimated)
            return
        }

        // Embed the view controller in navigation controller so the router instance when
        // presented modally can be used. Router requires navigation controller.
        let vc = vc.embedInNavigationControllerIfNeeded()
        navigationController.present(vc, animated: isAnimated)
    }

    /// Show the list of view controller on the given navigation controller.
    func display(_ vcs: [UIViewController], navigationController: UINavigationController) {
        guard isModal else {
            navigationController.pushViewController(vcs, animated: isAnimated)
            return
        }

        // Embed the view controllers in navigation controller so the router instance
        // when presented modally can be used. Router requires navigation controller.
        let nvc = NavigationController()
        nvc.setViewControllers(vcs, animated: isAnimated)
        navigationController.present(nvc, animated: isAnimated)
    }
}
