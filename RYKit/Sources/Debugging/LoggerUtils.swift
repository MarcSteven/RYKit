//
//  LoggerUtils.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/11.
//  Copyright © 2020 Marc Zhao All rights reserved.
//

import Foundation

//logger 工具
open class LoggerUtils {
    private var logger:LoggerDelegate?
    //初始化方法
    init(_ logger: LoggerDelegate?) {
        self.logger = logger
    }
    //debug
    func d(_ message: String) {
        
        
        logger?.log(.debug, message: message)
    }
    //verbose
    func v(_ message: String) {
        logger?.log(.verbose, message: message)
    }
    //info
    func i(_ message: String) {
        logger?.log(.info, message: message)
    }
    //application
    func a(_ message: String) {
        logger?.log(.application, message: message)
    }
    // warning
    func w(_ message: String) {
        logger?.log(.warning, message: message)
    }
    //error
    func e(_ message: String) {
        logger?.log(.error, message: message)
    }
    // warning
    func w(_ error: Error) {
        logger?.log(.warning, message: "Error \((error as NSError).code): \(error.localizedDescription)")
    }
    // error
    func e(_ error: Error) {
        logger?.log(.error, message: "Error \((error as NSError).code): \(error.localizedDescription)")
    }
}
