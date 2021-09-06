//
//  Responder.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/9.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

/// Responder protocol
public protocol Responder:class {
    
}

/// Dispatcher protocol
public protocol Dispatcher {
    typealias Event = UIEvent
    
    /// dispatch event
    /// - Parameter event: event
    func dispatch(_ event:Event)
}
