//
//  Double+Extensions.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/3/3.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public extension Double {
    
    /// km
    var km:Double {
        return self * 1_000.0
    }
    
    /// m
    var m:Double {
        return self
    }
    
    /// cm
    var cm:Double {
        return self / 100.0
    }
    
    /// mm
    var mm:Double {
        return self / 1_000.0
    }
    
    /// ft
    var ft:Double {
        return self / 3.28084
    }
}
