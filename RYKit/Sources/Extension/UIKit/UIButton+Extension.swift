//
//  UIButton+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)


public extension UIButton {
     func build(block:(UIButton)->Void)->UIButton {
        let button = UIButton(frame: .zero)
        block(button)
        return button
    }
}

//MARK: - animation for UIButton
public extension UIButton {
    
    
    //MARK: - Public Methods
    
    func setTitle(_ title: String?, for state: UIControl.State, animated: Bool) {
        if animated {
            setTitle(title, for: state)
        }
        else {
            UIView .performWithoutAnimation {
                setTitle(title, for: state)
                layoutIfNeeded()
            }
        }
    }
    
    func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State, animated: Bool) {
        if animated {
            setAttributedTitle(title, for: state)
        }
        else {
            UIView .performWithoutAnimation {
                setAttributedTitle(title, for: state)
                layoutIfNeeded()
            }
        }
    }
}

//Usage： button.flash()

// MARK: - Properties
public extension UIButton {
    func underline() {
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (self.titleLabel?.text?.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    var mc_hasText:Bool {
        guard let label = titleLabel else {
            return false
        }
        return label.mc_hasText
    }
    var mc_hasNonWhitespaceText:Bool {
        guard let label = titleLabel else {
        return false
        }
        return label.mc_hasNonWhitespaceText
    }
    var mc_hasNonWhitespaceAttributedText:Bool {
        guard let label = titleLabel else {
            return false
        }
        return label.mc_hasNonWhitespaceText
    }
    var mc_hasAttributeText:Bool {
        guard let label = titleLabel else {
            return false
        }
        return label.mc_hasText
    }
    var mc_hasAnyText:Bool {
        return mc_hasText || mc_hasAttributeText
    }
    var mc_hasAnyNonWhitespaceText:Bool {
        return mc_hasNonWhitespaceText || mc_hasNonWhitespaceAttributedText
    }
    
    ///  Image of disabled state for button; also inspectable from Storyboard.
    @IBInspectable var imageForDisabled: UIImage? {
        get {
            return image(for: .disabled)
        }
        set {
            setImage(newValue, for: .disabled)
        }
    }
    
    ///  Image of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable var imageForHighlighted: UIImage? {
        get {
            return image(for: .highlighted)
        }
        set {
            setImage(newValue, for: .highlighted)
        }
    }
    
    ///  Image of normal state for button; also inspectable from Storyboard.
    @IBInspectable var imageForNormal: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }
    
    ///  Image of selected state for button; also inspectable from Storyboard.
    @IBInspectable var imageForSelected: UIImage? {
        get {
            return image(for: .selected)
        }
        set {
            setImage(newValue, for: .selected)
        }
    }
    
    ///  Title color of disabled state for button; also inspectable from Storyboard.
    @IBInspectable var titleColorForDisabled: UIColor? {
        get {
            return titleColor(for: .disabled)
        }
        set {
            setTitleColor(newValue, for: .disabled)
        }
    }
    
    ///  Title color of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable var titleColorForHighlighted: UIColor? {
        get {
            return titleColor(for: .highlighted)
        }
        set {
            setTitleColor(newValue, for: .highlighted)
        }
    }
    
    ///  Title color of normal state for button; also inspectable from Storyboard.
    @IBInspectable var titleColorForNormal: UIColor? {
        get {
            return titleColor(for: .normal)
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }
    
    ///  Title color of selected state for button; also inspectable from Storyboard.
    @IBInspectable var titleColorForSelected: UIColor? {
        get {
            return titleColor(for: .selected)
        }
        set {
            setTitleColor(newValue, for: .selected)
        }
    }
    
    ///  Title of disabled state for button; also inspectable from Storyboard.
    @IBInspectable var titleForDisabled: String? {
        get {
            return title(for: .disabled)
        }
        set {
            setTitle(newValue, for: .disabled)
        }
    }
    
    ///  Title of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable var titleForHighlighted: String? {
        get {
            return title(for: .highlighted)
        }
        set {
            setTitle(newValue, for: .highlighted)
        }
    }
    
    ///  Title of normal state for button; also inspectable from Storyboard.
    @IBInspectable var titleForNormal: String? {
        get {
            return title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
    
    ///  Title of selected state for button; also inspectable from Storyboard.
    @IBInspectable var titleForSelected: String? {
        get {
            return title(for: .selected)
        }
        set {
            setTitle(newValue, for: .selected)
        }
    }
    
}

// MARK: - Methods
public extension UIButton {
    // 设置按钮光晕（阴影）效果
    func setShadow(color: CGColor) {
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 6, height: 6)
        self.layer.shadowColor = color
    }
    
    // 设置字体加粗
    func setTextBold() {
        self.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
    }
    
    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }
    
    ///  Set image for all states.
    ///
    /// - Parameter image: UIImage.
    func setImageForAllStates(_ image: UIImage) {
        states.forEach { self.setImage(image, for: $0) }
    }
    
    ///  Set title color for all states.
    ///
    /// - Parameter color: UIColor.
    func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { self.setTitleColor(color, for: $0) }
    }
    
    ///  Set title for all states.
    ///
    /// - Parameter title: title string.
    func setTitleForAllStates(_ title: String) {
        states.forEach { self.setTitle(title, for: $0) }
    }
    
    ///  Center align title text and image on UIButton
    ///
    /// - Parameter spacing: spacing between UIButton title text and UIButton Image.
    func centerImageAndText(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageView!.image!.size.width+insetAmount, bottom: 0, right: imageView!.image!.size.width-insetAmount)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: titleLabel!.width-insetAmount, bottom: 0, right: -titleLabel!.width+insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    func rightTextAndImage(spacing: CGFloat) {
//        imageView?.width = getWidth(15)
//        titleLabel?.frame.origin.x = self.width - imageView!.frame.width - spacing - titleLabel!.frame.width
//        imageView?.frame.origin.x = self.width - imageView!.frame.width - spacing
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageView!.width-titleLabel!.width, bottom: 0, right: -imageView!.width)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: self.width-imageView!.width, bottom: 0, right: 0)
    }
    
    static func navBackBtn(imageName:String) -> UIButton {
        // 设置返回按钮属性
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named:imageName), for: .normal)
        backBtn.titleLabel?.isHidden=true
        backBtn.contentHorizontalAlignment = .left
        backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10,bottom: 0,right: 0)
        let btnW: CGFloat = UIScreen.screenWidth > 375.0 ? 60 : 44
        backBtn.frame = CGRect(x: 0, y: 0, width: btnW, height: 40)
        return backBtn
    }
}


