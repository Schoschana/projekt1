//
//  UIApplication.swift
//  frog
//
//  Created by Lili on 01/05/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainTabBarController? {
        //UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
        
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}
