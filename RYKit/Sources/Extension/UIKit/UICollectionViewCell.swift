//
//  UICollectionViewCell.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    /// select
    /// - Parameters:
    ///   - animated: animated
    ///   - scrollPosition: Scroll position
    ///   - shouldNotifyDelegate: should notificatin delegate
    @objc open func select(animated:Bool,
                           scrollPosition: UICollectionView.ScrollPosition = [],
                           shouldNotifyDelegate:Bool) {
        guard let collectionView = collectionView,
            let _ = collectionView.indexPath(for: self)
        else {
            return
        }
        
    }
    
    /// collectionview 
    private var collectionView:UICollectionView? {
        responder()
    }
}
