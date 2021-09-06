//
//  UICollectionView+Scroll.swift
//  YouthBomb
//
//  Created by Marc Steven on 2020/5/23.
//  Copyright © 2020 www.richandyoung.cn. All rights reserved.
//

import UIKit

/// - Method to auto scroll to next cell
extension UICollectionView {
    
    /// auto scroll to next cell
    func autoScrollToNextCell() {
        //get cell size
        let cellSize = CGSize(width: self.frame.width, height: self.frame.height)
        //get current content Offset of the Collection view
        let contentOffset = self.contentOffset
        //scroll to next cell
        self.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
    }
}
