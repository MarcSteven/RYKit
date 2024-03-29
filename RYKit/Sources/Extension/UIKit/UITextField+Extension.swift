//
//  UITextField+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Enums
public extension UITextField {
    /// - set up input view dataPicker
    func setupInputViewDataPicker(target:Any,selector:Selector) {
        
        let screenWidth = UIScreen.main.bounds.width
        let dataPicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        dataPicker.datePickerMode = .date
        self.inputView = dataPicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancle = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancle,flexible,done], animated: false)
    }
    
    /// tap cancel
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    /// Shake
    func shake(_ duration:TimeInterval,repeatCount:Float) {
        let animation = CABasicAnimation(keyPath: "postion")
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        animation.fromValue = CGPoint(self.center.x - 4.0, self.center.y)
        animation.toValue = CGPoint(self.center.x + 4.0, self.center.y)
        layer.add(animation, forKey: "position")
    }
    
     
    /// add bottomLine
    func addBottomLine(_ lineWidth:CGFloat,lineColor:UIColor) {
        let border = CALayer()
     
        border.borderColor = lineColor.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0, y: self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = lineWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    /// toggle password visibility
    func togglePasswordVisibility() {
        isSecureTextEntry = !isSecureTextEntry
        if let existingText = text,
            isSecureTextEntry{
            deleteBackward()
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
        }
        if let existingSelectedTextRange = selectedTextRange {
            selectedTextRange = nil
            selectedTextRange = existingSelectedTextRange
        }
    }
    /// - chose the keyboard type
    func chooseKeyboardType(_ keyboardType:UIKeyboardType) {
        switch keyboardType {
        case .emailAddress:
            self.keyboardType = .emailAddress
        case .twitter:
            self.keyboardType = .twitter
        case .numberPad:
            self.keyboardType = .numberPad
        case .numbersAndPunctuation:
            self.keyboardType = .numbersAndPunctuation
        case .asciiCapable:
            self.keyboardType = .asciiCapable
        case .URL:
            self.keyboardType = .URL
        case .decimalPad:
            self.keyboardType = .decimalPad
        case .namePhonePad:
            self.keyboardType = .namePhonePad
        
            
        default:
            self.keyboardType = .default
        }
    }
    
    /// has text
    var mc_hasText:Bool {
        guard let text = text else{
            return false
        }
        return text.mc_hasText
    }
    /// -是否有非空的文本
    var mc_hasNonWhiteSpaceText:Bool {
        guard let text = text else {
            return false
        }
        return text.mc_hasNonWhitespaceText
    }
    
    /// has non white space attributed text
    var mc_hasNonWhitespaceAttributedText:Bool {
        guard let attributedText = attributedText else {
            return false
        }
        return attributedText.mc_hasNonWhitespaceText
    }
    
    /// has attributed text
    var mc_hasAttributedText:Bool {
        guard let attributedText = attributedText else {
            return false
        }
        return attributedText.mc_hasText
    }
    
    /// has any text
    var nc_hasAnyText:Bool {
        return mc_hasNonWhiteSpaceText || mc_hasAttributedText
    }
    ///  UITextField text type.
    ///
    /// - emailAddress: UITextField is used to enter email addresses.
    /// - password: UITextField is used to enter passwords.
    /// - generic: UITextField is used to enter generic text.
    enum TextType {
        case emailAddress
        case password
        case generic
    }
    
}

//MARK: - configure leftView 
public extension UITextField {
    
    /// configure left view
    /// - Parameters:
    ///   - imageName: imagename
    ///   - textField: textField
     func configureLeftViewForTextFiled(_ imageName:String,withTextField textField:UITextField) {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.image!.size.width + 20, height: (imageView.image?.size.height)!)
        textField.leftViewMode = .always
        textField.leftView = imageView
        
    }
    
    /// configure keyboard type
    /// - Parameters:
    ///   - textField: textField
    ///   - keyboardType: keyboard type
    func configureKeybordTypeForTextFiled(textField:UITextField,withKeyboardType keyboardType:UIKeyboardType) {
        textField.keyboardType = keyboardType
    }
}
//MARK: - make UITextField can support paster
extension UITextField {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        guard inputView != nil else { return super.canPerformAction(action, withSender: sender) }

        return action == #selector(UIResponderStandardEditActions.paste(_:)) ?
            false : super.canPerformAction(action, withSender: sender)
    }
}

// MARK: - Properties
public extension UITextField {
    
