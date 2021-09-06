//
//  NonHighlightableCell.swift
//  RYKit
//
//  Created by Marc Steven on 2020/8/21.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import UIKit

public protocol NonHighlightableCell {
    func noSelectionStyle()
}

extension UITableViewCell:NonHighlightableCell {
    public func noSelectionStyle() {
        self.selectionStyle = .none
    }
}
