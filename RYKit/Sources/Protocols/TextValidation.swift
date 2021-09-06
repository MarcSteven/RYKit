//
//  TextValidation.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/23.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


/// text有效协议
public protocol  TextValidation {
    /// 正则表达式匹配字符串
    var regExFindMatchingString:String { get }
    /// 有效的消息
    var validationMessage:String { get }
}
extension TextValidation {
    /// 默认实现
    var regExFindMatchingString:String {
        get {
            return regExFindMatchingString + "$"
        }
    }
        /// 有效的字符串
        func validateString(str:String) ->Bool {
        if let _ = str.range(of: regExFindMatchingString, options: .regularExpression) {
            return true
        }else {
            return  false
        }
    }
    /// 获取匹配的字符串
    func getMatchingString(str:String) ->String? {
        if let newMatch = str.range(of: regExFindMatchingString, options: .regularExpression) {
            return String(str[newMatch])
        }else {
            return nil
        }
    }
}
