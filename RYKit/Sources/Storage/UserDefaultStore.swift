//
//  UserDefaultsStore.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/1.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import Foundation

/// UseDefaults存储类，使用UserDefaults
final public class UserDefaultsStore<T:Codable> {
    
    /// 存储时候所用的defaults
    private let storage:UserDefaults
    
    /// encoder
    private lazy var encoder = JSONEncoder()
    
    /// decoder
    private lazy var decoder = JSONDecoder()
    
    /// 通知的token
    private var notificationToken:NSObjectProtocol?
    
    /// key
    private let key:String
    
    /// 默认的值
    private let defaultValue:T?
    
    /// 缓存的值在内存中
    private var cachedValueInMemory:T?
    
    /// 是否应该缓存到内存中
    private let shouldCacheValueInMemory:Bool
    
    /// 初始化方法
    /// - Parameters:
    ///   - key: 对应的key
    ///   - defaultValue: 默认的值
    ///   - shouldCacheValueInMemory: 应该缓存到内存中
    ///   - storage: 对应的defaults
    public init(key:String,
                default defaultValue:T? = nil,
                shouldCacheValueInMemory:Bool = true,
                storage:UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.shouldCacheValueInMemory = shouldCacheValueInMemory
        self.storage = storage
        
    }
    
    /// value
    public var value:T? {
        get {
            if  let cachedValueInMemory = cachedValueInMemory {
                return cachedValueInMemory
            }
            guard let data = storage.object(forKey: key) as? Data, let value = try? decoder.decode(T.self, from: data)  else {
                return defaultValue
            }
            if shouldCacheValueInMemory {
                cachedValueInMemory = value
            }
            return value
        }
        set {
            let data = newValue == nil ? nil : try? encoder.encode(newValue)
            storage.set(data, forKey: key)
            if shouldCacheValueInMemory {
                cachedValueInMemory = newValue
            }
        }
    }
    
    /// 安装application内存警告观察者
    @available(iOS 11.0, *)
    
    private func setupApplicationMemoryWarningObserver() {
        notificationToken = NotificationCenter.on.applicationDidReceiveMemoryWarning {
            [weak self] in
            self?.cachedValueInMemory = nil
            
        }
    }
    deinit {
        
       
    }
}
//UserDefaultsStore conform to CustomStringConvertible
extension UserDefaultsStore :CustomStringConvertible {
    public var description: String {
        guard let value = value as? CustomStringConvertible else {
            return String(describing: self.value)
        }
        return value.description
    }
}
//UserDefaults store conform to CustomDebugStringConvertible
extension UserDefaultsStore:CustomDebugStringConvertible {
    public var debugDescription: String {
        return value.debugDescription
    }
}
