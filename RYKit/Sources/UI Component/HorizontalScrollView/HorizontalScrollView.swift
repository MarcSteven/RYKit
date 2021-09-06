//
//  HorizontalScrollView.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/12.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

/// 水平滚动视图数据源代理
public protocol HorizontalScrollViewDataSource:class {
    /// 视图的数量
    func numberOfViews( in horizontalScrollView:HorizontalScrollView) ->Int
    /// 水平滚动视图所在的视图
    func horizontalScrollView(_ horizontalScrollView:HorizontalScrollView, viewAt index:Int) ->UIView
}
/// 水平滚动视图代理
public protocol HorizontalScrollViewDelegate:class {
    /// 水平滚动视图已经选择了视图
    func horizontalScrollerView(_ horizontalScrollerView:HorizontalScrollView,didSelectViewAt index:Int)
}
/// 水平滚动视图
open class HorizontalScrollView:UIView {
    weak var dataSource:HorizontalScrollViewDataSource?
    weak var delegate:HorizontalScrollViewDelegate?
    
    /// view constants
    private enum ViewConstants {
        static let padding:CGFloat = 10
        static let dimensions:CGFloat = 100
        static let offset :CGFloat = 100
    }
    
    /// scrollview
    private let scroller = UIScrollView()
    
    /// content view
    private var contentViews = [UIView]()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /// 初始化滚动视图
    func initializeScrollView() {
        scroller.delegate = self
        addSubview(scroller)
        scroller.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroller.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scroller.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scroller.topAnchor.constraint(equalTo: self.topAnchor),
            scroller.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                                     ])
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollerTapped(gesture:)))
        scroller.addGestureRecognizer(tapGestureRecognizer)
    }
    
    /// scroller did tap
    /// - Parameter gesture: tap gesture
    @objc func scrollerTapped(gesture:UITapGestureRecognizer) {
        let location = gesture.location(in: scroller)
        guard let index = contentViews.firstIndex(where:{$0.frame.contains(location)}) else {
            return
        }
        delegate?.horizontalScrollerView(self, didSelectViewAt: index)
    }
    /// 返回对应index的视图
    func view(at index:Int) ->UIView {
        return contentViews[index]
    }
    /// reload方法
    func reload() {
        guard let dataSource = dataSource else {
            return
        }
        contentViews.forEach{ $0.removeFromSuperview()}
        var xValue = ViewConstants.offset
        contentViews = (0..<dataSource.numberOfViews(in: self)).map {
            index in
            xValue += ViewConstants.padding
            let view = dataSource.horizontalScrollView(self, viewAt: index)
            view.frame = CGRect(x: CGFloat(xValue), y: ViewConstants.padding, width: ViewConstants.dimensions, height: ViewConstants.dimensions)
            scroller.addSubview(view)
            xValue += ViewConstants.dimensions + ViewConstants.padding
            return view
        }
        scroller.contentSize = CGSize(width: CGFloat(xValue + ViewConstants.offset), height: frame.size.height)
        
    }
    /// 把当前的视图放置在中间
    private func centerCurrentView() {
        let centerRect = CGRect(origin: CGPoint(x: scroller.bounds.midX - ViewConstants.padding, y: 0), size: CGSize(width: ViewConstants.padding, height: bounds.height))
        guard let selectedIndex = contentViews.firstIndex(where:{$0.frame.intersects(centerRect)}) else {
            return
        }
        let centralView = contentViews[selectedIndex]
        let targetCenter = centralView.center
        let targetOffsetX = targetCenter.x - (scroller.bounds.width / 2)
        scroller.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
        delegate?.horizontalScrollerView(self, didSelectViewAt: selectedIndex)
        
    }
    
    
}
extension HorizontalScrollView:UIScrollViewDelegate {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerCurrentView()
        }
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerCurrentView()
    }
}
