//
//  FatalReason.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import Foundation

// See: https://github.com/apple/swift-evolution/pull/861/files

/// Reasons why code should abort at runtime
public struct FatalReason: CustomStringConvertible {
    /// An underlying string-based cause for a fatal error.
    public let reason: String

    /// Establishes a new instance of a `FatalReason` with a string-based explanation.
    public init(_ reason: String) {
        self.reason = reason
    }

    /// Conforms to CustomStringConvertible, allowing reason to print directly to complaint.
    public var description: String {
        reason
    }
}

extension FatalReason: ExpressibleByStringLiteral {
    /// 初始化
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
}

extension FatalReason {
    //子类化必须实现
    public static let subclassMustImplement: Self = "Must be implemented by subclass."
}

// MARK:  Fatal Reasons

extension FatalReason {
    /// 不支持的回调格式风格
    static let unsupportedFallbackFormattingStyle: Self = "Fallback style shouldn't be of type `abbreviationWith`."
    /// 未知的事件检测
    static func unknownCaseDetected<T: RawRepresentable>(_ case: T) -> Self {
        .init("Unknown case detected: \(`case`) - (\(`case`.rawValue))")
    }
    /// dequeue失败
    /// Parameters:
    /// - name: 名字
    /// - identifier:标识符
    static func dequeueFailed(for name: String, identifier: String) -> Self {
        .init("Failed to dequeue \(name) with identifier: \(identifier)")
    }

    /// Dequeue失败
    /// Parameters:
    /// - name: 名字
    /// - identifier:标识符
    /// - indexPath: 索引路径
    static func dequeueFailed(for name: String, kind: String, indexPath: IndexPath) -> Self {
        .init("Failed to dequeue \(name) for kind: \(kind) at indexPath(\(indexPath.section), \(indexPath.item))")
    }
}

/// Unconditionally prints a given message and stops execution.
///
/// - Parameters:
///   - reason: A predefined `FatalReason`.
///   - function: The name of the calling function to print with `message`. The
///     default is the calling scope where `fatalError(because:, function:, file:, line:)`
///     is called.
///   - file: The filename to print with `message`. The default is the file
///     where `fatalError(because:, function:, file:, line:)` is called.
///   - line: The line number to print along with `message`. The default is the
///     line number where `fatalError(because:, function:, file:, line:)` is called.
@_transparent
public func fatalError(
    because reason: FatalReason,
    function: StaticString = #function,
    file: StaticString = #file,
    line: UInt = #line
) -> Never {
    fatalError("\(function): \(reason)", file: file, line: line)
}

/**Print a warning message in debug mode*/

@_transparent
/// 警告未知
/// Parameters:
/// - value:对应的值
/// - file:文件
/// - function: 函数
/// - line:行数
public func warnUnknown(_ value:Any,
                        file:String = #file,
                        function:String = #function,
                        line:Int = #line)  {
    #if DEBUG
    Console.warn("Unknown value detected: \(value)", className: file, functionName: function, lineNumber: line)

    #endif
}
