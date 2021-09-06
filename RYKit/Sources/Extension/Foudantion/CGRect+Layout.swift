//
//  CGRect+Layout.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit

public extension CGRect {
    
    /// layout height
    /// - Parameter spacing: spacing
    /// - Returns: return cgfloat
    func layoutHeight(width spacing:CGFloat)->CGFloat {
        return height > 0 ? height + spacing : 0
    }
}
