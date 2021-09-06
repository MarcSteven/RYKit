//
//  RYPopupView.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/2.
//  Copyright © 2020 Rich And Young. All rights reserved.
//

import UIKit

/// Default implementation for popup view
open class RYPopupView: UIControl, RYPopupViewDelegate {
    
    /// popUp 风格
     var style: RYPopupStyle
    
    /// 源视图
     weak var sourceView: UIView?
    
    /// 目录视图
     var contentView: UIView?
    
    /// 目录大小
     var contentSize: CGSize
    
    /// 目录视图控制器
     var contentViewController: UIViewController?
    
    /// 呈现的风格
     var presentationStyle: RYPopupPresentationStyle
    
    /// 呈现的动画
     var presentationAnimation: RYPopupAnimation
    
    /// 消失的动画
     var dismissalAimation: RYPopupAnimation
    
    /// 呈现动画的时间间隔
     var presentationAnimationDuration: TimeInterval
    
    /// 消失动画的时间间隔
     var dismissalAimationDuration: TimeInterval
    
    
    /// 消失的完成
     var dismissalCompletionHandler: (() -> Void)?
    
    /// 触摸是否可以退去
     var canResignOnTouch: Bool
    
    /// 初始化器
     init() {
        contentSize = .zero
        canResignOnTouch = true
        presentationStyle = .center
        dismissalAimation = .centered
        dismissalAimationDuration = 0.25
        style = .translucent(alpha: 0.5)
        presentationAnimation = .centered
        presentationAnimationDuration = 0.25
        super.init(frame: .zero)
        _commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("\(self) is deallocating...")
    }
}

extension RYPopupView {
    
    /// pop up
    public func popup() {
        let keyWindow = UIApplication.shared.keyWindow 
        guard let sourceView = (self.sourceView ?? keyWindow) else {
            debugPrint("sourceView为空")
            return
        }
        guard sourceView.size != .zero else {
            debugPrint("没有获取到sourceView的大小")
            return
        }
        guard _validate() else { return }
    
        self.frame = sourceView.bounds
        sourceView.addSubview(self)
        
        switch style {
        case .opaque(let color):
            self.backgroundColor = color
        case .transparent:
            self.backgroundColor = .clear
        case .blur(let style):
            self.backgroundColor = .clear
            let effect = UIBlurEffect(style: style)
            let blurView = UIVisualEffectView(effect: effect)
            blurView.frame = self.bounds
            self.addSubview(blurView)
        case .translucent(let alpha):
            let backgroundColor = self.backgroundColor ?? UIColor.black
            self.backgroundColor = backgroundColor.withAlphaComponent(alpha)
        }
        
        let contentView = self.contentView!
        self.addSubview(contentView)

        switch presentationAnimation {
        case .fromTop:
            contentView.centerX = self.width / 2
            contentView.top = -contentView.height
            if presentationStyle == .top {
                UIView.animate(withDuration: presentationAnimationDuration,
                               delay: 0, options: .curveEaseIn, animations: {
                                contentView.top = 0
                }, completion: nil)
            } else {
                UIView.animate(withDuration: presentationAnimationDuration,
                               delay: 0, options: .curveEaseIn, animations: {
                                contentView.centerY = self.height / 2
                }, completion: nil)
            }
        case .fromLeft:
            contentView.top = 0
            contentView.right = -contentView.width
            if presentationStyle == .left {
                UIView.animate(withDuration: presentationAnimationDuration,
                               delay: 0, options: .curveEaseIn, animations: {
                                contentView.left = 0
                }, completion: nil)
            } else {
                UIView.animate(withDuration: presentationAnimationDuration,
                               delay: 0, options: .curveEaseIn, animations: {
                                contentView.centerX = self.width / 2
                }, completion: nil)
            }
        case .fromRight:
            contentView.top = 0
            contentView.left = self.width
            if presentationStyle == .right {
                UIView.animate(withDuration: presentationAnimationDuration,
                               delay: 0, options: .curveEaseIn, animations: {
                                contentView.right = self.width
                }, completion: nil)
            } else {
                UIView.animate(withDuration: presentationAnimationDuration,
                               delay: 0, options: .curveEaseIn, animations: {
                                contentView.centerX = self.width / 2
                }, completion: nil)
            }
        case .fromBottom:
            contentView.top = self.height
            contentView.centerX = self.width / 2
            if presentationStyle == .bottom {
                UIView.animate(withDuration: presentationAnimationDuration,
                               delay: 0, options: .curveEaseIn, animations: {
                                contentView.bottom = self.height
                }, completion: nil)
            } else {
                UIView.animate(withDuration: presentationAnimationDuration,
                               delay: 0, options: .curveEaseIn, animations: {
                                contentView.centerY = self.height / 2
                }, completion: nil)
            }
        case .centered:
            if presentationStyle == .center {
                contentView.centerX = self.width / 2
                contentView.centerY = self.height / 2
                let animation = CAKeyframeAnimation(keyPath: "transform")
                animation.duration = presentationAnimationDuration
                var values = [CATransform3D]()
                values.append(CATransform3DMakeScale(0.1, 0.1, 1.0))
                values.append(CATransform3DMakeScale(1.1, 1.1, 1.0))
                values.append(CATransform3DMakeScale(0.9, 0.9, 1.0))
                values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
                animation.values = values
                contentView.layer.add(animation, forKey: "_kFDContentViewAnimationKey")
            } else {
                debugPrint("不科学的显示方式")
            }
        }
    }
    
