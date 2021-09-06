//
//  NSAttributedString+HasText.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/12.
//  Copyright © 2020 Marc Zhao All rights reserved.
//

import Foundation


public extension NSAttributedString {
    
    /// has text
    var mc_hasText:Bool {
        return string.mc_hasText
    }
    
    /// has non wite space text
    var mc_hasNonWhitespaceText:Bool {
        return string.mc_hasNonWhitespaceText
    }
}
