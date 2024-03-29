

//
//  UIFontExtension.swift
//  MemoryChainKit
//
//  Created by Zhao Meiru on 2020/4/9.
//  Copyright © 2020 Marc Steven All rights reserved.
//



import UIKit 


extension UIFont {
    
    /// traints
    public enum Trait {
        case normal
        case italic
        case monospace
    }
    
    /// system font
    /// - Parameters:
    ///   - size: size
    ///   - weight: weight
    ///   - trait: trait
    /// - Returns: font
    public static func systemFont(size: CGFloat, weight: Weight = .regular, trait: Trait = .normal) -> UIFont {
        switch trait {
            case .normal:
                return systemFont(ofSize: size, weight: weight)
            case .italic:
                return italicSystemFont(ofSize: size)
            case .monospace:
                return monospacedDigitSystemFont(ofSize: size, weight: weight)
        }
    }
}

extension UIFont {
    
    /// apply
    /// - Parameter trait: traint
    /// - Returns: return UIFont
    func apply(_ trait: Trait) -> UIFont {
        trait == .monospace ? monospacedDigitFont : self
    }

    /// Returns a font matching the given font descriptor.
    ///
    /// - Parameter traits: The new symbolic traits.
    /// - Returns: The new font matching the given font descriptor.
    public func traits(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont? {
        guard let descriptor = fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) else {
            return nil
        }

        return UIFont(descriptor: descriptor, size: 0)
    }
    
    /// bold
    /// - Returns: font
    public func bold() -> UIFont? {
        traits(.traitBold)
    }
    
    /// italic
    /// - Returns: font
    public func italic() -> UIFont? {
        traits(.traitItalic)
    }
    
    /// monospace
    /// - Returns: font
    public func monospace() -> UIFont? {
        traits(.traitMonoSpace)
    }
}

extension UIFont {
    
    /// monospacedDigitFont
    public var monospacedDigitFont: UIFont {
        let featureSettings = [[
            UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
            UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector
        ]]
        let attributes = [UIFontDescriptor.AttributeName.featureSettings: featureSettings]
        let oldDescriptor = fontDescriptor
        let newDescriptor = oldDescriptor.addingAttributes(attributes)
        return UIFont(descriptor: newDescriptor, size: 0)
    }
}

extension UIFont {
    
    /// print availabel font names
    public static func printAvailableFontNames() {
        for family in familyNames {
            let count = fontNames(forFamilyName: family).count
            print("▿ \(family) (\(count) \(count == 1 ? "font" : "fonts"))")

            for name in fontNames(forFamilyName: family) {
                print("  - \(name)")
            }
        }
    }
}

