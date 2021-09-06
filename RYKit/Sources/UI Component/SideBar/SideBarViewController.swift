//
//  SideBarViewController.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/9/23.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit

/// sideBar 视图控制器
open class SideBarViewController:UIViewController {
    //MARK: - properties
    
    /// 左边视图控制器
    public var leftViewController:UIViewController!
    
    /// 主视图控制器
    public var mainViewControler:UIViewController!
    
    /// 重叠
    public var overlap:CGFloat!
    
    /// 滚动视图
    public var scrollView:UIScrollView!
    
    /// 是否是第一次
    public var firstTime:Bool = true
    
    /// 初始化器
    /// - Parameter aDecoder: coder
    public required init?(coder aDecoder: NSCoder) {
        assert(false, "use init(leftViewcontroller:mainViewController:overlap")
        super.init(coder: aDecoder)
    }
    
    /// 初始化器
    /// - Parameters:
    ///   - leftViewController: 左边视图
    ///   - mainViewController: 主视图
    ///   - overlap: 重叠
    init(leftViewController:UIViewController,
         mainViewController:UIViewController,
         overlap:CGFloat) {
        self.leftViewController = leftViewController
        self.mainViewControler  =  mainViewController
        self.overlap = overlap
        
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor.black
        setupScrollView()
        setupViewControllers()
    }
    override open func viewDidLayoutSubviews() {
        if firstTime {
            firstTime = false
            closeMenuAniamted(false)
        }
    }
    
    /// 安装scrollView
    func setupScrollView() {
        scrollView = UIScrollView()
        
        
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]", options: [], metrics: nil, views: ["scrollView":scrollView as Any])
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]", options: [], metrics: nil, views: ["scrollView":scrollView as Any])
        NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints)
        //Add gestureRecognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapRecognizer:)))
        tapRecognizer.delegate = self
        view.addGestureRecognizer(tapRecognizer)
        
    }
    
    /// 视图已经被点击
    /// - Parameter tapRecognizer: tap手势
    @objc func viewTapped(tapRecognizer:UITapGestureRecognizer) {
        closeMenuAniamted(true)
    }
    
    /// 安装视图控制器
    func setupViewControllers() {
        addViewController(leftViewController)
        addViewController(mainViewControler)
        addShadowView(mainViewControler.view)
        
        let views:[String:UIView] = [
            "left":leftViewController.view,
            "main":mainViewControler.view,
            "outer":view]
        
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|[left][main(==outer)]|", options: [.alignAllTop,.alignAllBottom], metrics: nil, views: views)
        let leftWidthConstraint = NSLayoutConstraint(item: leftViewController.view as Any, attribute: .width,relatedBy:.equal , toItem: view, attribute: .width, multiplier: 1.0, constant: -overlap)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[main(==outer)]|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints + [leftWidthConstraint])
        
    }
    
    /// 切换左边菜单动画
    /// - Parameter animated: 是否有动画
    func  toggleLeftMenuAnimated(_ animated:Bool)  {
        if leftMenuIsOpen() {
            closeMenuAniamted(animated)
            
        }else {
            openLeftMenuAnimated(animated)
        }
    }
    
    /// 关闭菜单动画
    /// - Parameter animated: 是否动画
   public func closeMenuAniamted(_ animated:Bool) {
        scrollView.setContentOffset(CGPoint(x: leftViewController.view.frame.width, y: 0), animated: animated)
    }
    
    /// 打开左边菜单动画
    /// - Parameter animated: 是否有动画
    public func openLeftMenuAnimated( _ animated:Bool) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
    }
    
    /// 左边菜单是否打开
    /// - Returns: 如果打开则返回true，否则返回false
    func leftMenuIsOpen() ->Bool {
        return scrollView.contentOffset.x == 0
    }
    
    /// 添加视图控制器
    /// - Parameter viewController: 视图控制器
    fileprivate func addViewController(_ viewController:UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(viewController.view)
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    /// 添加阴影视图
    /// - Parameter destinationView: 目的视图
    fileprivate func addShadowView(_ destinationView:UIView) {
        destinationView.layer.shadowPath = UIBezierPath(rect: destinationView.bounds).cgPath
        destinationView.layer.shadowRadius = 2.0
        destinationView.layer.shadowOffset = CGSize(width: 0, height: 0)
        destinationView.layer.shadowOpacity  = 1.0
        destinationView.layer.shadowColor = UIColor.black.cgColor
        
    }
    
}
//MARK: - UIGestrue Tap delegate
extension SideBarViewController :UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let tapLocation = touch.location(in: view)
        let tapWasInOverlapArea = tapLocation.x >= view.bounds.width - overlap
        return tapWasInOverlapArea && leftMenuIsOpen()
    }
}
