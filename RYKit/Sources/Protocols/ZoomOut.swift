//
//  ZoomOut.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/13.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit


/// 拉远协议
public protocol ZoomOut {}

///  UIView 拉远协议
extension ZoomOut where Self:UIView {
    /// Simply zooming out of a view: set view scale to Identity and zoom out to 0 on 'duration' time interval.
    /// - Parameter duration: animation duration
     func zoomOut(duration: TimeInterval = 0.2) {
     self.transform = CGAffineTransform.identity
     UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
         self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            }) { (animationCompleted: Bool) -> Void in
        }
    }

    /// Zoom out any view with specified offset magnification.
    /// - Parameters:
    ///   - duration: animation duration
    ///   - easingOffset: easing offset
    func zoomOutWithEasing( duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
     UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
         self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
            }, completion: { (completed: Bool) -> Void in
             UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                 self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                    }, completion: { (completed: Bool) -> Void in
                })
        })
    }

}
