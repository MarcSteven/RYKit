//
//  CustomNavBar.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/21.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

@objcMembers
///自定义 navBar
class CustomNavBar:UINavigationBar {
    /// toTitle
    dynamic var toTitle: String? {
        didSet {
            toTitleLabel.text = toTitle
        }
    }
    /// fromTitle
    dynamic var fromTitle: String? {
        didSet {
            fromTitleLabel.text = fromTitle
        }
    }
    /// pop行为
    var popAction: (() -> Void)?
    /// 容器视图
    lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 48 / 255.0, green: 63 / 255.0, blue: 159 / 255.0, alpha: 1)
        return v
    }()
    /// to标题label
    var toTitleLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .center
        l.sizeToFit()
        return l
    }()
    ///  来自标题label
    var fromTitleLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .center
        l.sizeToFit()
        return l
    }()
    ///左边button
    lazy var leftButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .gray
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(pop), for: .touchUpInside)
        return b
    }()
    /// 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        configNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 配置navigationBar
    private func configNavBar() {
        containerView.addSubview(toTitleLabel)
        containerView.addSubview(fromTitleLabel)
        containerView.addSubview(leftButton)
        toTitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        toTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        fromTitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        fromTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        leftButton.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor).isActive = true
        leftButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        toTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        fromTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    /// pop action
    @objc private func pop() {
        popAction?()
    }
}