    /// 消失
    public func dismiss() {
        guard _validate() else { return }
        let contentView = self.contentView!
        switch dismissalAimation {
        case .fromTop:
            if presentationStyle == .top || presentationStyle == .center {
                UIView.animate(withDuration: dismissalAimationDuration,
                               delay: 0, options: .curveEaseOut, animations: {
                                contentView.top = -contentView.height
                }, completion: { (flag) in
                    self._finalize()
                })
            } else {
                _fadeOut()
            }
        case .fromLeft:
            if presentationStyle == .left || presentationStyle == .center {
                UIView.animate(withDuration: dismissalAimationDuration,
                               delay: 0, options: .curveEaseOut, animations: {
                                contentView.right = -contentView.width
                }, completion: { (flag) in
                    self._finalize()
                })
            } else {
                _fadeOut()
            }
        case .fromRight:
            if presentationStyle == .right || presentationStyle == .center {
                UIView.animate(withDuration: dismissalAimationDuration,
                               delay: 0, options: .curveEaseOut, animations: {
                                contentView.left = self.width
                }, completion: { (flag) in
                    self._finalize()
                })
            } else {
                _fadeOut()
            }
        case .fromBottom:
            if presentationStyle == .bottom || presentationStyle == .center {
                UIView.animate(withDuration: dismissalAimationDuration,
                               delay: 0, options: .curveEaseOut, animations: {
                                contentView.top = self.height
                }, completion: { (flag) in
                    self._finalize()
                })
            } else {
                _fadeOut()
            }
        case .centered:
            if presentationStyle == .center {
                UIView.animate(withDuration: dismissalAimationDuration,
                               delay: 0, options: .curveEaseOut, animations: {
                                contentView.size = .zero
                                contentView.centerX = self.width / 2
                                contentView.centerY = self.height / 2
                }, completion: { (flag) in
                    self._finalize()
                })
            } else {
                _fadeOut()
            }
        }
    }
}

extension RYPopupView {
    
    /// 初始化
    private func _commonInit() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addTarget(self, action: #selector(_tapReceived(_:)), for: .touchUpInside)
    }
    
    /// 是否有效
    /// - Returns: 如果有效则返回true，否则返回false
    private func _validate() -> Bool {
        if let contentViewController = contentViewController {
            guard contentSize != .zero else {
                debugPrint("弹出控制器时必须指定view的大小")
                return false
            }
            contentView = contentViewController.view
            contentView?.size = contentSize
        } else {
            guard let contentView = contentView else {
                debugPrint("contentView和contentViewController均为空")
                return false
            }
            if contentSize != .zero {
                debugPrint("使用设置的contentViewSize覆盖原有尺寸")
                contentView.size = contentSize
            }
            guard contentView.size != .zero else {
                debugPrint("没有设置contentView的大小")
                return false
            }
        }
        return true
    }
    
    /// 最后确定
    private func _finalize() {
        self.contentView?.removeFromSuperview()
        self.removeFromSuperview()
        self.dismissalCompletionHandler?()
    }
    
    /// fade out
    private func _fadeOut() {
        UIView.animate(withDuration: dismissalAimationDuration,
                       delay: 0, options: .curveEaseOut, animations: {
                        self.alpha = 0
        }, completion: { (flag) in
            self._finalize()
        })
    }
}

extension RYPopupView {
    
    /// 接收tap事件
    /// - Parameter sender: uicontrol的sender
    @objc private func _tapReceived(_ sender: UIControl) {
        if canResignOnTouch {
            dismiss()
        }
    }
}
