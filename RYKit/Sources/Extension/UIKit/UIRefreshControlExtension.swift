//
//  UIRefreshControlExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/9.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit

extension UIRefreshControl {
    
    /// Associated key
    private struct AssociatedKey {
        static var timeOutTimer = "timeOutTimer"
    }
    
    /// timeout timer
    private var timeoutTimer:Timer? {
        get {
            objc_getAssociatedObject(self, &AssociatedKey.timeOutTimer) as? Timer
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.timeOutTimer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
}
