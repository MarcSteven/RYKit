//
//  LocalStorage.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/1.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import Foundation


/// Local存储协议
public protocol LocalStorage:class {
    
    /// 是否已经登录
    var isLoggedIn:Bool { get }
    
    /// 清除
    func clear()
}
