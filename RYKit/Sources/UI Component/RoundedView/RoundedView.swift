//
//  RoundedView.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/10/1.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//
import UIKit
@IBDesignable
/// 圆形视图
public class RoundedView:UIView {
    public override class var layerClass:AnyClass {
        return CAShapeLayer.self
    }
    /// 初始化
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    ///  安装layer
    private func setupLayer() {
        self.layer.cornerRadius = 11
        self.layer.masksToBounds = true
    }
}
