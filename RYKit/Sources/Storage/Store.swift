//
//  Store.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/1.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import Foundation


/// Store监听者协议
protocol StoreListener:class {
    func didUpdateStore()
}

/// 监听者的交换者
class ListenerWrapper {
    
    /// 监听者
    weak var listener:StoreListener?
    
    /// 初始化方法
    /// - Parameter listener: 监听者
    init(listener:StoreListener) {
        self.listener = listener
    }
    
}

/// Store协议
protocol Store :AnyObject{
    
    
    associatedtype Model :Codable,Equatable
    
    /// 键
    var key:String {get}
    
    /// defaults
    var defaults:UserDefaults {get}
    
    /// encoder
    var encoder:JSONEncoder {get}
    
    /// decoder
    var decoder:JSONDecoder {get}
    
    /// values
    var values:[Model] {get set}
    
    /// 监听者
    var listeners:[ListenerWrapper] {get set}
    
    /// 添加来自模型的value
    /// - Parameter value: model的值
    func add(_ value:Model)
    
    /// 添加监听者
    /// - Parameter listener: 存储的监听者
    func add(_ listener:StoreListener)
    
    /// remove 模型的value
    /// - Parameter value: model的value
    func remove(_ value:Model)
    
    /// 清除
    func clear()
    
    /// save
    func save()
    
    /// 是否包含来自模型的value
    /// - Parameter value: 模型的 value
    func contains(_ value:Model) ->Bool
}

extension Store {
    
    /// 包含某个值的默认实现
    /// - Parameter value: value
    /// - Returns: 如果包含则返回true，否则为false
    func contains(_ value:Model) ->Bool {
        return values.contains(value)
    }
    
    /// 清除
    func clear() {
        values.removeAll()
        save()
    }
    
    /// 保存
    func save() {
        guard let data = try? encoder.encode(values) else {
            return
        }
        defaults.set(data, forKey: key)
        listeners.forEach {$0.listener?.didUpdateStore()}
    }
    
    /// remove 值
    /// - Parameter value: 模型的value
    func remove(_ value:Model) {
        guard let offset = values.firstIndex(of: value) else {
            return
        }
        let index = values.startIndex.distance(to: offset)
        values.remove(at: index)
        save()
    }
    
    /// 添加监听者
    /// - Parameter listener: 存储的监听者
    func add(_ listener:StoreListener) {
        let wrapper = ListenerWrapper(listener: listener)
        listeners.append(wrapper)
        
        
    }
    
    /// 添加value
    /// - Parameter value: 模型里的value
    func add(_ value:Model) {
        guard !values.contains(value) else {
            return
        }
        values.insert(value,
                      at: 0)
        save()
    }
}
