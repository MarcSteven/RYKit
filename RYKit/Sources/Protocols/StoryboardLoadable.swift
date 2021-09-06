//
//  StoryboardLoadable.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/31.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit
/// Storyboard 加载协议
public protocol StoryboardLoadable {
    /// storyboard name
    static var storyboardName:String { get }
    /// storyboard 标识符
    static var storyboardIdentifier:String { get}
}
/// UIViewController  conform to the UIStoryboardLoading protocol
extension StoryboardLoadable where Self:UIViewController {
    ///  Default implemente
    public static var storyboardName:String {
        return String(describing: self)
    }
    
    /// storyboard identifier
    public static var storyboardIdentifier:String {
        return String(describing: self)
    }
    /// 实例化-通过storyBoard的名字
    public static func instantiate(fromStoryboardName name:String? = nil) ->Self {
        let storyboardName = name ?? self.storyboardName
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return instantiate(fromStoryboard: storyboard)
        
    }
    /// 实例化通过UIStoryboard
    public static func instantiate(fromStoryboard storyboard:UIStoryboard) ->Self {
        let identifier = self.storyboardIdentifier
        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Failed to instantiate view controller with identifier = \(identifier) from storyboard")
        }
        return vc
    }
    /// 初始化-通过storyboard name
    public static func initial(fromStoryboardNamed name: String? = nil) -> Self {
        let sb = name ?? self.storyboardName
        let storyboard = UIStoryboard(name: sb, bundle: nil)
        return initial(fromStoryboard: storyboard)
    }
    /// 初始化通过Storyboard
    public static func initial(fromStoryboard storyboard: UIStoryboard) -> Self {
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Failed to instantiate initial view controller from storyboard named \( storyboard )")
        }
        return vc
    }

}
/// UINavigationController 遵守storyboard加载协议
extension UINavigationController:StoryboardLoadable {}
/// UITabBarController 遵守storyboard加载协议
extension UITabBarController:StoryboardLoadable {}
/// - UISplitView Controller来遵守storyboard加载协议
extension UISplitViewController :StoryboardLoadable {}
/// - UIPageViewController 遵从storyboard加载协议
extension UIPageViewController :StoryboardLoadable {}
