
//
//  RYPopupViewBuilder.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/2.
//  Copyright © 2020 Rich And Young. All rights reserved.
//


import UIKit

/// PopView 代理方法
public protocol RYPopupViewDelegate {
    /// 显示
    func popup()
    /// 消失
    func dismiss()
}


/// popUpView构造器
public class RYPopupViewBuilder {
    
    /// 源视图
    fileprivate var sourceView: UIView?
    
    /// 目录视图
    fileprivate var contentView: UIView?
    
    /// 目录大小
    fileprivate var contentSize: CGSize = .zero
    
    /// 触摸是否可以消失
    fileprivate var canResignOnTouch: Bool = true
    
    /// 目录视图控制器
    fileprivate var contentViewController: UIViewController?
    
    /// 消失的句柄
    fileprivate var dismissalCompletionHandler: (() -> Void)?
    
    /// 消失的动画间隔
    fileprivate var dismissalAimationDuration: TimeInterval = 0.25
    
    /// 呈现的动画间隔
    fileprivate var presentationAnimationDuration: TimeInterval = 0.25
    
    /// popup  风格
    fileprivate var style: RYPopupStyle = .translucent(alpha: 0.5)
    
    /// 消失的动画
    fileprivate var dismissalAimation: RYPopupAnimation = .centered
    
    /// 呈现的动画
    fileprivate var presentationAnimation: RYPopupAnimation = .centered
    
    /// 呈现的风格
    fileprivate var presentationStyle: RYPopupPresentationStyle = .center
    
    /// 初始化器
    public init() {}
    
    /// 设置是否允许点击空白区域消失
    public func setCanResignOnTouch(_ canResignOnTouch: Bool) -> RYPopupViewBuilder {
        self.canResignOnTouch = canResignOnTouch
        return self
    }
    
    /// 设置样式
    public func setStyle(_ style: RYPopupStyle) -> RYPopupViewBuilder {
        self.style = style
        return self
    }
    
    /// 设置从哪个view弹出
    
    public func setSourceView(_ sourceView: UIView?) -> RYPopupViewBuilder {
        self.sourceView = sourceView
        return self
    }
    
    /// 设置弹出的view
    public func setContentView(_ contentView: UIView?) -> RYPopupViewBuilder {
        self.contentView = contentView
        return self
    }
    
    /// 设置弹出view的大小
    public func setContentSize(_ contentSize: CGSize) -> RYPopupViewBuilder {
        self.contentSize = contentSize
        return self
    }
    
    /// 设置消失的动画
    public func setDismissalAimation(_ dismissalAimation: RYPopupAnimation) -> RYPopupViewBuilder {
        self.dismissalAimation = dismissalAimation
        return self
    }
    
    /// 设置弹出的view controller
    public func setContentViewController(_ contentViewController: UIViewController?) -> RYPopupViewBuilder {
        self.contentViewController = contentViewController
        return self
    }
    
    /// 设置消失动画的时长
    public func setDismissalAimationDuration(_ dismissalAimationDuration: TimeInterval) -> RYPopupViewBuilder {
        self.dismissalAimationDuration = dismissalAimationDuration
        return self
    }
    
    /// 设置contentView显示的位置
    public func setPresentationStyle(_ presentationStyle: RYPopupPresentationStyle) -> RYPopupViewBuilder {
        self.presentationStyle = presentationStyle
        return self
    }
    
    /// 设置显示的动画
    public func setPresentationAnimation(_ presentationAnimation: RYPopupAnimation) -> RYPopupViewBuilder {
        self.presentationAnimation = presentationAnimation
        return self
    }
    
    /// 设置消失后的回调
    public func setDismissalCompletionHandler(_ dismissalCompletionHandler: (() -> Void)?) -> RYPopupViewBuilder {
        self.dismissalCompletionHandler = dismissalCompletionHandler
        return self
    }
    
    /// 设置显示动画的时长
    public func setPresentationAimationDuration(_ presentationAnimationDuration: TimeInterval) -> RYPopupViewBuilder {
        self.presentationAnimationDuration = presentationAnimationDuration
        return self
    }
    
    /// 构建一个popUp View
    /// - Returns: 返回popUpViewDelegate
    public func build() -> RYPopupViewDelegate {
        let v = RYPopupView()
        v.sourceView = sourceView
        v.contentView = contentView
        v.contentSize = contentSize
        v.canResignOnTouch = canResignOnTouch
        v.dismissalAimation = dismissalAimation
        v.presentationStyle = presentationStyle
        v.contentViewController = contentViewController
        v.presentationAnimation = presentationAnimation
        v.dismissalAimationDuration = dismissalAimationDuration
        v.dismissalCompletionHandler = dismissalCompletionHandler
        v.presentationAnimationDuration = presentationAnimationDuration
        return v 
    }
}
