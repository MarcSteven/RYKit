//
//  LoggerDelegate.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/11.
//  Copyright © 2020 Marc Zhao All rights reserved.
//
import AVFoundation
import Foundation
/** Log level*/
@objc public enum LogLevel:Int {
    //debug
    case debug = 0
    //verbose
    case verbose = 1
    // info
    case info = 2
    //application
    case application = 3
    // warning
    case warning = 4
    // error
    case error = 5
    // convert the name to the string
    public func name() ->String {
        var readableName:String
        switch self {
        case .debug:
            readableName = "D"
        case .info:
            readableName = "I"
        case .application:
            readableName = "A"
        case .warning:
            readableName = "W"
        case .verbose:
            readableName = "V"
            
        
        case .error:
            readableName = "E"
        }
        return readableName
    }
}
//Logger delegate
@objc public protocol LoggerDelegate :class{
    /// log the message about the log level
    /// Parameters:
    /// - logLevel: log level
    /// - message: message about the log
    @objc func log(_ logLevel:LogLevel,message:String)
}
