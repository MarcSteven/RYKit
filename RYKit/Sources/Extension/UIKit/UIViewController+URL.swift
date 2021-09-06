//
//  UIViewController+URL.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/11/25.
//  Copyright © 2019 Memory Chain network technology(China) co,LTD. All rights reserved.
//

import UIKit
import SafariServices



public extension UIViewController {
    
    /// supported url schemes
    static var supportedURLSchemes = ["http","https"]
    
    /// go to
    /// - Parameter url: url
    func goTo(url:URL) {
        if let scheme = url.scheme?.lowercased(), UIViewController.supportedURLSchemes.contains(scheme) {
            let controller = SFSafariViewController(url: url)
            controller.modalPresentationStyle = .overFullScreen
            self.present(controller, animated:true)
        } else  {
            
        }
    }
}
