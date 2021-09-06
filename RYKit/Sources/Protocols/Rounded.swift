//
//  Rounded.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/20.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import Foundation
import UIKit

/// Rounded protocol
public protocol Rounded {
    
    /// corner radius
    var cornerRadius:CGFloat {get set}
    
    /// border width
    var borderWidth:CGFloat {get set}
    
    /// border color
    var borderColor:UIColor? {get set}
    
    func addDefaultRounded()
}
extension Rounded where Self:UIView {
    var cornerRadius:CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
    var borderWidth:CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
        
    }
    var borderColor:UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
            
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    /// add default rounded
    public func addDefaultRounded() {
        layer.masksToBounds = true
        layer.cornerRadius = 15.0
        layer.borderColor = nil
        layer.borderWidth = 0
    }
}
extension UIButton: Rounded {}
extension UIImageView:Rounded {}


/**
 Usage as below:
 button.addDefaultRounded()
 */



