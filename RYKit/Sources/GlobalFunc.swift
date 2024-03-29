//
//  GlobalFunc.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/8.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import SystemConfiguration
import CoreTelephony



/// 切换闪光灯
/// - Parameter on: 是否打开，当打开的时候为true，否则为false
public func toggleFlash(on:Bool) {
    guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
    guard device.hasTorch else { print("Torch isn't available"); return }

    do {
        try device.lockForConfiguration()
        device.torchMode = on ? .on : .off
        // Optional thing you may want when the torch it's on, is to manipulate the level of the torch
        if on { try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel.significand) }
        device.unlockForConfiguration()
    } catch {
        print("Torch can't be used")
    }
}



/// unsafePointer 转换为对象
/// - Parameter object: 泛型对象T
/// - Returns: 返回UnsafeRawPointer
public func unsafePointer<T:AnyObject>(to object:T) ->UnsafeRawPointer {
    return UnsafeRawPointer(Unmanaged<T>.passUnretained(object).toOpaque())
}

/// 转换对象为unsafeMutableRawPointer
/// - Parameter object: 泛型对象
/// - Returns: 返回不安全的计算型原指针
public func unsafeMutablePointer<T:AnyObject>(to object:T)->UnsafeMutableRawPointer {
    return Unmanaged<T>.passUnretained(object).toOpaque()
}
/// Detects if the LLDB debugger is attached to the app.
///
/// - Note: LLDB is automatically attached when the app is running from Xcode.
public var isDebuggerAttached: Bool {
    var info = kinfo_proc()
    var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
    var size = MemoryLayout<kinfo_proc>.stride
    let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
    assert(junk == 0, "sysctl failed")
    return (info.kp_proc.p_flag & P_TRACED) != 0
}

/// Time delay method
/// - Parameters:
///   - interval: 时间间隔
///   - completionHandler: 完成句柄
public func delay(by interval:TimeInterval,
                  _ completionHandler:@escaping () ->Void) {
    Timer.schedule(delay: interval, handler: completionHandler)
}

/// 同步
/// - Parameters:
///   - lock: 锁
///   - closure: 必报
/// - Throws: 抛出异常
/// - Returns: 返回泛型参数T
public func synchronized<T>(_ lock: AnyObject, _ closure: () throws -> T) rethrows -> T {
    objc_sync_enter(lock)
    defer { objc_sync_exit(lock) }
    return try closure()
}

// MARK: Debounce

/// Wraps a function in a new function that will only execute the wrapped
/// function if `delay` has passed without this function being called.
///
/// - Parameters:
///   - delay: A `DispatchTimeInterval` to wait before executing the wrapped function after last invocation.
///   - queue: The queue to perform the action on. The defaults value is `.main`.
///   - action: A function to debounce. Can't accept any arguments.
/// - Returns: A new function that will only call `action` if `delay` time passes between invocations.
public func debounce(delay: DispatchTimeInterval, queue: DispatchQueue = .main, action: @escaping (() -> Void)) -> () -> Void {
    var currentWorkItem: DispatchWorkItem?

    return {
        currentWorkItem?.cancel()
        currentWorkItem = DispatchWorkItem { action() }
        queue.asyncAfter(deadline: .now() + delay, execute: currentWorkItem!)
    }
}

/// Wraps a function in a new function that will only execute the wrapped function if `delay` has passed without this function being called.
///
/// Accepts an `action` with one argument.
///
/// - Parameters:
///   - delay: A `DispatchTimeInterval` to wait before executing the wrapped function after last invocation.
///   - queue: The queue to perform the action on. The defaults value is `.main`.
///   - action: A function to debounce. Can accept one argument.
/// - Returns: A new function that will only call `action` if `delay` time passes between invocations.
public func debounce<T>(delay: DispatchTimeInterval, queue: DispatchQueue = .main, action: @escaping ((T) -> Void)) -> (T) -> Void {
    var currentWorkItem: DispatchWorkItem?
    return { (p1: T) in
        currentWorkItem?.cancel()
        currentWorkItem = DispatchWorkItem { action(p1) }
        queue.asyncAfter(deadline: .now() + delay, execute: currentWorkItem!)
    }
}

/// Wraps a function in a new function that will only execute the wrapped function if `delay` has passed without this function being called.
///
/// Accepts an `action` with two arguments.
///
/// - Parameters:
///   - delay: A `DispatchTimeInterval` to wait before executing the wrapped function after last invocation.
///   - queue: The queue to perform the action on. The defaults value is `.main`.
///   - action: A function to debounce. Can accept two arguments.
/// - Returns: A new function that will only call `action` if `delay` time passes between invocations.
public func debounce<T, U>(delay: DispatchTimeInterval, queue: DispatchQueue = .main, action: @escaping ((T, U) -> Void)) -> (T, U) -> Void {
    var currentWorkItem: DispatchWorkItem?
    return { (p1: T, p2: U) in
        currentWorkItem?.cancel()
        currentWorkItem = DispatchWorkItem { action(p1, p2) }
        queue.asyncAfter(deadline: .now() + delay, execute: currentWorkItem!)
    }
}

// MARK: Throttle

