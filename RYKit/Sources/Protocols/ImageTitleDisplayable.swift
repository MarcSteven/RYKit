//
//  ImageTitleDisplayable.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/3.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import Foundation


/// Image title displayable
public protocol ImageTitleDisplayable {
    
    /// title
    var title: StringRepresentable { get }
    
    /// subtitle 
    var subtitle: StringRepresentable? { get }
    
}

extension ImageTitleDisplayable {
    public var subtitle: StringRepresentable? {
        nil
    }
}
