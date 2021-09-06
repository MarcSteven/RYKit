//
//  MCDropMenuState.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/6/11.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

/// 下拉的状态

public enum MCDropDownState{
    /// - willOpen: 将要打开
    case willOpen
    /// - didOpen: 已经打开
    case didOpen
    /// - willClose: 将要关闭
    case willClose
    /// - didClose: 已经关闭
    case didClose
}
