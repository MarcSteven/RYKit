//
//  UICollectionViewExtension.swift
//  RYKit
//
//  Created by Marc Steven on 2020/7/4.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import UIKit



public extension UICollectionView {
    
    
    
    ///    清楚所有已选中的item的选中状态
    func clearSelection() {
        guard let selectedItemIndexPath = indexPathsForSelectedItems else {
            return
        }
        for indexPath in selectedItemIndexPath {
            deselectItem(at: indexPath, animated: true)
        }
        
        
    }
    ///保持选中的状态重新加载数据
    func reloadDataKeepingSelection() {
        guard let selectedIndexPath = indexPathsForSelectedItems else {
            return
        }
        reloadData()
        for indexPath in selectedIndexPath {
            selectItem(at: indexPath, animated: false, scrollPosition: [])
        }
    }
    /// 查找view 在哪个cell中，不存在返回nil
    private func parentCell(for view:UIView) ->UICollectionViewCell? {
        if view.superview == nil {
            return nil
        }
        if let cell = view.superview as? UICollectionViewCell {
            return cell
        }
        return parentCell(for: view.superview!)
    }
    /// 获取某个view是某个cell的子视图，在这个view的点击事件里回调方法 返回的indexPath可能为nil所以要注意保护
    func indexPathForItem(at view:UIView) ->IndexPath? {
        if let parentCell = parentCell(for: view) {
            return indexPath(for: parentCell)
        }
        return nil
    }
    /// 获取当前的item是否是可见的
    func isItemVisiable(at indexPath:IndexPath) ->Bool {
        for visibleIndexPath in indexPathsForVisibleItems {
            if indexPath == visibleIndexPath {
                return true
            }
        }
        return false
    }
    /// 获取可视   区域内的第一个cell的indexpath
    
    func indexPathForFirstVisibleCell() ->IndexPath? {
        let visibleIndexPaths = indexPathsForVisibleItems
        if visibleIndexPaths.isEmpty {
            return nil
        }
        var minimunIndexPath:IndexPath?
        for indexPath in visibleIndexPaths {
            if minimunIndexPath == nil {
                minimunIndexPath = indexPath
                continue
            }
            if indexPath.section < minimunIndexPath?.section ?? 0 {
                minimunIndexPath = indexPath
                continue
            }
            if indexPath.item < minimunIndexPath?.item ?? 0 {
                minimunIndexPath = indexPath
                continue
            }
        }
        return minimunIndexPath
    }
    
}
