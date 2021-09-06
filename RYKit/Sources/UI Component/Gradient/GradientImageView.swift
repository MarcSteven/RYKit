//
//  GradientImageView.swift
//  MemoryChainUIKit
//
//  Created by Marc Zhao on 2018/9/13.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


/// 栅格图片视图
open class GradientImageView:UIImageView {

    /// Gradient type
    ///
    /// - normalGradient: normal gradient
    /// - none: none any gradient
    enum GradientType {
        case normalGradient
        case none
    }
    //MARK: - properties
    var gradientType:GradientType = .normalGradient {
        didSet {
            updateBackground()
        }
    }
    
    /// 栅格颜色
    @IBInspectable public var gradientColor:UIColor  = UIColor.black {
        didSet {
            updateBackground()
            
        }
    }
    
    /// 褪色的颜色
    @IBInspectable public var fadeColor:UIColor = UIColor.black {
        didSet {
            updateBackground()
        }
    }
    
    /// 褪色的透明度
    @IBInspectable public var fadeAlpha:Float = 0.3 {
        didSet {
            updateBackground()
            
        }
    }
    
    
    /// 透明层
    private var alphaLayer:CALayer?
    
    /// 栅格层
    private var gradientLayer:CAGradientLayer?
    
    /// clear 颜色
    private var clearColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
    
    /// 初始化器
    /// - Parameter aDecoder: coder
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /// - init method
    override public init(image: UIImage?) {
        super.init(image: image)
        
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    /// layout subview
    override open func layoutSubviews() {
        super.layoutSubviews()
        alphaLayer?.frame = self.bounds
        gradientLayer?.frame = self.bounds
        
    }
    
    /// update background color
    func updateBackground() {
        gradientLayer?.removeFromSuperlayer()
        alphaLayer?.removeFromSuperlayer()
        guard gradientType == .normalGradient else {
            return
        }
        
        gradientLayer = CAGradientLayer()
        alphaLayer = CALayer()
        
        gradientLayer!.frame = bounds
        gradientLayer!.colors = [clearColor.cgColor, gradientColor.cgColor]
        gradientLayer!.locations = [0, 0.8]
        
        alphaLayer!.frame = bounds
        alphaLayer!.backgroundColor = fadeColor.cgColor
        alphaLayer!.opacity = fadeAlpha
        
        layer.insertSublayer(gradientLayer!, at: 0)
        layer.insertSublayer(alphaLayer!, above: gradientLayer)

    }
}
