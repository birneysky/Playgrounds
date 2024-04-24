//
//  UIViewController+Nib.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/4/24.
//

import UIKit

extension UIViewController {
    @objc static func controller() -> Self {
        return Self.init(nibName: String(describing: Self.self), bundle: nil)
    }
}

extension UIView {
    @objc static func view() -> Self {
        let nib = UINib(nibName:String(describing: Self.self), bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! Self
        return view
    }
    
    
}
