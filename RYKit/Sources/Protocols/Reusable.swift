//
//  Reusable.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit
/// 可重用的协议
public protocol Reusable :class{
    /// 重用标识符
    static var reuseIdentifier:String {get}
    /// nib
    static var nib:UINib? { get }
}
extension Reusable {
    /// 默认实现
    public static var reuseIdentifier:String {
        return String(describing: self)
    }
    public static var nib:UINib? {
        return nil
    }
}
/// UITableViewCell 遵从reusable协议
extension UITableViewCell:Reusable {}

/// UICollectionViewCell遵从reusable协议
extension UICollectionViewCell:Reusable {}

