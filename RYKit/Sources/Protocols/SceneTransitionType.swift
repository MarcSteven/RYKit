//
//  SceneTransitionType.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/10.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit

/// scene transition type
public enum SceneTransitionType {
    // you can extend this to add animated transition types,
    // interactive transitions and even child view controllers!
    
    case root(UIViewController)       // make view controller the root view controller.
    case push(UIViewController)       // push view controller to navigation stack.
    case present(UIViewController)    // present view controller.
    case alert(UIViewController)      // present alert.
    case tabBar(UITabBarController)   // make tab bar controller the root controller.
}

