//
//  Cancellable.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/7.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
///  protocol cancellable ,if you conform to the protocol cancellable ,you must invoke the cancel() method here

@objc
public protocol Cancellable {
    func cancel()
}
/// - operation conform to the Cancellable
extension Operation:Cancellable {}
/// - NSURLConnection conform to the NSURLConnection
extension NSURLConnection :Cancellable {}
/// - URLSessionTask conform to the protocol NSURLSeesionTask 
extension URLSessionTask:Cancellable {}




