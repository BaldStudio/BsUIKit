//
//  UITabBarItem+.swift
//  BsUIKit
//
//  Created by changrunze on 2023/6/8.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

public extension SwiftX where T: UITabBarItem {
    
    func iconFont(_ icon: any BsIconFont,
                  fontSize: CGFloat,
                  color: UIColor? = nil,
                  for state: UIControl.State = .normal) {
        let icon = UIImage.bs.iconFont(icon, fontSize: fontSize, color: color)
        if state == .selected {
            this.selectedImage = icon
        } else {
            this.image = icon
        }
    }
    
}
