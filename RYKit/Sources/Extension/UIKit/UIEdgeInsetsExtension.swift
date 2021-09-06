//
//  UIEdgeInsetsExtension.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/30.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {
    /// 水平对应的value
    var horizontalValue:CGFloat {
        return right + left
    }
    /// 垂直对应的value
    var verticalValue:CGFloat {
        return top + bottom
    }
}
