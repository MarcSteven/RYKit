//
//  TabBarButton.swift
//  NiceMind
//
//  Created by Marc Zhao on 2018/1/12.
//  Copyright © 2018年 Knightsmind techonology co,LTD. All rights reserved.
//


import Foundation
import UIKit


/// TabBar button 
public class TabBarButton: UIButton{
    
    /// long click timer
    var longClickTimer: Timer?
    
    /// delegate
    open weak var delegate:TabBarButtonDelegate!
    
    /// is allowed to animation to interact
    open var shouldAnimateInteraction:Bool {
        get{
            return delegate.shouldAnimate(self)
        }
    }
    
    /// the duration of starting animation
    open var beginAnimationDuration: TimeInterval{
        get{
            return delegate.beginAnimationDuration(self)
        }
    }
    
    ///  the duration to end animation
    open var endAnimationDuration: TimeInterval{
        get{
            return delegate.endAnimationDuration(self)
        }
    }
    
    /// initial spring velocity
    open var initialSpringVelocity: CGFloat{
        get{
            return delegate.initialSpringVelocity(self)
        }
    }
    
    /// using spring with damping
    open var usingSpringWithDamping: CGFloat{
        get{
            return delegate.usingSpringWithDamping(self)
        }
    }
    
    /// long click trigger duration
    open var longClickTriggerDuration: TimeInterval{
        get{
            return delegate.longClickTriggerDuration(self)
        }
    }
    
    /// is long click enable
    open var isLongClickEnabled: Bool{
        get{
            return delegate.shouldLongClick(self)
        }
    }
    
    /// long click performed
    @objc func longClickPerformed(){
        if isLongClickEnabled{
            self.touchesCancelled(Set<UITouch>(), with: nil)
            self.delegate.longClickAction(self)
        }
    }
    
    /// title rect
    /// - Parameter contentRect: content rect
    /// - Returns: return CGRect
    override public func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let original = super.titleRect(forContentRect: contentRect)
        let image: CGFloat = self.imageRect(forContentRect: contentRect).minY / 2.0
        return CGRect(x: 0, y: contentRect.height - original.height - image, width: contentRect.width , height: original.height)
    }
    
    /// image rect
    /// - Parameter contentRect: content rect
    /// - Returns: return CGRect
    override public func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let labelHeight = super.titleRect(forContentRect: contentRect).height
        let original = super.imageRect(forContentRect: contentRect)
        let height = original.height
        
        let y = labelHeight > 0 ? (contentRect.height - labelHeight)/2.0 - height/2.0 : contentRect.height/2.0 - height/2.0
        
        return CGRect(x: contentRect.width/2.0 - height/2.0, y: y, width: height, height: height)
    }
    
    var didAddBadge = false
    
    /// add badge
    /// - Parameters:
    ///   - text: text
    ///   - appearance: Appearance of badge
    func addBadge(text: String?, appearance: BadgeAppearance){
        didAddBadge = true
        badge(text: text, appearance: appearance)
    }
    
    
    override public func layoutSubviews() {
        
        if didAddBadge{
            super.layoutSubviews()
            didAddBadge = false
            return
        }
        
        let animate = delegate.shouldAnimate(self)
        
        if let titleLabel = titleLabel{
            titleLabel.frame = self.titleRect(forContentRect: self.frame)
        }
        
        self.imageView?.frame = self.imageRect(forContentRect: self.frame)
        
        if animate {
            super.layoutSubviews()
        }else{
            UIView.animate(withDuration: 0.1) {
                
                super.layoutSubviews()
            }
        }
        
    }
    
    
    /// init
    /// - Parameter frame: frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        centerTitleLabel()
    }
    
    /// init
    /// - Parameter aDecoder: aDecoder
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        centerTitleLabel()
    }
    
    /// title label to the center
    private func centerTitleLabel() {
        self.titleLabel?.textAlignment = .center
    }
}

extension TabBarButton {
   
    /// touch began
    /// - Parameters:
    ///   - touches: touches
    ///   - event: UIEvent
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        longClickTimer = Timer.scheduledTimer(timeInterval: self.longClickTriggerDuration,
                                              target: self,
                                              selector: #selector(longClickPerformed),
                                              userInfo: nil, repeats: false)
        if self.shouldAnimateInteraction{
            UIView.animate(withDuration: self.beginAnimationDuration, animations: {
                self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }) { (complete) in
            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    /// touch moved
    /// - Parameters:
    ///   - touches: touches
    ///   - event: uievent
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tap:UITouch = touches.first!
        let point = tap.location(in: self)
        //longClickTimer?.invalidate()
        if !self.bounds.contains(point){
            if self.shouldAnimateInteraction{
                UIView.animate(withDuration: self.beginAnimationDuration, animations: {
                    self.transform = .identity
                }) { (complete) in
                }
            }
        }else{
            if self.shouldAnimateInteraction{
                UIView.animate(withDuration: self.beginAnimationDuration, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }) { (complete) in
                }
            }
        }
        
        
        super.touchesMoved(touches, with: event)
        
    }
    
