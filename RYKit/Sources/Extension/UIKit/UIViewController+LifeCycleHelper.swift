//
//  UIView+LifeCycleHelper.swift
//  MemoryChainExtensionService
//
//  Created by Marc Zhao on 2018/9/14.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

/// Observer
public protocol Observer {
    
    /// remove
    func remove()
}

public extension UIViewController {
    /// onViewWillAppear
    /// - Parameter callback: callback
    /// - Returns: observer
    @discardableResult
    
    func onViewWillAppear(run callback:@escaping () ->Void) ->Observer {
        return ViewControllerLifecycleObserver(parent: self, viewWillAppearCallback: callback)
    }
    /// onView did appear
    /// - Parameter callback: callback
    /// - Returns: observer
    @discardableResult
    
    func onViewDidAppear(run callback: @escaping () -> Void) -> Observer {
        return ViewControllerLifecycleObserver(
            parent: self,
            viewDidAppearCallback: callback
        )
    }
    
    /// onViewWillDisappear
    /// - Parameter callback: callback
    /// - Returns: observer
    @discardableResult
    
    func onViewWillDisappear(run callback: @escaping () -> Void) -> Observer {
        return ViewControllerLifecycleObserver(
            parent: self,
            viewWillDisappearCallback: callback
        )
    }
    
    /// on view did disappear
    /// - Parameter callback: callback
    /// - Returns: observer
    @discardableResult
    func onViewDidDisappear(run callback: @escaping () -> Void) -> Observer {
        return ViewControllerLifecycleObserver(
            parent: self,
            viewDidDisappearCallback: callback
        )
    }
}

/// viewController lifeCycle observer
private class ViewControllerLifecycleObserver:UIViewController,Observer {
    
    /// remove
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    /// view will appear callback
    private var viewWillAppearCallback:(()->Void)? = nil
    
    /// view did appear call back
    private var viewDidAppearCallback:(()->Void)? = nil
    
    /// view will disappear callback
    private var viewWillDisappearCallback:(()->Void)? = nil
    
    /// view did disappear callback
    private var viewDidDisappearCallback:(()->Void)? = nil
    
    /// init
    /// - Parameters:
    ///   - parent: parent
    ///   - viewWillAppearCallback: viewwill appear callback
    ///   - viewDidAppearCallback: view did appear callback
    ///   - viewWillDisappearCallback: view will disappear callback
    ///   - viewDidDisappearCallback: view did disappear callback
    convenience init(
        parent:UIViewController,
        viewWillAppearCallback:(()->Void)? = nil,
        viewDidAppearCallback:(()->Void)? = nil,
        viewWillDisappearCallback:(()->Void)? = nil,
        viewDidDisappearCallback:(()->Void)? = nil
        ) {
        self.init()
        add(to: parent)
        self.viewWillAppearCallback = viewWillAppearCallback
        self.viewDidAppearCallback = viewDidAppearCallback
        self.viewWillDisappearCallback = viewWillDisappearCallback
        self.viewDidDisappearCallback = viewDidDisappearCallback
        
    }
    
    /// view will appear
    /// - Parameter animated: animated
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillDisappearCallback?()
    }
    
    /// view did appear
    /// - Parameter animated: animated
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearCallback?()
    }
    
    /// view will disappear
    /// - Parameter animated: animated
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearCallback?()
    }
    
    /// view did disappear
    /// - Parameter animated: animated
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewDidDisappearCallback?()
    }
    
    /// add
    /// - Parameter parent: parent view controller
    private func add(to parent:UIViewController) {
        parent.addChild(self)
        view.isHidden = true
        parent.view.addSubview(view)
        didMove(toParent: parent)
    }
}
