//
//  HUD.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/13.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit



/// hub视图
open class HUD:UIView {
   
    
    /// 进度条提示器
    private lazy var progressIndicator: UIActivityIndicatorView = {
        let activityIndictor = UIActivityIndicatorView()
        activityIndictor.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13, *) {
        activityIndictor.style = .large
        } else {
            activityIndictor.style = .whiteLarge
        }
        activityIndictor.startAnimating()
        return activityIndictor
    }()
    /// 标题label
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
 
    
    /// stackView
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
            ])
        
        return stackView
    }()

    
    /// 设置透明度
    /// - Parameters:
    ///   - alpha: 透明度
    ///   - animated: 是否动画
    ///   - completion: 完成句柄
    private func setAlpha(_ alpha: CGFloat, animated: Bool, completion: (() -> Void)? = nil) {
        let duration = animated ? 0.5 : 0
        UIView.animate(withDuration: duration, animations: {
            self.alpha = alpha
        }, completion: { _ in
            completion?()
        })
    }
    
    
    /// hud在对应的视图内
    /// - Parameter view: hud所在的视图
    /// - Returns: 返回一个hub
    public static func hud(in view: UIView) -> HUD? {
        return view.subviews.first(where: { $0 is HUD }) as? HUD
    }
    //便利的初始化器
    
    /// 便利的初始化器
    /// - Parameter text: 文本
    public convenience init(text: String?) {
        self.init(frame: .zero)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.stackView.addArrangedSubview(progressIndicator)
        self.stackView.addArrangedSubview(titleLabel)
        self.titleLabel.text = text
        self.hide(animated: false)
    }
    
    
    /// 展示
    /// - Parameters:
    ///   - animated: 是否动画
    ///   - completion: 完成闭包
    public func show(animated: Bool, completion: (() -> Void)? = nil) {
        self.setAlpha(1, animated: animated, completion: completion)
    }
  
    
    /// 隐藏hud
    /// - Parameters:
    ///   - animated: 是否动画
    ///   - completion: 完成闭包
    public func hide(animated: Bool, completion: (() -> Void)? = nil)  {
        self.setAlpha(0, animated: animated, completion: completion)
    }
    
}
