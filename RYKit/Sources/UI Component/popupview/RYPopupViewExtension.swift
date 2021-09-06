//
//  RYPopupViewExtension.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/2.
//  Copyright © 2020 Rich And Young. All rights reserved.
//

import  UIKit

extension RYIn where Base: UIView {
    /// 返回弹出自身的popupView
    public var popupView: RYPopupViewDelegate? {
        return base.superview as? RYPopupViewDelegate
    }
}

extension RYIn where Base: UIViewController {
    /// 返回弹出自身的popupView
    public var popupView: RYPopupViewDelegate? {
        return base.view.ry.popupView
    }
}
