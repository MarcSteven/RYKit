//
//  UIScrollView+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/5.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)

extension UIScrollView {
    
    /// swizzle zoom scale
    public class func swizzleZoomScale() {
        let originalMethod = class_getInstanceMethod(self, #selector(setter: minimumZoomScale))!
        let swizzleMethod = class_getInstanceMethod(self, #selector(swizzle_setMinimumZoomScale))!
        method_exchangeImplementations(originalMethod, swizzleMethod)
    }
    @objc dynamic func swizzle_setMinimumZoomScale(_ scale:CGFloat) {
        print("new value: \(scale)")
        self.swizzle_setMinimumZoomScale(scale)
    }
}
// MARK: - Methods
public extension UIScrollView {
    
    /// build
    /// - Parameter block: block
    /// - Returns: uiscroll view
    static func build(block:((UIScrollView)->Void)) ->UIScrollView {
        let scrollView = UIScrollView(frame: .zero)
        block(scrollView)
        return scrollView
    }
    //Original Source: https://gist.github.com/thestoics/1204051
    ///  Takes a snapshot of an entire ScrollView
    ///
    ///    AnySubclassOfUIScroolView().snapshot
    ///    UITableView().snapshot
    ///
    /// - Returns: Snapshot as UIimage for rendered ScrollView
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

#endif

#endif
extension UIScrollView {
    
    /// scroll on top
    /// - Parameter animated: <#animated description#>
    func scrollOnTop(animated:Bool = true ) {
        if #available(iOS 11.0, *) {
            setContentOffset(CGPoint(x: 0, y: -adjustedContentInset.top), animated: animated)
        } else {
            setContentOffset(CGPoint(x: 0, y: -contentInset.top), animated: animated)
        }
    }
}
public extension UIScrollView {
    
    /// scroll to bottom
    /// - Parameter animated: animated
    func scrollToBottom(_ animated:Bool)  {
        if self.contentSize.height < self.bounds.height {
            return
        }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.height)
        
        self.setContentOffset(bottomOffset, animated: animated)
    }
}
public extension UIScrollView {
    
    /// stop scrolling
    func stopScrolling() {
        guard isDragging else {
            return
        }
        var offset = contentOffset
        offset.y -= 1
        self.setContentOffset(offset, animated: false)
        offset.y += 1
        self.setContentOffset(offset, animated: false)
    }
}
extension UIScrollView {
    
    /// scroll direction
    public enum ScrollingDirection {
        case none
        case up
        case down
        case left
        case right
        case unknown
        
        /// is vertical
        public var isVertical: Bool {
            self == .up || self == .down
        }
        
        /// is horizontal
        public var isHorizontal: Bool {
            self == .left || self == .right
        }
    }

    /// The current scrolling direction of the scroll view.
    public var currentScrollingDirection: ScrollingDirection {
        let translation = panGestureRecognizer.translation(in: superview)

        if translation.y > 0 {
            return .down
        } else if !(translation.y > 0) {
            return .up
        }

        if translation.x > 0 {
            return .right
        } else if !(translation.x > 0) {
            return .left
        }

        return .unknown
    }
    
    /// is scrolling
    public var isScrolling: Bool {
        switch currentScrollingDirection {
            case .up, .down, .left, .right:
                return true
            case .none, .unknown:
                return false
        }
    }
}

extension UIScrollView {
    
    /// scroll to top
    /// - Parameter animated: animated
    open func scrollToTop(animated: Bool) {
        if #available(iOS 11.0, *) {
            setContentOffset(CGPoint(x: 0, y: -adjustedContentInset.top), animated: animated)
        } else {
            // Fallback on earlier versions
           
        }
    }
}

extension UIScrollView {
    private struct AssociatedKey {
        static var msGestureHandleEnable = "MSGestureHandlerEnable"
    }
    
    /// is gesture enable
    var isGestureEnable:Bool {
        get {
            (objc_getAssociatedObject(self, &AssociatedKey.msGestureHandleEnable) != nil)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.msGestureHandleEnable, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            
        }
        
    }
    
    /// gesture enable
    /// - Returns: if it's okay, return true
    public func ms_gestureEnable() ->Bool {
        return (objc_getAssociatedObject(self, &AssociatedKey.msGestureHandleEnable)as? NSNumber )?.boolValue ?? false
    }
    
    /// gesture delegate method
    /// - Parameter gestureRecognizer: gesture recognizer
    /// - Returns: if ok,return true
    public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if !ms_gestureEnable() {
            return true
        }
        if panBack(gestureRecognizer) {
            return false
        }
        return true
    }
    
    /// pan back
    /// - Parameter gestureRecognizer: gesture
    /// - Returns: if pan back,return true 
    private func panBack(_ gestureRecognizer:UIGestureRecognizer) ->Bool {
        if gestureRecognizer == panGestureRecognizer {
            let point = panGestureRecognizer.translation(in: self)
            let state = gestureRecognizer.state
            // set the location distance to edge
                        let locationDistance = UIScreen.main.bounds.size.width
                        if state == .began || state == .possible {
                            let location = gestureRecognizer.location(in: self)
                            if point.x > 0 && (location.x ) < locationDistance && contentOffset.x <= 0 {
                                return true
                           }
                        }
                    }
                    return false
        }
    }