/// Wraps a function in a new function that will throttle the execution to once in every `delay` seconds.
///
/// - Parameters:
///   - delay: A `TimeInterval` specifying the number of seconds that needs to pass between each execution of `action`.
///   - queue: The queue to perform the action on. The defaults value is `.main`.
///   - action: A function to throttle.
/// - Returns: A new function that will only call `action` once every `delay` seconds, regardless of how often it is called.
public func throttle(delay: TimeInterval, queue: DispatchQueue = .main, action: @escaping (() -> Void)) -> () -> Void {
    var currentWorkItem: DispatchWorkItem?
    var lastFire: TimeInterval = 0
    return {
        guard currentWorkItem == nil else { return }
        currentWorkItem = DispatchWorkItem {
            action()
            lastFire = Date().timeIntervalSinceReferenceDate
            currentWorkItem = nil
        }
        delay.hasPassed(since: lastFire) ? queue.async(execute: currentWorkItem!) : queue.asyncAfter(deadline: .now() + delay, execute: currentWorkItem!)
    }
}

/// Wraps a function in a new function that will throttle the execution to once in every `delay` seconds.
///
/// Accepts an `action` with one argument.
///
/// - Parameters:
///   - delay: A `TimeInterval` specifying the number of seconds that needs to pass between each execution of `action`.
///   - queue: The queue to perform the action on. The defaults value is `.main`.
///   - action: A function to throttle. Can accept one argument.
/// - Returns: A new function that will only call `action` once every `delay` seconds, regardless of how often it is called.
public func throttle<T>(delay: TimeInterval, queue: DispatchQueue = .main, action: @escaping ((T) -> Void)) -> (T) -> Void {
    var currentWorkItem: DispatchWorkItem?
    var lastFire: TimeInterval = 0
    return { (p1: T) in
        guard currentWorkItem == nil else { return }
        currentWorkItem = DispatchWorkItem {
            action(p1)
            lastFire = Date().timeIntervalSinceReferenceDate
            currentWorkItem = nil
        }
        delay.hasPassed(since: lastFire) ? queue.async(execute: currentWorkItem!) : queue.asyncAfter(deadline: .now() + delay, execute: currentWorkItem!)
    }
}

/// Wraps a function in a new function that will throttle the execution to once in every `delay` seconds.
///
/// Accepts an `action` with two arguments.
///
/// - Parameters:
///   - delay: A `TimeInterval` specifying the number of seconds that needs to pass between each execution of `action`.
///   - queue: The queue to perform the action on. The defaults value is `.main`.
///   - action: A function to throttle. Can accept two arguments.
/// - Returns: A new function that will only call `action` once every `delay` seconds, regardless of how often it is called.
public func throttle<T, U>(delay: TimeInterval, queue: DispatchQueue = .main, action: @escaping ((T, U) -> Void)) -> (T, U) -> Void {
    var currentWorkItem: DispatchWorkItem?
    var lastFire: TimeInterval = 0
    return { (p1: T, p2: U) in
        guard currentWorkItem == nil else { return }
        currentWorkItem = DispatchWorkItem {
            action(p1, p2)
            lastFire = Date().timeIntervalSinceReferenceDate
            currentWorkItem = nil
        }
        delay.hasPassed(since: lastFire) ? queue.async(execute: currentWorkItem!) : queue.asyncAfter(deadline: .now() + delay, execute: currentWorkItem!)
    }
}
public  func alert(title:String = "",
                   message:String = "") {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    alert.show()
}

// MARK: - Global

/// Returns the name of a `type` as a string.
///
/// - Parameter value: The value for which to get the dynamic type name.
/// - Returns: A string containing the name of `value`'s dynamic type.
public func name(of value: Any) -> String {
    let kind = value is Any.Type ? value : Swift.type(of: value)
    let description = String(reflecting: kind)

    // Swift compiler bug causing unexpected result when getting a String describing
    // a type created inside a function.
    //
    // https://bugs.swift.org/browse/SR-6787

    let unwantedResult = "(unknown context at "
    guard description.contains(unwantedResult) else {
        return description
    }

    let components = description.split(separator: ".").filter { !$0.hasPrefix(unwantedResult) }
    return components.joined(separator: ".")
}

/// 插入模糊视图
/// - Parameters:
///   - view: 所在的view
///   - style: 模糊效果的风格
/// - Returns: 返回可视化效果的视图
public func insertBlurView (view: UIView, style: UIBlurEffect.Style) -> UIVisualEffectView {
    view.backgroundColor = UIColor.clear
    
    let blurEffect = UIBlurEffect(style: style)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    view.insertSubview(blurEffectView, at: 0)
    return blurEffectView
}

//Utility method - takes a list of views and simply makes up new string names for them
public func dictionaryOfNames(_ array:UIView...) ->[String:UIView] {
    var dictionary = [String:UIView]()
    for (index,v) in array.enumerated() {
        dictionary["v\(index+1)"] = v
    }
    return dictionary
}
//生成二维码
public func generateQRCode(from string:String) ->UIImage? {
    let data = string.data(using: String.Encoding.ascii)
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        if let output = filter.outputImage?.transformed(by: transform) {
            return UIImage(ciImage: output)
        }
    }
    return nil
}

