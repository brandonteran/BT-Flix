//
//  UINavigationController+Extensions.swift
//  BT-Flix
//
//  Created by Teran on 12/28/18.
//  Copyright © 2018 BT Apps. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func setNavigationBarProperties(tintColor: UIColor?, barTintColor: UIColor?, shadowColor: UIColor?, shadowRadius: CGFloat?, shadowOpacity: Float?, shadowOffset: CGSize?) {
        self.navigationBar.isTranslucent       = false
        self.navigationBar.layer.masksToBounds = false
        self.navigationBar.shadowImage         = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        if let tintColor = tintColor {
            navigationBar.tintColor = tintColor
        }
        
        if let barTintColor = barTintColor {
            navigationBar.barTintColor = barTintColor
        }
        
        if let shadowColor = shadowColor {
            navigationBar.layer.shadowColor = shadowColor.cgColor
        }
        
        if let shadowRadius = shadowRadius {
            navigationBar.layer.shadowRadius = shadowRadius
        }
        
        if let shadowOpacity = shadowOpacity {
            navigationBar.layer.shadowOpacity = shadowOpacity
        }
        
        if let shadowOffset = shadowOffset {
            navigationBar.layer.shadowOffset = shadowOffset
        }
    }
}
