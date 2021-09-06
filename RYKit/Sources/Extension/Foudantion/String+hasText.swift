//
//  String+hasText.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/12.
//  Copyright © 2020 Marc Zhao All rights reserved.
//

import Foundation

public extension String {
    
    /// has text
    var mc_hasText:Bool {
        return !isEmpty
    }
    
    /// has non white space text
    var mc_hasNonWhitespaceText:Bool {
        return mc_hasText && !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
