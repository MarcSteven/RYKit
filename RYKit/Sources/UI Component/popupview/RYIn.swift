//
//  RYIn.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/2.
//  Copyright © 2020 Rich And Young. All rights reserved.
//
// MARK: `ry` namespace

public final class RYIn<Base> {
    /// Base object to extend.
    public let base: Base
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}
/// A type that has FOLDin extensions.
public protocol RYinCompatible {
    /// Extended type
    associatedtype CompatibleType
    
    
    /// RYIN extension
    static var ry: RYIn<CompatibleType>.Type { get }
    
    
    /// RYIn extension
    var ry: RYIn<CompatibleType> { get }
}
extension RYinCompatible {
    
    /// RYIn extension
    public static var ry: RYIn<Self>.Type {
        return RYIn<Self>.self
    }
    
    /// RYIn extension
    public var ry: RYIn<Self> {
        return RYIn(self)
    }
}
import class Foundation.NSObject
extension NSObject: RYinCompatible {}

