//
//  UITableViewCell+Extension.swift
//  YouthBomb
//
//  Created by Marc Steven on 2020/5/23.
//  Copyright © 2020 www.richandyoung.cn. All rights reserved.
//

import UIKit


extension UITableViewCell {
    /// - hidden the separator line
    func hideSeparatorLine(_ isHidden:Bool) {
        let subviews = self.subviews
        for view in subviews {
            if view.classForCoder.description() == "_UITableViewCellSeparatorView" {
                view.isHidden = isHidden
            }
        }
    }
}
