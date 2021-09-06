//
//  RefreshItem.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/9/25.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


/// refreash item
open class RefreshItem {
    
    /// center start
    private var centerStart: CGPoint
    
    /// center end
    private var centerEnd: CGPoint
    
    /// view
    unowned var view: UIView
    
    /// init method
    /// - Parameters:
    ///   - view: view
    ///   - centerEnd: centerEnd
    ///   - parallaxRatio: parallaxRatio
    ///   - sceneHeight: screen height
    init(view: UIView, centerEnd: CGPoint, parallaxRatio: CGFloat, sceneHeight: CGFloat) {
        self.view = view
        self.centerEnd = centerEnd
        centerStart = CGPoint(x: centerEnd.x, y: centerEnd.y + (parallaxRatio * sceneHeight))
        self.view.center = centerStart
    }
    
    /// update view postion for percentage
    /// - Parameter percentage: percentage 
    func updateViewPositionForPercentage(_ percentage: CGFloat) {
        view.center = CGPoint(
            x: centerStart.x + (centerEnd.x - centerStart.x) * percentage,
            y: centerStart.y + (centerEnd.y - centerStart.y) * percentage
        )
    }
    
}

