//
//  CellOptions.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/24.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import Foundation



/// cell选项
public struct CellOptions: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
 
    
    /// 移动
    public static let move = Self(rawValue: 1 << 0)
    /// 删除
    public static let delete = Self(rawValue: 1 << 1)
    
    /// 无
    public static let none: Self = []
    
    /// 所有
    public static let all: Self = [move, delete]
}
