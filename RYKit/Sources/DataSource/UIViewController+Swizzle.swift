//  YouthBomb
//
//  Created by Marc Steven on 2020/5/31.
//  Copyright © 2020 www.richandyoung.cn. All rights reserved.
//
import UIKit

/// 交换方法
/// - Parameter vc: 视图控制器的类型
public  func swizzle(_ vc: UIViewController.Type) {
    
    [
        (#selector(vc.viewDidLoad), #selector(vc.ry_viewDidLoad)),
        (#selector(vc.viewWillAppear(_:)), #selector(vc.ry_viewWillAppear(_:))),
        (#selector(vc.traitCollectionDidChange(_:)), #selector(vc.ry_traitCollectionDidChange(_:))),
        ].forEach { original, swizzled in
            
            guard let originalMethod = class_getInstanceMethod(vc, original),
                let swizzledMethod = class_getInstanceMethod(vc, swizzled) else { return }
            
            let didAddViewDidLoadMethod = class_addMethod(vc,
                                                          original,
                                                          method_getImplementation(swizzledMethod),
                                                          method_getTypeEncoding(swizzledMethod))
            
            if didAddViewDidLoadMethod {
                class_replaceMethod(vc,
                                    swizzled,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
    }
}

private var hasSwizzled = false

public extension UIViewController {
    class func doBadSwizzleStuff() {
        guard !hasSwizzled else { return }
        
        hasSwizzled = true
        swizzle(self)
    }
    
    @objc internal func ry_viewDidLoad() {
        self.ry_viewDidLoad()
        self.bindViewModel()
    }
    
    @objc internal func ry_viewWillAppear(_ animated: Bool) {
        self.ry_viewWillAppear(animated)
        
        if !self.hasViewAppeared {
            self.bindStyles()
            self.hasViewAppeared = true
        }
    }
    
    /**
     The entry point to bind all view model outputs. Called just before `viewDidLoad`.
     */
    @objc func bindViewModel() {
    }
    
    /**
     The entry point to bind all styles to UI elements. Called just after `viewDidLoad`.
     */
    @objc  func bindStyles() {
    }
    
    @objc  func ry_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.ry_traitCollectionDidChange(previousTraitCollection)
        self.bindStyles()
    }
    
    private struct AssociatedKeys {
        static var hasViewAppeared = "hasViewAppeared"
    }
    
    // Helper to figure out if the `viewWillAppear` has been called yet
    private var hasViewAppeared: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.hasViewAppeared) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.hasViewAppeared,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
