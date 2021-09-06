//
//  UINavigationBar+Style.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/14.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    /// apply style
    /// - Parameter style: style
    func apply(_ style:Stylable) {
        applyColors(barColor:style.barColor , barTintColor: style.tintColor)
    }
    
    /// apply color
    /// - Parameters:
    ///   - barColor: bar color
    ///   - barTintColor: bar tint color
    func applyColors(barColor:UIColor?,
                     barTintColor:UIColor) {
        self.isTranslucent = false
        self.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:barTintColor
        ]
        self.tintColor = barTintColor
        self.barTintColor = barTintColor
        guard #available(iOS 11.0, *) else {return }
            self.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor:barTintColor
            ]
        
    }
}
