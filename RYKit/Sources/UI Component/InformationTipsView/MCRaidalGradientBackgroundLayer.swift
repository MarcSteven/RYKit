//
//  MCRaidalGradientBackgroundLayer.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/6/15.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit


/// 辐射状的坡度背景层
open class MCRadialGradientBackgroundLayer:CALayer {
    ///中心
    public var center:CGPoint = .zero
    /// 半径
    public var radius:CGFloat = 0
    /// 位置
    public var locations:[CGFloat] = [CGFloat]()
    /// 颜色
    public var colors:[UIColor] = [UIColor]()
    
    @available(*,unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    @available(*,unavailable)
    public required override init(layer: Any) {
        super.init(layer: layer)
    }
    /// 初始化
    init(frame:CGRect,
         center:CGPoint,
         radius:CGFloat,
         locations:[CGFloat],
         colors:[UIColor]) {
        super.init()
        needsDisplayOnBoundsChange = true
        self.frame = frame
        self.center = center
        self.radius = radius
        self.locations = locations
        self.colors = colors
    }
    /// 绘制
    open override func draw(in ctx: CGContext) {
        ctx.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = self.colors.map {$0.cgColor}
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
        ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0, endCenter: center, endRadius: radius, options: [])
        ctx.restoreGState()
    }
    
}
