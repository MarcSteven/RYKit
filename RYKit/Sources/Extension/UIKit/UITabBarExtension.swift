//
//  UITabBarExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit


extension UITabBar {
    
    /// AssociatedKey
    private struct AssociatedKey {
        static var isTransparent = "isTransparent"
        static var borderWidth = "borderWidth"
    }
    
    /// isTransparent
    open var isTransparent:Bool {
        get {
            objc_getAssociatedObject(self, &AssociatedKey.isTransparent) as! Bool
            
        }
        set {
            guard newValue != isTransparent  else {
                return
            }
            objc_setAssociatedObject(self, &AssociatedKey.isTransparent, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            
            guard newValue else {
                backgroundImage = nil
                return
            }
            backgroundImage = UIImage()
            shadowImage = UIImage()
            isTranslucent = true
            backgroundColor = .clear
    }
        
}
    
    /// is border hidden
    open var isBorderHidden:Bool {
        get {
            return value(forKey: "_hidesShadow") as? Bool ?? false
        }
        set {
            setValue(newValue, forKey: "_hidesShadow")
        }
        
    }
    
    /// border width
    @objc dynamic open override var borderWidth: CGFloat {
        get {
            objc_getAssociatedObject(self, &AssociatedKey.borderWidth) as! CGFloat
            
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.borderWidth, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            
            
        }
    }
        private var topBorderView:UIView {
        let tag = "topBorderView".hashValue
        if let view = viewWithTag(tag) {
            return view
        }
        setBorder(color: borderColor ?? .clear, thickness: borderWidth)
        return viewWithTag(tag)!
    }
    
    /// set border
    /// - Parameters:
    ///   - color: color
    ///   - thickness: thickness
    private func setBorder(color:UIColor,
                           thickness:CGFloat = 1) {
        clipsToBounds = true
        
    }
    }
