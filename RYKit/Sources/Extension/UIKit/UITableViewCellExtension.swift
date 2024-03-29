//
//  UITableViewCellExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/30.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    
    /// layout margins
    override  var layoutMargins:UIEdgeInsets {
        get {
            return UIEdgeInsets.zero
        }
        set {}
    }
    
    /// tableview 
    var tableView:UITableView? {
        return parentView(of: UITableView.self)
    }
    
    
    

}

