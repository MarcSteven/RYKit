//
//  AppConstant.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/1.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import Foundation
import UIKit

/// App 常量
public struct AppConstants {
    public static var φ: CGFloat { 0.618 }
    
    /// 状态栏高度
    public static var statusBarHeight:CGFloat {
        if #available(iOS 13.0 ,*) {
            return (UIApplication.shared.keyWindow?.safeAreaInsets.top)!
        }else {
        
            return UIApplication.shared.isStatusBarHidden ? 20
            : UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    /// navigationBar高度
    public static var navigationBarHeight:CGFloat {
        
        return 44
    }
    
    /// navigationContent 高度
    public static var navigationContentHeight:CGFloat {
        return statusBarHeight + navigationBarHeight
    }
      /// homeIndicator
    @available(iOS 13.0,*)
    public static var homeIndicator:CGFloat {
        return (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!
    }
    /// tabBar高度
    public static var tabBarHeight:CGFloat {
        return 49
    }
    /// UIControl高度
    public static var uiControlsHeight:CGFloat {return 50}
    //MARK: - search bar 高度
    public static var searchBarHeight:CGFloat {return uiControlsHeight}
    //留海高度
    public static var hairlINE:CGFloat  = 0.5
    
    /// title圆角半径
    public static var tileCornerRadius:CGFloat = 11
    
    /// 圆角半径
    public static var cornerRadius:CGFloat = 6
    
    /// 通常的颜色
   public  static var normalColor = UIColor.white
    
    /// 通常的透明度颜色
    public static var  normalAlphaColor = UIColor.init(white: 1.0, alpha: 0.5)
    
    /// 高亮颜色
    public static var  highlightColor = UIColor.init(red: 163.0/255.0, green: 243.0/255.0, blue: 16.0/255.0, alpha: 1.0)
    
    /// 高亮透明度颜色
    public static var highlightAlphaColor = UIColor.init(red: 163.0/255.0, green: 243.0/255.0, blue: 16.0/255.0, alpha: 0.24)
    
    /// wave宽度
    public static var  waveWidth = CGFloat(2.5)
    
    /// wave空间距离
    public static var  waveSpace = CGFloat(0.5)
    
    /// wave半径
    public static var  waveRadius = CGFloat(1.25)
    
    /// 向上最大高度
    public static var upMaxHeight = CGFloat(60)
    
    /// 向下最大高度
    public static var downMaxHeight = CGFloat(30)
    
    /// 上下间距
    public static var  upDownSpace = CGFloat(2)
    
   
    
    
    /// inchwormColor
    public static var inchWormColor:UIColor {
           return UIColor(hexString: "A3F310")
       }
    
    /// codGray
       public static var codGray:UIColor {
           return UIColor(hexString: "121212")
       }
    
    /// electricLimeColor
       public static var electricLimeColor:UIColor {
           return UIColor(hexString: " D1FA1A")
       }
    
    /// mineShaft24Color
       public static var mineShaft24Color:UIColor {
           return UIColor(hexString: "242424")
       }
    
    /// mineShaft36Color
       public static var mineShaft36Color:UIColor {
           return UIColor(hexString: "363636")
       }
    
    /// bittersweetColor
       public static var bittersweetColor  :UIColor {
           return UIColor(hexString: "727272")
       }
       
    
}
//Usage"
//let constant = AppConstants.inchWormColor



