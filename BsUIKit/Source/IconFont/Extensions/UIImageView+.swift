//
//  UIImageView+.swift
//  BsUIKit
//
//  Created by changrunze on 2023/6/8.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

public extension SwiftX where T: UIImageView {
    
    func iconFont(_ icon: any BsIconFont, fontSize: CGFloat, color: UIColor? = nil) {
        this.image = UIImage.bs.iconFont(icon, fontSize: fontSize, color: color)
    }
    
    func iconFont(_ icon: any BsIconFont, imageSize: CGSize? = nil, color: UIColor? = nil) {
        this.image = UIImage.bs.iconFont(icon, imageSize: imageSize ?? this.frame.size, color: color)
    }
    
}
