//
//  UINavigationItemExtension.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/2.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import UIKit




// MARK: TextColor



// MARK: Helpers

public extension UIBarButtonItem {
    
    /// title text attribute
    /// - Parameters:
    ///   - key: key
    ///   - state: state
    /// - Returns: T
     func titleTextAttribute<T>(_ key: NSAttributedString.Key, for state: UIControl.State) -> T? {
        titleTextAttributes(for: state)?[key] as? T
    }
    
    /// set title text attribute
    /// - Parameters:
    ///   - key: key
    ///   - value: value
    ///   - state: state
     func setTitleTextAttribute(_ key: NSAttributedString.Key, value: Any?, for state: UIControl.State) {
        var attributes = titleTextAttributes(for: state) ?? [:]
        attributes[key] = value
        setTitleTextAttributes(attributes, for: state)
    }
}

public extension UIControl.State {
     static var applicationStates: [UIControl.State] {
        [.normal, .highlighted, .disabled, .selected, .focused, .application]
    }
}

