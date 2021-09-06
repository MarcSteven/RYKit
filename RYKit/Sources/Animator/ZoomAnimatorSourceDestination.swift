//
// MemoryChainkIT

// Copyright © 2017 Marc Steven
// MIT license, see LICENSE file for details
//


import UIKit

///zoom动画器源
public protocol ZoomAnimatorSource {
    
    /// 放大源视图
    func zoomAnimatorSourceView() -> UIView
    
    /// 放大源视图frame
    /// - Parameter direction: 动画方向
    func zoomAnimatorSourceViewFrame(direction: AnimationDirection) -> CGRect
    
    /// 放大动画器源状态改变
    /// - Parameter state: 动画状态
    func zoomAnimatorSourceStateChanged(state: AnimationStatus)
    
    /// 放大动画器源动画
    /// - Parameters:
    ///   - animations: 动画
    ///   - completion: 完成闭包
    func zoomAnimatorSourceAnimation(animations: @escaping () -> Void, completion: @escaping () -> Void)
    
    /// 放大动画器源间隔
    var zoomAnimatorSourceDuration: TimeInterval { get }
}

extension ZoomAnimatorSource {
    
    /// 放大动画器源间隔默认实现，默认为0.35s
    public var zoomAnimatorSourceDuration: TimeInterval {
        0.35
    }
    
    /// 放大动画器源动画
    /// - Parameters:
    ///   - animations: 动画
    ///   - completion: 完成闭包
    public func zoomAnimatorSourceAnimation(animations: @escaping () -> Void, completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: zoomAnimatorSourceDuration, delay: 0, options: .curveEaseInOut, animations: animations) { _ in
            completion()
        }
    }
}

extension ZoomAnimatorSource where Self: UIViewController {
    
    /// 放大动画器源视图frame
    /// - Parameter direction: 动画方向
    /// - Returns: 返回对应源视图的frame
    public func zoomAnimatorSourceViewFrame(direction: AnimationDirection) -> CGRect {
        let sourceView = zoomAnimatorSourceView()
        return sourceView.convert(sourceView.bounds, to: view)
    }
    
    /// 放大动画器源状态改变
    /// - Parameter state: 动画状态
    public func zoomAnimatorSourceStateChanged(state: AnimationStatus) {
        switch state {
            case .began:
                zoomAnimatorSourceView().alpha = 0
            case .cancelled, .end:
                zoomAnimatorSourceView().alpha = 1
        }
    }
}


/// 放大动画器目的地协议
public protocol ZoomAnimatorDestination {
    
    /// 放大动画器目的视图的frame
    /// - Parameter direction: 动画方向
    func zoomAnimatorDestinationViewFrame(direction: AnimationDirection) -> CGRect
    
    /// 放大动画器目的视图状态改变
    /// - Parameter state: 动画状态
    func zoomAnimatorDestinationStateChanged(state: AnimationStatus)
    
    /// 放大动画器目的动画
    /// - Parameters:
    ///   - animations: 对应的动画
    ///   - completion: 完成闭包
    func zoomAnimatorDestinationAnimation(animations: @escaping () -> Void, completion: @escaping () -> Void)
    
    /// 放大动画器目的视图间隔
    var zoomAnimatorDestinationDuration: TimeInterval { get }
}

extension ZoomAnimatorDestination {
    
    /// 默认实现，默认为0.35s
    public var zoomAnimatorDestinationDuration: TimeInterval {
        0.35
    }
    
    /// 放大目的视图动画
    /// - Parameters:
    ///   - animations: 所在的动画
    ///   - completion: 完成闭包
    public func zoomAnimatorDestinationAnimation(animations: @escaping () -> Void, completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: zoomAnimatorDestinationDuration, delay: 0, options: .curveEaseInOut, animations: animations) { _ in
            completion()
        }
    }
}
