//
//  UIBarButtonItem+.swift
//  BsUIKit
//
//  Created by changrunze on 2023/6/8.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

public extension SwiftX where T: UIBarButtonItem {
    
    func iconFont(_ icon: any BsIconFont, fontSize: CGFloat, color: UIColor? = nil) {
        this.image = UIImage.bs.iconFont(icon, fontSize: fontSize, color: color)
    }
    
}
