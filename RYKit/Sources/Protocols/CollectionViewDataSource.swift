//
//  CollectionViewDataSource.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/11.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit
/**  collectionView dataSource 协议*/
public protocol CollectionViewDataSource {
    /// section的数量
    func numberOfSections(in collectionView:UICollectionView) ->Int
    
    /// section内的item数量
    func collectionView(_ collectionView:UICollectionView,
                        numberOfItemsInSection section:Int) ->Int
    /// Cell 对应的Item
    func collectionView( _ collectionView:UICollectionView,
                         cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    /// Item是否可移动
    func collectionView( _ collectionView:UICollectionView,
                         canMoveItemAt indexPath:IndexPath) ->Bool
    /// 移动item到对应的位置
    mutating func collectionView(_ collectionView:UICollectionView,
                                 moveItemAt sourceIndexPath:IndexPath,to destinationIndexPath:IndexPath)
}
/// Sections
public extension CollectionViewDataSource {
    /// 默认实现
    func numberOfSections(in collectionView:UICollectionView) ->Int {
        return 1
    }
    
}
/// Moving
public extension CollectionViewDataSource {
    func collectionView(_ collectionView:UICollectionView,
                        canMoveItemAt indexPath:IndexPath) ->Bool {
        return false
    }
    mutating func collectionView(_ collectionView:UICollectionView,moveItemAt sourceIndexPath:IndexPath,to destinationIndexPath:IndexPath) {
        
    }
}

