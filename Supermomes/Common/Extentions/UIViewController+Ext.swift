//
//  UIViewController+Ext.swift
//  Supermomes
//
//  Created by Dinh Le on 8/6/21.
//

import UIKit
extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
}
