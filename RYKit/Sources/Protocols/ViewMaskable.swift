//
//  ViewMaskable.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/6.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit 

/// view可mask协议
public protocol ViewMaskable: class {
    /// 添加
    static func add(to superview: UIView) -> Self
    /// 消失
    func dismiss(_ completion: (() -> Void)?)
    /// 偏喜欢的导航栏颜色
    var preferredNavigationBarTintColor: UIColor { get }
    /// 偏好的状态栏风格
    var preferredStatusBarStyle: UIStatusBarStyle { get }
}

extension ViewMaskable {


    public var preferredStatusBarStyle: UIStatusBarStyle {
        preferredNavigationBarTintColor == .white ? .lightContent : .default
    }

    public func dismiss(after delayDuration: TimeInterval, _ completion: (() -> Void)? = nil) {
        
      
    }
}
