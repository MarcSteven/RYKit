//
//  UIView+Badge.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/20.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import UIKit


public extension UIView {
    /*
     * Assign badge with only text.
     */
    
    /// - parameter text: The badge value, use nil to remove exsiting badge.
    @objc  func badge(text badgeText: String?) {
        badge(text: badgeText, appearance: BadgeAppearance())
    }
    
    /// - parameter text: The badge value, use nil to remove exsiting badge.
    /// - parameter appearance: The appearance of the badge.
     func badge(text badgeText: String?, appearance: BadgeAppearance) {
        badge(text: badgeText, badgeEdgeInsets: nil, appearance: appearance)
    }
    
    /*
     * Assign badge with text and edge insets.
     */
    
    @available(*, deprecated, message: "Use badge(text: String?, appearance:BadgeAppearance)")
    @objc  func badge(text badgeText: String?, badgeEdgeInsets: UIEdgeInsets) {
        badge(text: badgeText, badgeEdgeInsets: badgeEdgeInsets, appearance: BadgeAppearance())
    }
    
    /*
     * Assign badge with text,insets, and appearance.
     */
    func badge(text badgeText: String?, badgeEdgeInsets: UIEdgeInsets?, appearance: BadgeAppearance) {
        
        //Create badge label
        var badgeLabel: BadgeLabel!
        
        var doesBadgeExist = false
        
        //Find badge in subviews if exists
        for view in self.subviews {
            if view.tag == 1 && view is BadgeLabel {
                badgeLabel = (view as! BadgeLabel)
            }
        }
        
        //If assigned text is nil (request to remove badge) and badge label is not nil:
        if badgeText == nil && badgeLabel != nil {
            
            if appearance.animated {
                UIView.animate(withDuration: appearance.duration, animations: {
                    badgeLabel.alpha = 0.0
                    badgeLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    
                }, completion: { (_) in
                    
                    badgeLabel.removeFromSuperview()
                })
            } else {
                badgeLabel.removeFromSuperview()
            }
            return
        } else if badgeText == nil && badgeLabel == nil {
            return
        }
        
        //Badge label is nil (There was no previous badge)
        if (badgeLabel == nil) {
            
            //init badge label variable
            badgeLabel = BadgeLabel()
            
            //assign tag to badge label
            badgeLabel.tag = 1
        } else {
            doesBadgeExist = true
        }
        
        let oldWidth: CGFloat?
        if doesBadgeExist {
            oldWidth = badgeLabel.frame.width
        }else{
            oldWidth = nil
        }
        
        /// Set the text on the badge label
        badgeLabel.text = badgeText
        
        /// Set font size
        badgeLabel.font = UIFont.systemFont(ofSize: appearance.textSize)
        
        badgeLabel.sizeToFit()
        
        /// set the allignment
        badgeLabel.textAlignment = appearance.textAlignment
        
        /// set background color
        badgeLabel.layer.backgroundColor = appearance.backgroundColor.cgColor
        
        /// set text color
        badgeLabel.textColor = appearance.textColor
        
        /// get current badge size
        let badgeSize = badgeLabel.frame.size
        
        /// calculate width and height with minimum height and width of 20
        let height = max(18, Double(badgeSize.height) + 5.0)
        let width = max(height, Double(badgeSize.width) + 10.0)
        
        badgeLabel.frame.size = CGSize(width: width, height: height)
        
        /// add to subview
        if doesBadgeExist {
            //remove view to delete constraints
            badgeLabel.removeFromSuperview()
        }
        self.addSubview(badgeLabel)
        
        /// The distance from the center of the view (vertically)
        let centerY = appearance.distanceFromCenterY == 0 ? -(bounds.size.height / 2) : appearance.distanceFromCenterY
        
        /// The distance from the center of the view (horizontally)
        let centerX = appearance.distanceFromCenterX == 0 ? (bounds.size.width / 2) : appearance.distanceFromCenterX
        
        /// disable auto resizing mask
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        /// add height constraint
        self.addConstraint(NSLayoutConstraint(item: badgeLabel as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: CGFloat(height)))
        
        /// add width constraint
        self.addConstraint(NSLayoutConstraint(item: badgeLabel as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: CGFloat(width)))
        
        /// add vertical constraint
        self.addConstraint(NSLayoutConstraint(item: badgeLabel as Any, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: centerX))
        
        /// add horizontal constraint
        self.addConstraint(NSLayoutConstraint(item: badgeLabel as Any, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: centerY))
        
        badgeLabel.layer.borderColor = appearance.borderColor.cgColor
        badgeLabel.layer.borderWidth = appearance.borderWidth
        
        /// corner radius
        badgeLabel.layer.cornerRadius = badgeLabel.frame.size.height / 2
        
        /// setup shadow
        if appearance.allowShadow {
            badgeLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
            badgeLabel.layer.shadowRadius = 1
            badgeLabel.layer.shadowOpacity = 0.5
            badgeLabel.layer.shadowColor = UIColor.black.cgColor
        }
        
        /// badge does not exist, meaning we are adding a new one
        if !doesBadgeExist {
            //should it animate?
            if appearance.animated {
                badgeLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
                UIView.animate(withDuration: appearance.duration,
                               delay: 0,
                               usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 0.5,
                               options: [],
                               animations: {
                                badgeLabel.transform = .identity
                },
                               completion: nil)
            }
        }else{
            if appearance.animated, let oldWidth = oldWidth {
                let currentWidth = badgeLabel.frame.width
                badgeLabel.frame.size.width = oldWidth
                UIView.animate(withDuration: appearance.duration){
                    badgeLabel.frame.size.width = currentWidth
                }
            }
        }
    }
    
}
