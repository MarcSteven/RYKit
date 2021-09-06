//
//  CaptchaButton.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/3/23.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

/// 倒计时button
public class CaptchaButton:UIButton {
   
    /// 最大的秒数
    public var maxSeconds:Int = 60
    /// 倒计时
    public var countdown = false {
        didSet {
            if oldValue != countdown {
                countdown ? startCountdown() : stopCountdown()
            }
        }
    }
    /// 秒
    private var second = 0
    /// 定时器
    private var timer:Timer?
    /// 时间标签
    private var timeLabel:UILabel!
    /// 通常的文本
    private var normalText:String!
    /// 通常的文本颜色
    private var normalTextColor:UIColor!
    /// 使失效的文本
    private var disabledText:String!
    /// 使失效的文本颜色
    private var disabledTextColor:UIColor!
    /// MARK: -life Cycle
    deinit {
        countdown = false
    }
    
    /// setup label
    public func setupLabel() {
        normalText = title(for: .normal) ?? ""
        disabledText = title(for: .disabled) ?? "second"
        normalTextColor = titleColor(for: .normal) ?? .white
        disabledTextColor = titleColor(for: .disabled) ?? .white
        timeLabel = titleLabel
        timeLabel.textAlignment = .center
        timeLabel.font  = titleLabel?.font
        timeLabel.text = normalText
        timeLabel.textColor = normalTextColor
    }
    /// 开始倒计时
    private func startCountdown() {
        second = maxSeconds
        updateDisabled()
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
        
    }
    /// update to make it disable
    private func updateDisabled() {
        isEnabled = true
        timeLabel.textColor = disabledTextColor
        timeLabel.text = "\(second)"
    }
    /// 停止倒计时
    private func stopCountdown() {
        timer!.invalidate()
        timer = nil
        updateNormal()
    }
    /// when the countdown was over ,update the normal font and color
    private func updateNormal() {
        isEnabled = true
        timeLabel.textColor = normalTextColor
        timeLabel.text = normalText
    }
    /// 更新倒计时
   @objc private func updateCountdown() {
        second -= 1
    if second <= 0 {
        countdown = false
    }else {
        updateDisabled()
    }
    }
}
