//
//  SingleValueEncodingContainer.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/8.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
/// 单一值编码容器协议
public protocol SingleValueEncodingContainer {
    
    var codingPath:[CodingKey] {get}
    //编码 空值
    mutating func encodeNil() throws
    //编码bool
    mutating func encode(_ value:Bool) throws
    //编码Int
    mutating func encode(_ value:Int) throws
    //编码Int8
    mutating func encode(_ value:Int8) throws
    //编码Int16
    mutating func encode(_ value:Int16) throws
    //编码Int32
    mutating func encode(_ value:Int32) throws
    //编码Int64
    mutating func encode(_ value:Int64) throws
    //编码String
    mutating func encode(_ value:String) throws
    //编码float
    mutating func encode(_ value:Float) throws
    //编码Double
    mutating func encode(_ value:Double) throws
    //编码泛型 类型数据
    mutating func encode<T:Encodable>(_ value:T) throws
    
}
