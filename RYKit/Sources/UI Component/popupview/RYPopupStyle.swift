//
//  RYPopupStyle.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/3.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import UIKit

/// 样式
public enum RYPopupStyle {
    /// 全透明
    case transparent
    /// 不透明
    case opaque(color: UIColor)
    /// 半透明
    case translucent(alpha: CGFloat)
    /// 模糊
    case blur(style: UIBlurEffect.Style)
}
