//
//  UIDevice+Extension.swift
//  MemoryChainExtensionService
//
//  Created by Marc Zhao on 2018/9/12.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit
import Foundation

extension UIDevice {
    
    /// Capability
    public struct Capability:OptionSet {
        public let rawValue:Int
        public init(rawValue:Int) {
            self.rawValue = rawValue
        }
        
        /// touch ID
        public static let touchID = Capability(rawValue:1 << 0)
        
        /// face ID
        public static let faceID = Capability(rawValue: 1 << 1)
        
        /// notch
        public static let notch = Capability(rawValue:1 << 2)
        
        /// homeIndicator
        public static let homeIndicator = Capability(rawValue:1<<3)
        
        /// iphone x series
        public static let iphoneXseries:Capability = [.notch,.faceID,.homeIndicator]
        
    }
}

/// Enum representing the different types of iOS devices available
public enum DeviceType: String, CaseIterable {
    case iPhone2G
    
    case iPhone3G
    case iPhone3GS
    
    case iPhone4
    case iPhone4S
    
    case iPhone5
    case iPhone5C
    case iPhone5S
    
    case iPhone6
    case iPhone6Plus
    
    case iPhone6S
    case iPhone6SPlus
    
    case iPhoneSE
    
    case iPhone7
    case iPhone7Plus
    
    case iPhone8
    case iPhone8Plus
    
    case iPhoneX
    case iPhoneXs
    case iPhoneXr
    case iPhoneXsMax
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax
    case iPhoneSE2
    
    
    case iPodTouch1G
    case iPodTouch2G
    case iPodTouch3G
    case iPodTouch4G
    case iPodTouch5G
    case iPodTouch6G
    case iPodTouch7G
    
    case iPad
    case iPad2
    case iPad3
    case iPad4
    case iPadMini
    case iPadMiniRetina
    case iPadMini3
    case iPadMini4
    
    case iPadAir
    case iPadAir2
    
    case iPadPro9Inch
    case iPadPro10p5Inch
    case iPadPro12Inch
    
    case simulator
    case notAvailable
    
    // MARK: Constants
    /// The current device type
    public static var current: DeviceType {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machine = systemInfo.machine
        let mirror = Mirror(reflecting: machine)
        var identifier = ""
        
        for child in mirror.children {
            if let value = child.value as? Int8, value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }
        
        return DeviceType(identifier: identifier)
    }
    
    // MARK: Variables
    /// The display name of the device type
    public var displayName: String {
        
        switch self {
        case .iPhone2G: return "iPhone 2G"
        case .iPhone3G: return "iPhone 3G"
        case .iPhone3GS: return "iPhone 3GS"
        case .iPhone4: return "iPhone 4"
        case .iPhone4S: return "iPhone 4S"
        case .iPhone5: return "iPhone 5"
        case .iPhone5C: return "iPhone 5C"
        case .iPhone5S: return "iPhone 5S"
        case .iPhone6Plus: return "iPhone 6 Plus"
        case .iPhone6: return "iPhone 6"
        case .iPhone6S: return "iPhone 6S"
        case .iPhone6SPlus: return "iPhone 6S Plus"
        case .iPhoneSE: return "iPhone SE"
        case .iPhone7: return "iPhone 7"
        case .iPhone7Plus: return "iPhone 7 Plus"
        case .iPhone8: return "iPhone 8"
        case .iPhone8Plus: return "iPhone 8 Plus"
        case .iPhoneX: return "iPhone X"
        case .iPhoneXr: return "iPhoneXr"
        case .iPhoneXs: return "iPhoneXs"
        case .iPhoneXsMax: return "iPhoneXsMax"
        case .iPhone11: return "iPhone11"
        case .iPhone11Pro: return "iPhone11Pro"
        case .iPhone11ProMax: return "iPhone11ProMax"
        case .iPhoneSE2: return "iPhoneSE2"
        case .iPodTouch1G: return "iPod Touch 1G"
        case .iPodTouch2G: return "iPod Touch 2G"
        case .iPodTouch3G: return "iPod Touch 3G"
        case .iPodTouch4G: return "iPod Touch 4G"
        case .iPodTouch5G: return "iPod Touch 5G"
        case .iPodTouch6G: return "iPod Touch 6G"
        case .iPodTouch7G: return "iPod Touch 7G"
        case .iPad: return "iPad"
        case .iPad2: return "iPad 2"
        case .iPad3: return "iPad 3"
        case .iPad4: return "iPad 4"
        case .iPadMini: return "iPad Mini"
        case .iPadMiniRetina: return "iPad Mini Retina"
        case .iPadMini3: return "iPad Mini 3"
        case .iPadMini4: return "iPad Mini 4"
        case .iPadAir: return "iPad Air"
        case .iPadAir2: return "iPad Air 2"
        case .iPadPro9Inch: return "iPad Pro 9 Inch"
        case .iPadPro10p5Inch: return "iPad Pro 10.5 Inch"
        case .iPadPro12Inch: return "iPad Pro 12 Inch"
        case .simulator: return "Simulator"
        case .notAvailable: return "Not Available"
        }
    }
    
    /// The identifiers associated with each device type
    
