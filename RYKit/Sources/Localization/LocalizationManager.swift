//
//  LocalizationManager.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/12.
//  Copyright © 2020 Marc Steven All rights reserved.
//


import Foundation
import UIKit
//MARK: -国际化管理者，用于进行对应的国际化
open class  LocalizationManager:NSObject {
    /// bundle
    var bundle: Bundle!
    
    //MARk： - 单例对象
    class var sharedInstance: LocalizationManager {
        struct Singleton {
            static let instance: LocalizationManager = LocalizationManager()
        }
        return Singleton.instance
    }
    
    //初始化方法
    override init() {
        super.init()
        bundle = Bundle.main
    }
    // 国际化字符串，根据对应的key
   open func localizedStringForKey(key:String, comment:String) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }
    // 国际化图像
   open  func localizedImagePathForImg(imagename:String, type:String) -> String {
        guard let imagePath =  bundle.path(forResource: imagename, ofType: type) else {
            return ""
        }
        return imagePath
    }
    
    // setLanguage
    // Sets the desired language of the ones you have.
    // If this function is not called it will use the default OS language.
    // If the language does not exists y returns the default OS language.
   open func setLanguage(languageCode:String) {
        var appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        appleLanguages.remove(at: 0)
        appleLanguages.insert(languageCode, at: 0)
        UserDefaults.standard.set(appleLanguages, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize() //needs restrat
        
        if let languageDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj")  {
            bundle = Bundle.init(path: languageDirectoryPath)
        } else {
            resetLocalization()
        }
    }
    
   
    //Resets the localization system, so it uses the OS default language.
    open func resetLocalization() {
        bundle = Bundle.main
    }
    
    
    // Just gets the current setted up language.
   open  func getLanguage() -> String {
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let prefferedLanguage = appleLanguages[0]
        if prefferedLanguage.contains("-") {
            let array = prefferedLanguage.components(separatedBy: "-")
            return array[0]
        }
        return prefferedLanguage
    }
    
}
