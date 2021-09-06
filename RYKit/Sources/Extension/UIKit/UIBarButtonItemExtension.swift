//
//  UIBarButtonItemExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit

// MARK: TextColor

extension UIBarButtonItem {
    @objc open dynamic var textColor: UIColor? {
        get { titleTextColor(for: .normal) }
        set { setTitleTextColor(newValue, for: .normal) }
    }

    open func titleTextColor(for state: UIControl.State) -> UIColor? {
        return titleTextAttribute(.foregroundColor, for: state)
    }

    open func setTitleTextColor(_ color: UIColor?, for state: UIControl.State) {
        setTitleTextAttribute(.foregroundColor, value: color, for: state)
    }
}

// MARK: Font

extension UIBarButtonItem {
    @objc open dynamic var font: UIFont? {
        get { titleTextFont(for: .normal) }
        set {
            UIControl.State.applicationStates.forEach {
                setTitleTextFont(newValue, for: $0)
            }
        }
    }

    open func titleTextFont(for state: UIControl.State) -> UIFont? {
        titleTextAttribute(.font, for: state)
    }

    open func setTitleTextFont(_ font: UIFont?, for state: UIControl.State) {
        setTitleTextAttribute(.font, value: font, for: state)
    }
}

