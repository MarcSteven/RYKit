//
//  CGRect+Helper.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/6.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit
//MARK: - properties 
public extension CGRect {
    
    /// x
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self = CGRect(x: newValue, y: self.y, width: self.width, height: self.height)
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
            self = CGRect(x: self.x, y: newValue, width: self.width, height: self.height)
        }
    }
    
    
    /// width
    var width: CGFloat {
        get {
            return self.size.width
        }
        set {
            self = CGRect(x: self.x, y: self.y, width: newValue, height: self.height)
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return self.size.height
        }
        set {
            self = CGRect(x: self.x, y: self.y, width: self.width, height: newValue)
        }
    }
    
    
    /// top
    var top: CGFloat {
        get {
            return self.origin.y
        }
        set {
            y = newValue
        }
    }
    
    /// bottom
    var bottom: CGFloat {
        get {
            return self.origin.y + self.size.height
        }
        set {
            self = CGRect(x: x, y: newValue - height, width: width, height: height)
        }
    }
    
    /// left
    var left: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self.x = newValue
        }
    }
    
    /// right
    var right: CGFloat {
        get {
            return x + width
        }
        set {
            self = CGRect(x: newValue - width, y: y, width: width, height: height)
        }
    }
    
    
    /// midX
    var midX: CGFloat {
        get {
            return self.x + self.width / 2
        }
        set {
            self = CGRect(x: newValue - width / 2, y: y, width: width, height: height)
        }
    }
    
    /// midY
    var midY: CGFloat {
        get {
            return self.y + self.height / 2
        }
        set {
            self = CGRect(x: x, y: newValue - height / 2, width: width, height: height)
        }
    }
    
    
    /// center
    var center: CGPoint {
        get {
            return CGPoint(x: self.midX, y: self.midY)
        }
        set {
            self = CGRect(x: newValue.x - width / 2, y: newValue.y - height / 2, width: width, height: height)
        }
    }
    
    /// halve rect
    /// - Returns: return CGRect
    func halveRect()->CGRect {
        return CGRect(x: self.x/2, y: self.y/2, width: self.width/2, height: self.height/2)
    }
    
    /// rect reduce
    /// - Parameter maigin: maigin
    /// - Returns: cgrect
    func rectReduce(maigin: CGFloat)->CGRect {
        return CGRect(x: self.x+maigin, y: self.y+maigin, width: self.width-maigin*2, height: self.height-maigin*2)
    }
    
    /// rect increase
    /// - Parameter maigin: maigin
    /// - Returns: cgrect
    func rectIncrease(maigin: CGFloat)->CGRect {
        return CGRect(x: self.x-maigin, y: self.y-maigin, width: self.width+maigin*2, height: self.height+maigin*2)
    }
}