    /// touch ended
    /// - Parameters:
    ///   - touches: touch
    ///   - event: uievent
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let tap:UITouch = touches.first!
        //let point = tap.location(in: self)
        longClickTimer?.invalidate()
        if self.shouldAnimateInteraction{
            UIView.animate(withDuration: self.endAnimationDuration,
                           delay: 0,
                           usingSpringWithDamping: self.usingSpringWithDamping,
                           initialSpringVelocity: self.initialSpringVelocity,
                           options: .allowUserInteraction,
                           animations: {
                            self.transform = .identity
            },
                           completion: nil)
        }
        super.touchesEnded(touches, with: event)
        
    }
    
    /// touch cancel
    /// - Parameters:
    ///   - touches: touches
    ///   - event: uievent
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        longClickTimer?.invalidate()
        if self.shouldAnimateInteraction{
            UIView.animate(withDuration: self.endAnimationDuration,
                           delay: 0,
                           usingSpringWithDamping: self.usingSpringWithDamping,
                           initialSpringVelocity: self.initialSpringVelocity,
                           options: .allowUserInteraction,
                           animations: {
                            self.transform = .identity
            },
                           completion: nil)
        }
        super.touchesCancelled(touches, with: event)
    }
    
    /// custom image for tabBar
    /// - Parameters:
    ///   - image: image
    ///   - highlightImage: highlighted image
    ///   - selectedColor: selected color
    ///   - highlighted: highlighted
    ///   - defaultColor: default color
    ///   - highlightColor: hightlight color
    ///   - ignoreColor: ignore color
    func customizeForTabBarWithImage(_ image: UIImage,
                                     highlightImage: UIImage? = nil,
                                     selectedColor: UIColor,
                                     highlighted: Bool,
                                     defaultColor: UIColor = UIColor.gray,
                                     highlightColor: UIColor = UIColor.white,
                                     ignoreColor: Bool = false) {
        if highlighted {
            self.customizeAsHighlighted(image: image, selectedColor: selectedColor, highlightedColor: highlightColor,ignoreColor: ignoreColor)
        }
        else {
            self.customizeAsNormal(image: image,highlightImage: highlightImage, selectedColor: selectedColor,defaultColor: defaultColor, ignoreColor: ignoreColor)
        }
    }
   
    
    /// custom highlightd
    /// - Parameters:
    ///   - image: image
    ///   - selectedColor: selected color
    ///   - highlightedColor: hightlighted color
    ///   - ignoreColor: ignore color
    private func customizeAsHighlighted(image: UIImage,selectedColor: UIColor,highlightedColor: UIColor,ignoreColor: Bool = false) {
        // We want the image to be always white in highlighted state.
        self.tintColor = highlightedColor
        self.setImage(ignoreColor ? image : image.withRenderingMode(.alwaysTemplate), for: .normal)
        // And its background color should always be the selected color.
        self.backgroundColor = selectedColor
    }
    
    /// custom normal
    /// - Parameters:
    ///   - image: image
    ///   - highlightImage: highlighted iamge
    ///   - selectedColor: selected color
    ///   - defaultColor: default color
    ///   - ignoreColor: ignore color
    private func customizeAsNormal(image: UIImage,highlightImage: UIImage? = nil,selectedColor: UIColor,defaultColor: UIColor = UIColor.gray,ignoreColor: Bool = false) {
        
        self.tintColor = selectedColor
        
        self.setImage(ignoreColor ? image : image.imageWithColor(color: defaultColor), for: [])
        self.setImage(ignoreColor ? image : image.imageWithColor(color: defaultColor), for: .highlighted)
        if let hImage = highlightImage {
            self.setImage(ignoreColor ? hImage : hImage.imageWithColor(color: selectedColor), for: .selected)
            self.setImage(ignoreColor ? hImage : hImage.imageWithColor(color: selectedColor), for: [.selected, .highlighted])
        }else{
            self.setImage(ignoreColor ? image : image.imageWithColor(color: selectedColor), for: .selected)
            self.setImage(ignoreColor ? image : image.imageWithColor(color: selectedColor), for: [.selected, .highlighted])
        }
        
        
        // We don't want a background color to use the one in the tab bar.
        self.backgroundColor = UIColor.clear
    }
    
    
    
}

//MARK: - image With Color
fileprivate extension UIImage {
    
    /// image with color
    /// - Parameter color: color
    /// - Returns: return image
    func imageWithColor(color: UIColor) -> UIImage? {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
