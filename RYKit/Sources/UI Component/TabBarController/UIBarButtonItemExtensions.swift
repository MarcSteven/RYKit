//
//  UIBarButtonItemExtension.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/20.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import UIKit


public extension UIBarButtonItem {
    
    
    /// Assign badge with only text.
    /// - Parameter text: text
    @objc  func badge(text: String?) {
        badge(text: text, appearance: BadgeAppearance())
    }
    
    /// badge
    /// - Parameters:
    ///   - badgeText: badge text
    ///   - appearance: appearance of badge
     func badge(text badgeText: String?, appearance: BadgeAppearance = BadgeAppearance()) {
        if let view = badgeViewHolder {
            getView(in: view).badge(text: badgeText, appearance: appearance)
        } else {
            NSLog("Attempted setting badge with value '\(badgeText ?? "nil")' on a nil UIBarButtonItem view.")
        }
    }
    
    /// badge view holder
    private var badgeViewHolder: UIView? {
        return value(forKey: "view") as? UIView
    }
    
    /// get view
    /// - Parameter holder: holder of view
    /// - Returns: return uiview
    private func getView(in holder: UIView)->UIView{
        for sub in holder.subviews {
            if "\(type(of: sub))" == "_UIModernBarButton" {
                return sub
            }
        }
        return holder
    }
    
    
}
