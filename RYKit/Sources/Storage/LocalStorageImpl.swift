//
//  LocalStorageImpl.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/1.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import Foundation

/// Local存储的键
struct LocalStorageKeys {
    private init() {}
    
    static let isLoggedIn = "logged_in"
}

/// Local存储的实现
class LocalStorageImpl: LocalStorage {
    
    let userDefaults: UserDefaults
    
    /// 初始化方法
    /// - Parameter userDefaults: userDefautls
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        userDefaults.register(defaults: [LocalStorageKeys.isLoggedIn: false])
    }
    
    /// 是否已经登录
    var isLoggedIn: Bool {
        get {
            return userDefaults.bool(forKey: LocalStorageKeys.isLoggedIn)
        } set {
            userDefaults.set(newValue, forKey: LocalStorageKeys.isLoggedIn)
        }
    }
    
    /// 清除方法
    func clear() {
        userDefaults.removeObject(forKey: LocalStorageKeys.isLoggedIn)
    }
    
}

