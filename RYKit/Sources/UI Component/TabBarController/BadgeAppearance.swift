//
//  BadgeAppearance.swift
//  NiceMind
//
//  Created by Marc Zhao on 2018/1/15.
//  Copyright © 2018年 Knightsmind techonology co,LTD. All rights reserved.
//

import Foundation

import UIKit





/// BadgeLabel - This class is made to avoid confusion with other subviews that might be of type UILabel.
@objc class BadgeLabel: UILabel {}



/// BadgeAppearance - This struct is used to design the badge.
public struct BadgeAppearance {
    
    /// text size
    public var textSize: CGFloat
    
    /// text alignment
    public var textAlignment: NSTextAlignment
    
    /// border color
    public var borderColor: UIColor
    
    /// border width
    public var borderWidth: CGFloat
    
    /// allow shadow
    public var allowShadow: Bool
    
    /// background color
    public var backgroundColor: UIColor
    
    /// text color
    public var textColor: UIColor
    
    /// is animated
    public var animated: Bool
    
    /// duration
    public var duration: TimeInterval
    
    /// distance from centerY
    public var distanceFromCenterY: CGFloat
    
    /// distance from CenterX
    public var distanceFromCenterX: CGFloat
    
    /// init
    public init() {
        textSize = 12
        textAlignment = .center
        backgroundColor = .red
        textColor = .white
        animated = true
        duration = 0.2
        borderColor = .clear
        borderWidth = 0
        allowShadow = false
        distanceFromCenterY = 0
        distanceFromCenterX = 0
    }
    
}
