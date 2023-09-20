//
//  UIImage+.swift
//  BsUIKit
//
//  Created by changrunze on 2023/6/8.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

public extension SwiftX where T: UIImage {
    
    static func iconFont(_ icon: any BsIconFont, fontSize: CGFloat, color: UIColor? = nil) -> UIImage? {
        let attributedString = NSAttributedString.bs.iconFont(icon, fontSize: fontSize, color: color)
        let rect = attributedString.boundingRect(with: [.infinity, fontSize],
                                                 options: .usesLineFragmentOrigin,
                                                 context: nil)
        let format = UIGraphicsImageRendererFormat().then {
            $0.scale = UIScreen.main.scale
            $0.opaque = false
        }
        
        return UIGraphicsImageRenderer(bounds: rect, format: format).image { _ in
            attributedString.draw(in: rect)
        }
    }
    
    static func iconFont(_ icon: any BsIconFont, imageSize: CGSize, color: UIColor? = nil) -> UIImage? {
        var attributes = BsIconFontAttributes()
        attributes[.font] = UIFont(iconFont: icon, size: 1)
        if let color = color {
            attributes[.foregroundColor] = color
        }
        var attributedString = NSAttributedString(string: icon.unicode, attributes: attributes)
    
        let rect = attributedString.boundingRect(with: [.infinity, 1],
                                                 options: .usesLineFragmentOrigin,
                                                 context: nil)
        
        let widthScale = imageSize.width / rect.width
        let heightScale = imageSize.height / rect.height
        let scale = (widthScale < heightScale) ? widthScale : heightScale
        
        let scaledWidth = rect.width * scale
        let scaledHeight = rect.height * scale
        
        var anchorPoint = CGPoint.zero
        if(widthScale < heightScale){
            anchorPoint.y = (imageSize.height - scaledHeight) / 2
        } else {
            anchorPoint.x = (imageSize.width - scaledWidth) / 2
        }
        
        var anchorRect = CGRect.zero
        anchorRect.origin = anchorPoint
        anchorRect.size.width = scaledWidth
        anchorRect.size.height = scaledHeight
        
        attributes[.font] = UIFont(iconFont: icon, size: scale)
        attributedString = NSAttributedString(string: icon.unicode, attributes: attributes)
        
        let format = UIGraphicsImageRendererFormat().then {
            $0.scale = UIScreen.main.scale
            $0.opaque = false
        }
        
        return UIGraphicsImageRenderer(bounds: anchorRect, format: format).image { _ in
            attributedString.draw(in: anchorRect)
        }
    }

    static func iconFont(_ icon: any BsIconFont, fontSize: CGFloat, attributes: BsIconFontAttributes) -> UIImage? {
        let attributedString = NSAttributedString(string: icon.unicode, attributes: attributes)
        let rect = attributedString.boundingRect(with: [.infinity, fontSize],
                                                 options: .usesLineFragmentOrigin,
                                                 context: nil)
        let format = UIGraphicsImageRendererFormat().then {
            $0.scale = UIScreen.main.scale
            $0.opaque = false
        }
        
        return UIGraphicsImageRenderer(bounds: rect, format: format).image { _ in
            attributedString.draw(in: rect)
        }
    }
}
