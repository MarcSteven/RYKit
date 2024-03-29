//
//  UITableViewCell+Animation.swift
//  YouthBomb
//
//  Created by Marc Steven on 2020/5/28.
//  Copyright © 2020 www.richandyoung.cn. All rights reserved.
//

import UIKit




/// animation type
enum AnimationType {
    
    case translation
    case scale
    case rotation
    case scaleAlways
    case scaleNormal
}
 
extension UITableViewCell{
    
    /// add animation
    /// - Parameter animationType: animation type
    func addAnimation(animationType : AnimationType)  {
        switch animationType {
        case .translation:
            
            layer.removeAnimation(forKey: "translation")
                
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.values = [50 , 0 , 50 , 0];
            animation.duration = 0.7
            animation.repeatCount = 1
            layer.add(animation, forKey: "translation")
        
        case .scale:
            
            layer.removeAnimation(forKey: "scale")
            let animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
            animation.values = [0.5, 1.0 ];
            animation.duration = 0.7
            animation.repeatCount = 1
            animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)];
            
            layer.add(animation, forKey: "scale")
 
        case .rotation:
        
            layer.removeAnimation(forKey: "rotation")
        
            let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            animation.values = [-1 / 6 * Double.pi , 0 , 1 / 6 * Double.pi , 0];
            animation.duration = 0.7
            animation.repeatCount = 1
            layer.add(animation, forKey: "rotation")
            
        case .scaleAlways :
            layer.removeAnimation(forKey: "scale")
            let animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
            animation.values = [1.0, 1.2 ];
            animation.duration = 0.7
            animation.repeatCount = 1
            animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)];
            animation.isRemovedOnCompletion = false
            animation.fillMode = CAMediaTimingFillMode.forwards;
            layer.add(animation, forKey: "scale")
            
        case .scaleNormal:
           
            let animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
            animation.autoreverses = true
            animation.duration = 0.7
            animation.repeatCount = 1
            animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)];
            
            layer.add(animation, forKey: "scale")
        
        }
    }
 
}

