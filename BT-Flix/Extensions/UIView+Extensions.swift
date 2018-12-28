//
//  UIView+Extensions.swift
//  BT-Flix
//
//  Created by Teran on 12/20/18.
//  Copyright © 2018 BT Apps. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    func setProperties(backgroundColor: UIColor?, shadowColor: UIColor?, shadowRadius: CGFloat?, shadowOpacity: Float?, shadowOffset: CGSize?) {
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        if let shadowColor = shadowColor {
            layer.shadowColor = shadowColor.cgColor
        }
        
        if let shadowRadius = shadowRadius {
            layer.shadowRadius = shadowRadius
        }
        
        if let shadowOpacity = shadowOpacity {
            layer.shadowOpacity = shadowOpacity
        }
        
        if let shadowOffset = shadowOffset {
            layer.shadowOffset = shadowOffset
        }
    }
}
