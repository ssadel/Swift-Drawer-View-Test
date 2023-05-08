//
//  CustomScrollViewDelegate.swift
//  test
//
//  Created by Sidney Sadel on 5/8/23.
//

import UIKit

private var CustomDelegateAssociationKey: UInt8 = 0

extension UIScrollView {
    var customDelegate: CustomScrollViewDelegate? {
        get {
            return objc_getAssociatedObject(self, &CustomDelegateAssociationKey) as? CustomScrollViewDelegate
        }
        set {
            objc_setAssociatedObject(self, &CustomDelegateAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class CustomScrollViewDelegate: NSObject, UIScrollViewDelegate {
    var onScroll: ((_ scrollView: UIScrollView) -> Void)?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onScroll?(scrollView)
    }
}
