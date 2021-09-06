//  YouthBomb
//
//  Created by Marc Steven on 2020/5/31.
//  Copyright © 2020 www.richandyoung.cn. All rights reserved.
//
import UIKit

/// 交换方法
/// - Parameter v: 视图类型
private func swizzle(_ v: UIView.Type) {

  [(#selector(v.traitCollectionDidChange(_:)), #selector(v.ry_traitCollectionDidChange(_:)))]
    .forEach { original, swizzled in
        
        /// 原方法
      guard let originalMethod = class_getInstanceMethod(v, original),
        let swizzledMethod = class_getInstanceMethod(v, swizzled) else { return }

      let didAddViewDidLoadMethod = class_addMethod(v,
                                                    original,
                                                    method_getImplementation(swizzledMethod),
                                                    method_getTypeEncoding(swizzledMethod))

      if didAddViewDidLoadMethod {
        class_replaceMethod(v,
                            swizzled,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod))
      } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
      }
  }
}

/// 已经交换
private var hasSwizzled = false


extension UIView {
    
    /// do bad swizzle stuff
  final public class func doBadSwizzleStuff() {
    guard !hasSwizzled else { return }

    hasSwizzled = true
    swizzle(self)
  }

  open override func awakeFromNib() {
    super.awakeFromNib()
    self.bindViewModel()
  }
    
    /// 绑定style
  @objc open func bindStyles() {
  }
    
    /// 绑定viewModel
  @objc open func bindViewModel() {
  }
    
    /// 默认的重用标识符
  public static var defaultReusableId: String {
    return String(describing: self)

  }
    
    /// trait Collection已经改变
    /// - Parameter previousTraitCollection: UITraitCollection
  @objc internal func ry_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection) {
    self.ry_traitCollectionDidChange(previousTraitCollection)
    self.bindStyles()
  }
}
