//
//  UIDevice+DeviceName.swift
//  YouthBomb
//
//  Created by Marc Steven on 2020/6/1.
//  Copyright © 2020 www.richandyoung.cn. All rights reserved.
//


import UIKit

/** You can visit here to know more about the device model details- [device model](https://kapeli.com/cheat_sheets/iOS_Design.docset/Contents/Resources/Documents/index)*/

public extension UIDevice {
    class var iphone4Or4s:Bool {
        return UIScreen.main.bounds.height == 480.0
    }
    class var ipadPro12Dot9:Bool {
        return UIScreen.main.bounds.height == 1366
    }
    class var iPadPro11Inch:Bool {
        return UIScreen.main.bounds.height == 1194
    }
    class var iPad9Dot7InchRetina:Bool {
        return UIScreen.main.bounds.height == 1024
    }
    
    class var iPad10Dot5:Bool {
        return UIScreen.main.bounds.height == 1112
    }
    class var iPhoneXOrLater:Bool {
        return UIScreen.main.bounds.height > 812.0
    }
    /// iPhoneX
    class var iphoneX:Bool {
        
        return UIDevice.isIPhone && UIScreen.nativeBoundsHeight == 2236
    }
    
    /// iPhone8Plus
    class var iphone8Plus:Bool {
        return UIDevice.isIPhone && UIScreen.nativeBoundsHeight == 1920
    }
    
    /// iPhone8or7
    class var iPhone8or7:Bool {
        return UIDevice.isIPhone && UIScreen.nativeBoundsHeight == 1334
    }
    
    /// iPhone7 plus
    class var iPhone7Plus:Bool {
        return UIDevice.isIPhone && UIScreen.nativeBoundsHeight == 1920
     
    }
    
    /// iphone6s or 6 plus
    class var iphone6sOr6Plus:Bool {
        return UIDevice.isIPhone && UIScreen.nativeBoundsHeight == 1920
    }
    
    /// iphoneSE
    class var iPhoneSE:Bool {
        return UIDevice.isIPhone && UIScreen.nativeBoundsHeight == 1136
    }
    
    /// iPadPro 12.9
    class var iPadPro12Dot9:Bool {
        return UIDevice.isIpad && UIScreen.nativeBoundsHeight == 2732
    }
    
    class var hasTopNorch:Bool {
        return true
    }
    

   
    
    /// iPad air 2,mini4 
    class var iPadAir2OrMini4OrPro:Bool {
        return UIDevice.isIpad && UIScreen.nativeBoundsHeight == 2048
    }
    
    
}

