//
//  StringRepresentable.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
/// An entity which can be represented as a string
public protocol StringRepresentable {
    /// 短字符
    var shortString:String {get}
    /// 中字符
    var mediumString:String {get}
    /// 长字符
    var longString:String {get}
}
extension NSObjectProtocol where Self:StringRepresentable {
    var description:String {
        return self.longString
    }
}
