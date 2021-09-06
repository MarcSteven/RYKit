//
//  UITextField+MaxLength.swift
//  RYKit
//
//  Created by Marc Steven on 2020/8/21.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import UIKit



public extension UITextField {
    var selectedRange:NSRange? {
        guard let selectedTextRange = self.selectedTextRange else {
            return nil
        }
        let location  = offset(from: beginningOfDocument, to: selectedTextRange.start)
        let length = offset(from: beginningOfDocument, to: selectedTextRange.start)
        return NSRange(location: location, length: length)
    }
}
