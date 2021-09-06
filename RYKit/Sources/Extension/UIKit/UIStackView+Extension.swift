//
//  UIStackView+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/5.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)

public extension UIStackView {
    
    ///  Initialize an UIStackView with an array of UIView and common parameters.
    ///
    ///     let stackView = UIStackView(arrangedSubviews: [UIView(), UIView()], axis: .vertical)
    ///
    /// - Parameters:
    ///   - arrangedSubviews: The UIViews to add to the stack.
    ///   - axis: The axis along which the arranged views are laid out.
    ///   - spacing: The distance in points between the adjacent edges of the stack view’s arranged views.(default: 0.0)
    ///   - alignment: The alignment of the arranged subviews perpendicular to the stack view’s axis. (default: .fill)
    ///   - distribution: The distribution of the arranged views along the stack view’s axis.(default: .fill)
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0.0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
         
       

    }


    extension UIStackView {
        /// Adds the list of views to the end of the `arrangedSubviews` array.
        ///
        /// - Parameter subviews: The views to be added to the array of views arranged
        ///                       by the stack view.
        public func addArrangedSubviews(_ subviews: [UIView]) {
            subviews.forEach {
                addArrangedSubview($0)
            }
        }
    }

    extension UIStackView {
        
        /// remove all arranged subviews
        public func removeAllArrangedSubviews() {
            arrangedSubviews.forEach {
                $0.removeFromSuperview()
            }
        }
    }
//MARK: - add space 
extension UIStackView {
    
    /// add spacing
    /// - Parameters:
    ///   - spacing: spacing
    ///   - arrangedSubview: arranged subview
    func addSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
      if #available(iOS 11.0, *) {
        self.setCustomSpacing(spacing, after: arrangedSubview)
      } else {
        let separatorView = UIView(frame: .zero)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        switch axis {
        case .horizontal:
          separatorView.widthAnchor.constraint(equalToConstant: spacing).isActive = true
        case .vertical:
          separatorView.heightAnchor.constraint(equalToConstant: spacing).isActive = true
        @unknown default:
            fatalError("error")
        }
        if let index = self.arrangedSubviews.firstIndex(of: arrangedSubview) {
          insertArrangedSubview(separatorView, at: index + 1)
        }
      }
    }

}

   



#endif
#endif

