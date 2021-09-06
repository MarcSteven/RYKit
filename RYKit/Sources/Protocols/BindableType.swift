//
//  BindableType.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/9/11.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit
/// 绑定协议
public protocol BindableType {
    
    associatedtype ViewModelType
    
    /// view model
    var viewModel:ViewModelType! {get set}
    
    /// bind view model
    func bindViewModel()
}
/** UIViewController 实现对应的绑定协议去绑定对应的VIE我Model到对应的UIViewController*/
extension BindableType where Self:UIViewController {
    mutating func bindViewModel(to model:Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
/// UIView 遵从绑定协议
extension BindableType where Self:UIView {
    mutating func bindViewModel( viewModel:Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}
