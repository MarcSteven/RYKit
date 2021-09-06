//
//  UIViewController+FloatingButton.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/19.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import UIKit

public extension UIViewController {
    private struct AssociatedKeys {
        static var floatingButton:UIButton?
    }
    /// floating button
    var floatingButton:UIButton? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.floatingButton) as? UIButton else {
                return  nil
            }
            return value
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.floatingButton, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    //Add floating button
    func addFloatingButton(_ usingImage:UIImage) {
            // Customize your own floating button UI
            let button = UIButton(type: .custom)
            let image = usingImage.withRenderingMode(.alwaysTemplate)
            button.tintColor = .white
            button.setImage(image, for: .normal)
           
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowRadius = 3
            button.layer.shadowOpacity = 0.12
            button.layer.shadowOffset = CGSize(width: 0, height: 1)
            button.sizeToFit()
            let buttonSize = CGSize(width: 64, height: 56)
            let rect = UIScreen.main.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2)
            button.frame = CGRect(origin: CGPoint(x: rect.maxX - 15, y: rect.maxY - 50), size: CGSize(width: 60, height: 60))
            // button.cornerRadius = 30 -> Will destroy your shadows, however you can still find workarounds for rounded shadow.
            button.autoresizingMask = []
            view.addSubview(button)
            floatingButton = button
            let panner = UIPanGestureRecognizer(target: self, action: #selector(panDidFire(panGesture:)))
            floatingButton?.addGestureRecognizer(panner)
            snapButtonToSocket()
        }
    
    /// pangestrure did fire
    /// - Parameter panner: panGestureRecognizer
        @objc fileprivate func panDidFire(panGesture: UIPanGestureRecognizer) {
            guard let floatingButton = floatingButton else {return}
            let offset = panGesture.translation(in: view)
            panGesture.setTranslation(CGPoint.zero, in: view)
            var center = floatingButton.center
            center.x += offset.x
            center.y += offset.y
            floatingButton.center = center

            if panGesture.state == .ended || panGesture.state == .cancelled {
                UIView.animate(withDuration: 0.3) {
                    self.snapButtonToSocket()
                }
            }
        }
    /// snap button to socket
        fileprivate func snapButtonToSocket() {
            guard let floatingButton = floatingButton else {return}
            var bestSocket = CGPoint.zero
            var distanceToBestSocket = CGFloat.infinity
            let center = floatingButton.center
            for socket in sockets {
                let distance = hypot(center.x - socket.x, center.y - socket.y)
                if distance < distanceToBestSocket {
                    distanceToBestSocket = distance
                    bestSocket = socket
                }
            }
            floatingButton.center = bestSocket
        }
    
    /// sockets
        fileprivate var sockets: [CGPoint] {
            let buttonSize = floatingButton?.bounds.size ?? CGSize(width: 0, height: 0)
            let rect = view.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2)
            let sockets: [CGPoint] = [
                CGPoint(x: rect.minX + 15, y: rect.minY + 30),
                CGPoint(x: rect.minX + 15, y: rect.maxY - 50),
                CGPoint(x: rect.maxX - 15, y: rect.minY + 30),
                CGPoint(x: rect.maxX - 15, y: rect.maxY - 50)
            ]
            return sockets
        }
        // Custom socket position to hold Y position and snap to horizontal edges.
        // You can snap to any coordinate on screen by setting custom socket positions.
        fileprivate var horizontalSockets: [CGPoint] {
            guard let floatingButton = floatingButton else {return []}
            let buttonSize = floatingButton.bounds.size
            let rect = view.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2)
            let y = min(rect.maxY - 50, max(rect.minY + 30, floatingButton.frame.minY + buttonSize.height / 2))
            let sockets: [CGPoint] = [
                CGPoint(x: rect.minX + 15, y: y),
                CGPoint(x: rect.maxX - 15, y: y)
            ]
            return sockets
        }
    }

//MARK: - usage
/** in viewdid load
 
 addFloatBUTTON
 */
