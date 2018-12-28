//
//  FlixTabBarController.swift
//  BT-Flix
//
//  Created by Teran on 12/28/18.
//  Copyright © 2018 BT Apps. All rights reserved.
//

import UIKit

class FlixTabBarController: UITabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    private func setupTabBarProperties() {
        self.tabBar.barTintColor        = #colorLiteral(red: 0.1462399662, green: 0.1462444067, blue: 0.1462419927, alpha: 1)
        self.tabBar.tintColor           = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.tabBar.isTranslucent       = false
        self.tabBar.shadowImage         = UIImage()
        self.tabBar.backgroundImage     = UIImage()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        self.setupTabBarProperties()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
