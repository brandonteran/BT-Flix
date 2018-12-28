//
//  FlixNavigationController.swift
//  BT-Flix
//
//  Created by Teran on 12/28/18.
//  Copyright © 2018 BT Apps. All rights reserved.
//

import UIKit

class FlixNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
