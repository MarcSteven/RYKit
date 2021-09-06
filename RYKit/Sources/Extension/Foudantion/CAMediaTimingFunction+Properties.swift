//
//  CAMediaTimingFunction+Properties.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/19.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import QuartzCore
import UIKit

extension CAMediaTimingFunction {
    
    /// default
    public static let `default` = CAMediaTimingFunction(name: .default)
    
    /// linear
    public static let linear = CAMediaTimingFunction(name: .linear)
    
    /// ease in
    public static let easeIn = CAMediaTimingFunction(name: .easeIn)
    
    /// ease out
    public static let easeOut = CAMediaTimingFunction(name: .easeOut)
    
    /// easein ease out
    public static let easeInEaseOut = CAMediaTimingFunction(name: .easeInEaseOut)
}
