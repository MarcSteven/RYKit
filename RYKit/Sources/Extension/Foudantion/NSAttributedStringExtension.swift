//
//  NSAttributedStringExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven. All rights reserved.
//

import UIKit

// MARK: - NSAttributedString Extension

extension NSAttributedString {
    
    /// set line spacing
    /// - Parameter spacing: spacing
    /// - Returns: NSMutableAttributedString
    @objc public func setLineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
         NSMutableAttributedString(attributedString: self).setLineSpacing(spacing)
    }
    
    /// attributes Description
    public var attributesDescription: String {
        let text = string as NSString
        let range = NSRange(location: 0, length: length)
        var result: [String] = []

        enumerateAttributes(in: range) { attributes, range, _ in
            result.append("\nstring: \(text.substring(with: range))")
            result.append("range: \(NSStringFromRange(range))")
            attributes.forEach {
                var value = $0.value

                if $0.key == .foregroundColor, let color = value as? UIColor {
                    value = color.hexString
                }

                result.append("\($0.key.rawValue): \(value)")
            }
        }

        return result.joined(separator: "\n")
    }
}

// MARK: - NSMutableAttributedString Extension

extension NSMutableAttributedString {
    
    /// set line spacing
    /// - Parameter spacing: spacing
    /// - Returns: return Self
    public override func setLineSpacing(_ spacing: CGFloat) -> Self {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: string.count))
        return self
    }
    
    /// Replace attribute
    /// - Parameters:
    ///   - name: key name
    ///   - value: value
    ///   - range: range
    open func replaceAttribute(_ name: Key, value: Any, range: NSRange) {
        removeAttribute(name, range: range)
        addAttribute(name, value: value, range: range)
    }
}

extension NSMutableAttributedString {
    
    /// underline
    /// - Parameters:
    ///   - text: text
    ///   - style: style
    /// - Returns: Self
    open func underline(_ text: String, style: NSUnderlineStyle = .single) -> Self {
        addAttribute(.underlineStyle, value: style.rawValue, range: range(of: text))
        return self
    }
    
    /// Foreground color
    /// - Parameters:
    ///   - color: color
    ///   - text: text
    /// - Returns: Self
    open func foregroundColor(_ color: UIColor, for text: String? = nil) -> Self {
        addAttribute(.foregroundColor, value: color, range: range(of: text))
        return self
    }
    
    /// background color
    /// - Parameters:
    ///   - color: color
    ///   - text: text
    /// - Returns: Self
    open func backgroundColor(_ color: UIColor, for text: String? = nil) -> Self {
        addAttribute(.backgroundColor, value: color, range: range(of: text))
        return self
    }
    
    /// Font
    /// - Parameters:
    ///   - font: font
    ///   - text: text
    /// - Returns: Self
    open func font(_ font: UIFont, for text: String? = nil) -> Self {
        addAttribute(.font, value: font, range: range(of: text))
        return self
    }
    
    /// Text Alignment
    /// - Parameters:
    ///   - textAlignment: text alignment
    ///   - text: text
    /// - Returns: Self
    open func textAlignment(_ textAlignment: NSTextAlignment, for text: String? = nil) -> Self {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range(of: text))
        return self
    }
    
    /// link
    /// - Parameters:
    ///   - url: url
    ///   - text: text
    /// - Returns: Self
    open func link(url: URL?, text: String) -> Self {
        guard let url = url else {
            return self
        }

        addAttribute(.link, value: url, range: range(of: text))
        return self
    }
    
    /// Range
    /// - Parameter text: text
    /// - Returns: NSRange
    private func range(of text: String?) -> NSRange {
        let range: NSRange

        if let text = text {
            range = (string as NSString).range(of: text)
        } else {
            range = NSRange(location: 0, length: string.count)
        }

        return range
    }
}

extension NSAttributedString {
    /// Returns an `NSAttributedString` object initialized with a given `string` and `attributes`.
    ///
    /// Returns an `NSAttributedString` object initialized with the characters of `aString`
    /// and the attributes of `attributes`. The returned object might be different from the original receiver.
    ///
    /// - Parameters:
    ///   - string: The string for the new attributed string.
    ///   - image: The image for the new attributed string.
    ///   - baselineOffset: The value indicating the `image` offset from the baseline. The default value is `0`.
    ///   - attributes: The attributes for the new attributed string. For a list of attributes that you can include in this
    ///                 dictionary, see `Character Attributes`.
    public convenience init(string: String? = nil, image: UIImage, baselineOffset: CGFloat = 0, attributes: [Key: Any]? = nil) {
        let attachment = NSAttributedString.attachmentAttributes(for: image, baselineOffset: baselineOffset)

        guard let string = string else {
            self.init(string: attachment.string, attributes: attachment.attributes)
            return
        }

        let attachmentAttributedString = NSAttributedString(string: attachment.string, attributes: attachment.attributes)
        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        attributedString.append(attachmentAttributedString)
        self.init(attributedString: attributedString)
    }
    
    /// attachment attributes
    /// - Parameters:
    ///   - image: image
    ///   - baselineOffset: baseline offset
    /// - Returns: (string: attributes)
    private static func attachmentAttributes(for image: UIImage, baselineOffset: CGFloat) -> (string: String, attributes: [Key: Any]) {
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineHeightMultiple = 0.9

        let attachment = NSTextAttachment(data: nil, ofType: nil)
        attachment.image = image

        let attachmentCharacterString = String(Character(UnicodeScalar(NSTextAttachment.character)!))

        return (string: attachmentCharacterString, attributes: [
            .attachment: attachment,
            .baselineOffset: baselineOffset,
            .paragraphStyle: paragraphStyle
        ])
    }
}


extension NSAttributedString {
    
    /// caret Direction
    public enum CaretDirection {
        case none
        case up
        case down
        case back
        case forward
        
        /// Image base line offset
        var imageBaselineOffset: CGFloat {
            switch self {
                case .none:
                    return 0
                case .up, .down:
                    return 2
                case .back, .forward:
                    return 0
            }
        }
    }
}

// MARK: - Bullets

extension NSAttributedString {
    
    /// bullet style
    public enum BulletStyle {
        case `default`
        case ordinal
        
        /// bullet
        /// - Parameter index: index
        /// - Returns: string
        fileprivate func bullet(at index: Int) -> String {
            switch self {
                case .default:
                    return "•   "
                case .ordinal:
                    return (index + 1).description + ".  "
            }
        }
    }

}
