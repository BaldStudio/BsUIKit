//
//  NSAttributedString+.swift
//  BsUIKit
//
//  Created by changrunze on 2023/6/8.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

public extension SwiftX where T: NSAttributedString {
    
    static func iconFont(_ icon: any BsIconFont, fontSize: CGFloat, color: UIColor? = nil) -> NSAttributedString {
        var attributes = BsIconFontAttributes()
        attributes[.font] = UIFont(iconFont: icon, size: fontSize)
        if let color = color {
            attributes[.foregroundColor] = color
        }
        return NSAttributedString(string: icon.unicode, attributes: attributes)
    }
    
}