// timer button
extension UIButton {
    func addTimerButton(time: NSInteger,
                        btnNormalBgColor: UIColor,
                        btnNormalBorderColor: UIColor,
                        btnNormalTitle: String,
                        btnNormalTitleColor: UIColor,
                        btnSelectedBgColor: UIColor,
                        btnSelectedBorderColor: UIColor,
                        btnSelectedTitleColor: UIColor
                        ) {
        self.backgroundColor? = btnSelectedBgColor.withAlphaComponent(0.4)
        weak var weakSelf = self
        var timeOut:NSInteger = time
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        timer.schedule(wallDeadline: DispatchWallTime.now(), repeating: .seconds(1))
        timer.setEventHandler {
            if timeOut < 0{
                timer.cancel()
                DispatchQueue.main.async(execute: {
                    weakSelf?.setTitle(btnNormalTitle, for: .normal)
                    weakSelf?.setTitleColor(btnNormalTitleColor, for: .normal)
                    weakSelf?.backgroundColor = btnNormalBgColor
                    weakSelf?.borderColor = btnNormalBorderColor
                    weakSelf?.isUserInteractionEnabled = true
                })
            } else {
                let allTime = time + 1
                let seconds = timeOut % allTime
                let timeString = String(seconds)
                DispatchQueue.main.async(execute: {
                    weakSelf?.setTitle(timeString, for: .normal)
                    weakSelf?.setTitleColor(btnSelectedTitleColor, for: .normal)
                    weakSelf?.borderColor = btnSelectedBorderColor
                    weakSelf?.isUserInteractionEnabled = false
                })
                timeOut -= 1
            }
        }
        timer.resume()
    }
}
    
    
extension UIButton {
    private struct AssociatedKeys {
           static var eventInterval = "eventInterval"
           static var eventUnavailable = "eventUnavailable"
       }

            /// Time of repeated clicks Property settings
       var eventInterval: TimeInterval {
           get {
               if let interval = objc_getAssociatedObject(self, &AssociatedKeys.eventInterval) as? TimeInterval {
                   return interval
               }
               return 0.5
           }
           set {
               objc_setAssociatedObject(self, &AssociatedKeys.eventInterval, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
           }
       }

            /// button not pointable property setting
       private var eventUnavailable : Bool {
           get {
               if let unavailable = objc_getAssociatedObject(self, &AssociatedKeys.eventUnavailable) as? Bool {
                   return unavailable
               }
               return false
           }
           set {
               objc_setAssociatedObject(self, &AssociatedKeys.eventUnavailable, newValue as Bool, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
           }
       }

           
      open class func initializeMethod() {
           let selector = #selector(UIButton.sendAction(_:to:for:))
           let newSelector = #selector(ms_sendAction(_:to:for:))
           
           let method: Method = class_getInstanceMethod(UIButton.self, selector)!
           let newMethod: Method = class_getInstanceMethod(UIButton.self, newSelector)!
           
           if class_addMethod(UIButton.self, selector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)) {
               class_replaceMethod(UIButton.self, newSelector, method_getImplementation(method), method_getTypeEncoding(method))
           } else {
               method_exchangeImplementations(method, newMethod)
           }
       }

            /// In this method
       @objc private func ms_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
           if eventUnavailable == false {
               eventUnavailable = true
               ms_sendAction(action, to: target, for: event)
                            // delay
               DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + eventInterval, execute: {
                   self.eventUnavailable = false
               })
           }
       }
   }
    
private var rTouchAreaEdgeInsets: UIEdgeInsets = .zero

extension UIButton {

    var touchAreaEdgeInsets: UIEdgeInsets {
        get {
            if let value = objc_getAssociatedObject(self, &rTouchAreaEdgeInsets) as? NSValue {
                var edgeInsets: UIEdgeInsets = .zero
                value.getValue(&edgeInsets)
                return edgeInsets
            }
            else {
                return .zero
            }
        }
        set(newValue) {
            var newValueCopy = newValue
            let objCType = NSValue(uiEdgeInsets: .zero).objCType
            let value = NSValue(&newValueCopy, withObjCType: objCType)
            objc_setAssociatedObject(self, &rTouchAreaEdgeInsets, value, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if UIEdgeInsetsEqualToEdgeInsets(self.touchAreaEdgeInsets, .zero) || !self.isEnabled || self.isHidden {
            return super.point(inside: point, with: event)
        }
        let relativeFrame = self.bounds
        let hitFrame = relativeFrame.inset(by: self.touchAreaEdgeInsets)

        return hitFrame.contains(point)
    }
}
#endif
//MARK: - build custom controls and live preview the design in the interface builder

#endif

