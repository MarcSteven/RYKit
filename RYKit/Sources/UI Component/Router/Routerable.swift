//
//  Routerable.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/9/23.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//


import UIKit

/// Routerable protocol
public protocol Routerable: class {
    
    /// route to
    /// - Parameters:
    ///   - route: router
    ///   - options: route optioons
    func route(to route: Router.Route<Self>, options: Router.Route<Self>.Options)
}

extension Routerable {
    
    /// default implement
    /// - Parameters:
    ///   - route: route
    ///   - options: options
    public func route(to route: Router.Route<Self>, options: Router.Route<Self>.Options = .push) {
        guard let navigationController = navigationController else {
            #if DEBUG
            Console.log("Unable to find \"navigationController\".")
            #endif
            return
        }

        let routeKind = route.configure(self)

        switch routeKind {
            case .viewController(let vc):
                options.display(vc, navigationController: navigationController)
            case .custom(let block):
                block(navigationController)
        }
    }
    
    /// route
    /// - Parameters:
    ///   - routes: routes
    ///   - options: options
    public func route(to routes: [Router.Route<Self>], options: Router.Route<Self>.Options = .push) {
        route(to: ._group(routes, options: options), options: options)
    }
}

/// route handle associated key
private struct RouteHandlerAssociatedKey {
    static var navigationController = "navigationController"
}

extension Routerable {
    
    /// navigation controller
    public var navigationController: UINavigationController? {
        objc_getAssociatedObject(self, &RouteHandlerAssociatedKey.navigationController) as? UINavigationController
    }
    
    /// set navigation controller
    /// - Parameter navigationController: navigation controller
    func _setNavigationController(_ navigationController: UINavigationController?) {
        objc_setAssociatedObject(self, &RouteHandlerAssociatedKey.navigationController, navigationController, .OBJC_ASSOCIATION_ASSIGN)
    }
}
