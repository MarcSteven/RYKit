//
//  UINavigationBar+HideHairLine.swift
//  MemoryChainExtensionService
//
//  Created by Marc Zhao on 2018/9/12.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


public extension UINavigationBar {
    
    /// hide bottom hair line
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView?.isHidden = true
    }
    
    /// show bottom hair line
    func showBottomHairLine() {
        
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView?.isHidden = false 
    }
    
    /// change bottom hair image 
    func changeBottomHairImage() {}
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if let view = view as? UIImageView, view.bounds.height <= 1.0 {
            return view
        }
        
        for subview in view.subviews {
            if let imageView = hairlineImageViewInNavigationBar(view: subview) {
                return imageView
            }
        }
        
        return nil
    }
}




public extension UINavigationBar {
    
    /// should remove shadow
    /// - Parameter value: value
    func shouldRemoveShadow(_ value: Bool)  {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
    
    /// configure background color
    /// - Parameter hexColor: hex color
    func configureBackgroundColor(_ hexColor:String) {
        self.backgroundColor = UIColor(hexString: hexColor)
    }
}