    ///  Set textField for common text types.
    var textType: TextType {
        get {
            if keyboardType == .emailAddress {
                return .emailAddress
            } else if isSecureTextEntry {
                return .password
            }
            return .generic
        }
        set {
            switch newValue {
            case .emailAddress:
                keyboardType = .emailAddress
                autocorrectionType = .no
                autocapitalizationType = .none
                isSecureTextEntry = false
                placeholder = "emailAddress".localized
                
            case .password:
                keyboardType = .asciiCapable
                autocorrectionType = .no
                autocapitalizationType = .none
                isSecureTextEntry = true
                placeholder = "password".localized
                
            case .generic:
                isSecureTextEntry = false
            }
        }
    }
    
    ///  Check if text field is empty.
    var isEmpty: Bool {
        return text?.isEmpty == true
    }
    
    ///  Return text with no spaces or new lines in beginning and end.
    var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    ///  Check if textFields text is a valid email format.
    ///
    ///        textField.text = "john@doe.com"
    ///        textField.hasValidEmail -> true
    ///
    ///        textField.text = "swifterswift"
    ///        textField.hasValidEmail -> false
    ///
     var hasValidEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }
    
    ///  Left view tint color.
    @IBInspectable  var leftViewTintColor: UIColor? {
        get {
            guard let iconView = leftView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = leftView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
    
    ///  Right view tint color.
    @IBInspectable  var rightViewTintColor: UIColor? {
        get {
            guard let iconView = rightView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = rightView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
    
}

// MARK: - Methods
public extension UITextField {
    
    ///  Clear text.
     func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    
    ///  Set placeholder text color.
    ///
    /// - Parameter color: placeholder text color.
     func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else { return }
        //字体颜色
        self.attributedPlaceholder = NSAttributedString.init(string:holder, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize:20), NSAttributedString.Key.foregroundColor:color])
    }
    
    ///  Add padding to the left of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the left of the textfield rect.
     func addPaddingLeft(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    ///  Add padding to the left of the textfield rect.
    ///
    /// - Parameters:
    ///   - image: left image
    ///   - padding: amount of padding between icon and the left of textfield
     func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        self.leftView = imageView
        self.leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    /// Add border width and color
    ///
    /// - Parameters:
    ///   - width: width
    ///   - color: color
    func setBorder(_ width: CGFloat, _ color: UIColor) {
        self.borderWidth = width
        self.borderColor = color
    }
    
}


#endif

#endif

//MARK: - fix secureEntry

public extension UITextField {
    
    /// fix secure entry
    func fixSecureEntry() {
        let beginning = beginningOfDocument
        selectedTextRange = textRange(from: beginning, to: beginning)
        let end = endOfDocument
        selectedTextRange = textRange(from: end, to: end)
    }
    
    /// 设置暂位文字的颜色
    var placeholderColor:UIColor {
        get {
            let color =   self.value(forKeyPath: "_placeholderLabel.textColor")
            if(color == nil){
                return UIColor.white;
            }
            return color as! UIColor;
        }
        set {
            self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    
    /// -设置暂位文字的字体
    var placeholderFont:UIFont{
        get {
            let font =   self.value(forKeyPath: "_placeholderLabel.font")
            if(font == nil){
                return UIFont.systemFont(ofSize: 14);
            }
            return font as! UIFont;
        }
        set {
            self.setValue(newValue, forKeyPath: "_placeholderLabel.font")
        }
    }
}

extension UITextField {
    /// place holder label
    open var placeholderLabel: UILabel? {
        value(forKey: "_placeholderLabel") as? UILabel
    }
}

extension UITextField {
    /// Fixes text jumping
    open override func resignFirstResponder() -> Bool {
        let resigned = super.resignFirstResponder()
        layoutIfNeeded()
        return resigned
    }
}

extension UITextField {
    
    /// associate key
    private struct AssociatedKey {
        static var contentInset = "contentInset"
        static var isInsertionCursorEnabled = "isInsertionCursorEnabled"
    }

    /// The default value is `0`.
    open var contentInset: UIEdgeInsets {
        
        get { objc_getAssociatedObject(self, &AssociatedKey.contentInset) as! UIEdgeInsets}
        set {
            objc_setAssociatedObject(self, &AssociatedKey.contentInset, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// The default value is `true`.
    open var isInsertionCursorEnabled: Bool {
        get { (objc_getAssociatedObject(self, &AssociatedKey.isInsertionCursorEnabled) != nil) }
            set {
                objc_setAssociatedObject(self, &AssociatedKey.isInsertionCursorEnabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    }
}

}

public extension UITextField {
    var frontSixthNumber:String {
        
        let text = self.text
        let endIndex = text!.index((text?.startIndex)!, offsetBy: 6)
        return String(text![..<endIndex])
    }
}
