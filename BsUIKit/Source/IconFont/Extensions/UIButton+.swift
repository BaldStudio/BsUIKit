//
//  UIButton+.swift
//  BsUIKit
//
//  Created by changrunze on 2023/6/8.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

public extension SwiftX where T: UIButton {
    
    func iconFont(_ icon: any BsIconFont,
                  fontSize: CGFloat,
                  color: UIColor? = nil,
                  for state: UIControl.State = .normal) {
        let image = UIImage.bs.iconFont(icon, fontSize: fontSize, color: color)
        this.setImage(image, for: state)
    }
    
}
