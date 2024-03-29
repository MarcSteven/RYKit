//
//  UIScreen+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/5.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit
//MARK: - properties
public extension UIScreen {
    class var screenWidth:CGFloat {
        return UIScreen.main.bounds.size.width
    }
    class var nativeBoundsHeight:CGFloat {
        return UIScreen.main.nativeBounds.height
    }
    class var screenHeight:CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    
}