    //for more details, you can visit here(https://everyi.com/by-identifier/ipod-iphone-ipad-specs-by-model-identifier.html)
    internal var identifiers: [String] {
        
        switch self {
        case .notAvailable: return []
        case .simulator: return ["i386", "x86_64"]
            
        case .iPhone2G: return ["iPhone1,1"]
        case .iPhone3G: return ["iPhone1,2"]
        case .iPhone3GS: return ["iPhone2,1"]
        case .iPhone4: return ["iPhone3,1", "iPhone3,2", "iPhone3,3"]
        case .iPhone4S: return ["iPhone4,1"]
        case .iPhone5: return ["iPhone5,1", "iPhone5,2"]
        case .iPhone5C: return ["iPhone5,3", "iPhone5,4"]
        case .iPhone5S: return ["iPhone6,1", "iPhone6,2"]
        case .iPhone6: return ["iPhone7,2"]
        case .iPhone6Plus: return ["iPhone7,1"]
        case .iPhone6S: return ["iPhone8,1"]
        case .iPhone6SPlus: return ["iPhone8,2"]
        case .iPhoneSE: return ["iPhone8,4"]
        case .iPhone7: return ["iPhone9,1", "iPhone9,3"]
        case .iPhone7Plus: return ["iPhone9,2", "iPhone9,4"]
        case .iPhone8: return ["iPhone10,1", "iPhone10,4"]
        case .iPhone8Plus: return ["iPhone10,2", "iPhone10,5"]
        case .iPhoneX: return ["iPhone10,3", "iPhone10,6"]
        case .iPhoneXsMax: return ["iPhone11,6"]
        case .iPhoneXs: return ["iPhone11,2"]
        case .iPhoneXr: return ["iPhone11,8"]
        case .iPhone11: return ["iPhone12,1"]
        case .iPhone11Pro: return ["iPhone12,3"]
        case .iPhone11ProMax: return ["iPhone12,5"]
        case .iPhoneSE2: return []
            
        case .iPodTouch1G: return ["iPod1,1"]
        case .iPodTouch2G: return ["iPod2,1"]
        case .iPodTouch3G: return ["iPod3,1"]
        case .iPodTouch4G: return ["iPod4,1"]
        case .iPodTouch5G: return ["iPod5,1"]
        case .iPodTouch6G: return ["iPod7,1"]
        case .iPodTouch7G: return ["iPod9,1"]
            
        case .iPad: return ["iPad1,1", "iPad1,2"]
        case .iPad2: return ["iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4"]
        case .iPad3: return ["iPad3,1", "iPad3,2", "iPad3,3"]
        case .iPad4: return ["iPad3,4", "iPad3,5", "iPad3,6"]
        case .iPadMini: return ["iPad2,5", "iPad2,6", "iPad2,7"]
        case .iPadMiniRetina: return ["iPad4,4", "iPad4,5", "iPad4,6"]
        case .iPadMini3: return ["iPad4,7", "iPad4,8", "iPad4,9"]
        case .iPadMini4: return ["iPad5,1", "iPad5,2"]
        case .iPadAir: return ["iPad4,1", "iPad4,2", "iPad4,3"]
        case .iPadAir2: return ["iPad5,3", "iPad5,4"]
        case .iPadPro9Inch: return ["iPad6,3", "iPad6,4"]
        case .iPadPro10p5Inch: return ["iPad7,3", "iPad7,4"]
        case .iPadPro12Inch: return ["iPad6,7", "iPad6,8", "iPad7,1", "iPad7,2"]
        }
    }
    
    // MARK: Inits
    /// Creates a device type
    ///
    /// - Parameter identifier: The identifier of the device
    internal init(identifier: String) {
        
        for device in DeviceType.allCases {
            for deviceId in device.identifiers {
                guard identifier == deviceId else { continue }
                self = device
                return
            }
        }
        
        self = .notAvailable
    }
}

// MARK: - device type
public extension UIDevice {
    
    /// The `DeviceType` of the device in use
    var deviceType: DeviceType {
        return DeviceType.current
    }
}

#if swift(>=4.2)
#else

// MARK: - caseIterable 协议
internal protocol CaseIterable {
    associatedtype AllCases: Collection where AllCases.Element == Self
    static var allCases: AllCases { get }
}
//MARK： - hashable conform to CaseIterable
internal extension CaseIterable where Self: Hashable {
    static var allCases: [Self] {
        return [Self](AnySequence { () -> AnyIterator<Self> in
            var raw = -1
            return AnyIterator {
                raw += 1
                return withUnsafeBytes(of: &raw) { $0.load(as: Self.self) }
            }
        })
    }
}

#endif
//MARK: - judge Device type
public extension UIDevice {
    //是iPAD
    
    class var isIpad:Bool {
        return UIDevice().userInterfaceIdiom == .pad
    }
    // 是iPhone
    class var isIPhone:Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    //MARK: - 是carPlay
    class var isCarPlay:Bool {
        return UIDevice().userInterfaceIdiom == .carPlay
    }
    //MARK: - 是TV
    class var isTV:Bool {
        return UIDevice().userInterfaceIdiom == .tv
    }
    
    /**
 
 
    return a "bool ' whether the device is plugged in ,return false if not an iOS device
 
    */
    
    @objc  var isPluggedIn:Bool {
        #if os(iOS)
        return [.charging,.full].contains(UIDevice.current.batteryState)
        #else
        return false
        #endif
        
    }
}
//MARK: - check hasTopNotch and bottom indicator
public extension UIDevice {
    var hasTopNotch: Bool {
        // Notch: 44 on iPhone X, XS, XS Max, XR.
        // No Notch: 24 on iPad Pro 12.9" 3rd generation, 20 on iPhone 8
        if #available(iOS 11.0, *) {
            return UIApplication.sharedOrNil?.delegate?.window??.safeAreaInsets.top ?? 0 > 24
        } else {
            // Fallback on earlier versions
            
        }
        return false
    }

   
}
