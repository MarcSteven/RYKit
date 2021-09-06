//
//  CommonConstants.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/20.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import Foundation
import UIKit

public let isIphoneXOrLater:Bool = RYUIHelper.isIphoneXOrLater

/// 是iPAD
public let isIpad :Bool  = RYUIHelper.isIpad

/// 是tv
public let isTv:Bool = RYUIHelper.isTv

/// 是carPlay
public let isCarPlay:Bool = RYUIHelper.isCarPlay

public let is_landscape = UIApplication.shared.statusBarOrientation.isLandscape
public let is_portrait = UIApplication.shared.statusBarOrientation.isPortrait

/// 设备宽度
public let device_width = is_landscape ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width

/// 设备高度
public let device_height = is_portrait ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height

/// iPhone X对应的safeAreaInset
public let safeAreaInsetForIphoneX = RYUIHelper.safeAreaInsetForIphoneX

/// 是4inch屏幕
public let isScreen4Inch = RYUIHelper.isScreen4Inch

/// 是5.5寸屏幕
public let isScreen55Inch = RYUIHelper.isScreen55Inch

/// 是模拟器
public let isSimulator = RYUIHelper.isSimulator

/// 是12.9寸屏
public let isScreen129Inch = RYUIHelper.isScreen129Inch

/// 是4.7寸屏
public let isScreen47Inch = RYUIHelper.isScreen47Inch

/// 是6.1寸屏
public let isScreen61Inch = RYUIHelper.isScreen61Inch

public let screen61Inch = RYUIHelper.screenFor61Inch
public let screen47Inch = RYUIHelper.screen47Inch
public let screen35Inch = RYUIHelper.screen35Inch
public let screen55Inch = RYUIHelper.screenFor55Inch

public let screen4Inch = RYUIHelper.screen4Inch

public let isIos11 = RYUIHelper.isIOS11
public let isIos13 = RYUIHelper.isIOS13
/// 1像素
public let onePixle = RYUIHelper.onePointPixle

/// 是3.5寸屏
public let isScreen35Inch = RYUIHelper.isScreen35Inch

/// 屏幕scale
public let screenScale = UIScreen.main.scale

/// native scale
public let nativeScale = UIScreen.main.nativeScale

/// 当前的系统版本
public let currentSystemVersion = UIDevice.current.systemVersion.doubleValue

/// 当前语言
public let currentLanguage = NSLocale.preferredLanguages[0]

/// 根视图控制器
public let rootViewController = RYUIHelper.rootViewController

/// 屏幕宽度
public let screenWidth = RYUIHelper.screenWidth

/// 屏幕高度
public let screenHeight = RYUIHelper.screenHeight



