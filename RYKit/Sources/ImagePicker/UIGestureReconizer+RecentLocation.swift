//
//  UIGestureReconizer+RecentLocation.swift
//  RYKit
//
//  Created by Marc Steven on 2020/8/20.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import UIKit

extension UIGestureRecognizer {
    /// 获取当前手势直接作用到的 view（注意与 view 属性区分开：view 属性表示手势被添加到哪个 view 上，targetView 则是 view 属性里的某个 subview）
    public weak var targetView: UIView? {
        let locationPoint = location(in: view)
        let targetView = view?.hitTest(locationPoint, with: nil)
        return targetView
    }
}
