//
//  Encoder.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/8.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

/// encoder
public protocol Encoder {
    
    /// coding path
    var codingPath:[CodingKey] {get}
    
    /// user info
    var userInfo:[CodingUserInfoKey:Any] {get}
    
    /// container
    /// - Parameter type: <#type description#>
    func container<Key:CodingKey>(keyedBy type:Key.Type)->KeyedEncodingContainer<Key>
    
    /// unkeyed container
    func unkeyedContainer() -> UnkeyedEncodingContainer
    
    /// single value container
    func singleValueContainer() ->SingleValueEncodingContainer
    
}
