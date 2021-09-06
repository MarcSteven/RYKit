//  YouthBomb
//
//  Created by Marc Steven on 2020/5/31.
//  Copyright © 2020 www.richandyoung.cn. All rights reserved.
//
/// A type that represents a cell that can be reused and configured with a value.
public protocol ValueCell: class {
//     关联值
  associatedtype Value
    
    /// 默认的重用标识符
  static var defaultReusableId: String { get }
    
    /// 使用value来配置
    /// - Parameter value: value
  func configureWith(value: Value)
}
