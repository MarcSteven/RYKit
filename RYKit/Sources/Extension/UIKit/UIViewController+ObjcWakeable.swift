//
//  UIViewController+ObjcWakeable.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/8.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit

extension UIViewController:ObjcWakeable {
    //MARK: - static
    private struct Static {
        fileprivate static var originalViewWillAppear:(@convention(c) (AnyObject,Selector,Bool)->Void)!
        fileprivate static var originalViewDidAppear:(@convention(c)(AnyObject,Selector,Bool)->Void)!
        fileprivate static var originalViewWillDisappear:(@convention(c)(AnyObject,Selector,Bool)->Void)!
        fileprivate static var originalViewDidDisappear:(@convention(c)(AnyObject,Selector,Bool)->Void)!
    }
    
    /// wake up
    public static func wakeUp() {
        let originalViewWillAppear    = class_getInstanceMethod(UIViewController.self, #selector(viewWillAppear(_:)))!
        let replacementViewWillAppear = class_getInstanceMethod(UIViewController.self, #selector(__viewWillAppear_IMP(_:)))!
        Static.originalViewWillAppear = unsafeBitCast(method_setImplementation(originalViewWillAppear, method_getImplementation(replacementViewWillAppear)), to: (@convention(c) (AnyObject, Selector, Bool) -> Void).self)
        
        let originalViewDidAppear    = class_getInstanceMethod(UIViewController.self, #selector(viewDidAppear(_:)))!
        let replacementViewDidAppear = class_getInstanceMethod(UIViewController.self, #selector(__viewDidAppear_IMP(_:)))!
        Static.originalViewDidAppear = unsafeBitCast(method_setImplementation(originalViewDidAppear, method_getImplementation(replacementViewDidAppear)), to: (@convention(c) (AnyObject, Selector, Bool) -> Void).self)
        
        let originalViewWillDisappear    = class_getInstanceMethod(UIViewController.self, #selector(viewWillDisappear(_:)))!
        let replacementViewWillDisappear = class_getInstanceMethod(UIViewController.self, #selector(__viewWillDisappear_IMP(_:)))!
        Static.originalViewWillDisappear = unsafeBitCast(method_setImplementation(originalViewWillDisappear, method_getImplementation(replacementViewWillDisappear)), to: (@convention(c) (AnyObject, Selector, Bool) -> Void).self)
        
        let originalViewDidDisappear    = class_getInstanceMethod(UIViewController.self, #selector(viewDidDisappear(_:)))!
        let replacementViewDidDisappear = class_getInstanceMethod(UIViewController.self, #selector(__viewDidDisappear_IMP(_:)))!
        Static.originalViewDidDisappear = unsafeBitCast(method_setImplementation(originalViewDidDisappear, method_getImplementation(replacementViewDidDisappear)), to: (@convention(c) (AnyObject, Selector, Bool) -> Void).self)

    }
   
    
    /// view will appear handler
    var viewWillAppearHandler: ((Bool) -> Void)? {
        get { return objc_getAssociatedObject(self, &Static.originalViewWillAppear) as! ((Bool) -> Void)? }
        set { objc_setAssociatedObject(self, &Static.originalViewWillAppear, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    /// view did appear handler
    var viewDidAppearHandler: ((Bool) -> Void)? {
        get { return objc_getAssociatedObject(self, &Static.originalViewDidAppear) as! ((Bool) -> Void)? }
        set { objc_setAssociatedObject(self, &Static.originalViewDidAppear, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    /// view will disappear handler
    var viewWillDisappearHandler: ((Bool) -> Void)? {
        get { return objc_getAssociatedObject(self, &Static.originalViewWillDisappear) as! ((Bool) -> Void)? }
        set { objc_setAssociatedObject(self, &Static.originalViewWillDisappear, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    /// view did disappear handler
    var viewDidDisappearHandler: ((Bool) -> Void)? {
        get { return objc_getAssociatedObject(self, &Static.originalViewDidDisappear) as! ((Bool) -> Void)? }
        set { objc_setAssociatedObject(self, &Static.originalViewDidDisappear, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    //MARK: - Public Methods
    
    /// append view will appear handler
    /// - Parameter handler: handler
    func appendViewWillAppearHandler(_ handler: @escaping (Bool) -> Void) {
        var finalHandler = handler
        
        if let originalHandler = self.viewWillAppearHandler {
            finalHandler = { animated in
                originalHandler(animated)
                handler(animated)
            }
        }
        
        self.viewWillAppearHandler = finalHandler
    }
    
    /// append view did appear handler
    /// - Parameter handler: handler
    func appendViewDidAppearHandler(_ handler: @escaping (Bool) -> Void) {
        var finalHandler = handler
        
        if let originalHandler = self.viewDidAppearHandler {
            finalHandler = { animated in
                originalHandler(animated)
                handler(animated)
            }
        }
        
        self.viewDidAppearHandler = finalHandler
    }
    
    /// append view will disappear handler
    /// - Parameter handler: handler
    func appendViewWillDisappearHandler(_ handler: @escaping (Bool) -> Void) {
        var finalHandler = handler
        
        if let originalHandler = self.viewWillDisappearHandler {
            finalHandler = { animated in
                originalHandler(animated)
                handler(animated)
            }
        }
        
        self.viewWillDisappearHandler = finalHandler
    }
    
    /// append view did disappear handler
    /// - Parameter handler: handler
    func appendViewDidDisappearHandler(_ handler: @escaping (Bool) -> Void) {
        var finalHandler = handler
        
        if let originalHandler = self.viewDidDisappearHandler {
            finalHandler = { animated in
                originalHandler(animated)
                handler(animated)
            }
        }
        
        self.viewDidDisappearHandler = finalHandler
    }
    
    //MARK: - Objecitve-C Runtime Functions
    
    /// view will appear implement
    /// - Parameter animated: animated
    @objc private func __viewWillAppear_IMP(_ animated: Bool) {
        if let handler = self.viewWillAppearHandler {
            handler(animated)
            self.viewWillAppearHandler = nil
        }
        
        Static.originalViewWillAppear(self, #selector(viewWillAppear(_:)), animated)
    }
    
    /// view did appear imp
    /// - Parameter animated: animated
    @objc private func __viewDidAppear_IMP(_ animated: Bool) {
        if let handler = self.viewDidAppearHandler {
            handler(animated)
            self.viewDidAppearHandler = nil
        }
        
        Static.originalViewDidAppear(self, #selector(viewDidAppear(_:)), animated)
    }
    
    /// view will disappear IMP
    /// - Parameter animated: animated
    @objc private func __viewWillDisappear_IMP(_ animated: Bool) {
        if let handler = self.viewWillDisappearHandler {
            handler(animated)
            self.viewWillDisappearHandler = nil
        }
        
        Static.originalViewWillDisappear(self, #selector(viewWillDisappear(_:)), animated)
    }
    
    /// view did disappear IMP
    /// - Parameter animated: animated
    @objc private func __viewDidDisappear_IMP(_ animated: Bool) {
        if let handler = self.viewDidDisappearHandler {
            handler(animated)
            self.viewDidDisappearHandler = nil
        }
        
        Static.originalViewDidDisappear(self, #selector(viewDidDisappear(_:)), animated)
    }

}
