//
//  MemoryChainEmptyStateView.swift
//  MemoryChainUIKit
//
//  Created by Marc Zhao on 2018/9/11.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

/**
 * add the empty state view when no data 
 
 */

@IBDesignable
/// Empty state view
open class MemoryChainEmptyStateView:UIControl {
    // image view
    fileprivate(set) open var imageView:UIImageView!
    // text label
    fileprivate(set) open var textLabel:UILabel!
    // button
    fileprivate(set) open var button:UIButton!
    // image
    @IBInspectable
    open var image:UIImage {
        get {
            return imageView.image!
        }
        set {
            imageView.image = newValue
        }
    }
    /// message
    @IBInspectable
    open var message:String {
        get {
            return textLabel.text ?? ""
        }
        set {
            textLabel.text = newValue
        }
    }
    /// button text
    @IBInspectable
    open var buttonText:String {
        get {
            return button.title(for: [])!
        }
        set {
            button.setTitle(newValue, for: [])
        }
    }
    /// button color
    @IBInspectable
    open var buttonColor:UIColor {
        get {
            return button.tintColor
        }
        set {
            button.layer.borderColor = newValue.cgColor
        }
    }
    /// button is hidden
    @IBInspectable
    open var buttonIsHidden:Bool = false {
        didSet {
            button.isHidden = buttonIsHidden
        }
    }
    /// initilizer
    convenience public init(image:UIImage,
                            message:String,
                            buttonText:String? = nil) {
        self.init(frame: CGRect.zero)
        self.image = image
        self.message = message
        if let buttonText = buttonText {
            self.buttonText = buttonText
        }else {
            buttonIsHidden = true
        }
    }
    override public init(frame: CGRect) {
         super.init(frame: frame)
        setupView()
        
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("(coder:) has not been implemented")
     
   
    }
    /// add target
    /// - Parameters:
    /// - target: 对应的目标
    /// - action: 对应的行为
    /// - controlEvent：控制事件
    final override public func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvents)
    }
    /// set up uilabel
    open func setupLabel() ->UILabel {
        let textLabel = UILabel()
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        return textLabel
    }
    /// set up image
    open func setupImage() ->UIImageView {
        return UIImageView()
    }
    /// set up buttons
    open func setupButton() ->UIButton {
        let button = UIButton(type: .system)
        
        button.layer.cornerRadius = 5
        button.layer.borderColor = button.tintColor.cgColor
        button.layer.borderWidth = 1
        
        
        return button
    }
    /// set up UIStackview
    open func setupStackView(_ imageView:UIImageView,
                             _ textLabel:UILabel,
                             _ button:UIButton) ->UIStackView {
        let stackView = UIStackView(arrangedSubviews: [imageView,textLabel,button])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        return stackView
    }
    /// set up view
    private func setupView() {
        //set up views
        imageView = setupImage()
        textLabel = setupLabel()
        button = setupButton()
        let stackView = setupStackView(imageView, textLabel, button)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
        
        // add constraints to stackview
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }
}
