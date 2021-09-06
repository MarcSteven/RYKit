//
//  UITabBarController.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/1.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import UIKit
public extension UITabBarController {
    /// - tabBar高度
    func tabBarHeight() ->CGFloat {
        return self.tabBar.frame.size.height
    }
    /// - tabBar 宽度
    func tabBarWidth() ->CGFloat {
        return self.tabBar.frame.size.width
    }
}
