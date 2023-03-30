//
//  UIFont+.swift
//  BsUIKit
//
//  Created by changrunze on 2023/6/8.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit

public extension UIFont {
    convenience init?(iconFont: BsIconFontRepresentable, size: CGFloat) {
        if UIFont.fontNames(forFamilyName: iconFont.name).isEmpty,
           let path = iconFont.path {
            logger.info("尝试注册字体，path: \(path)")
            Self.registerFont(with: path)
        }
        self.init(name: iconFont.name, size: size)
    }
}

private extension UIFont {
    
    @discardableResult
    static func registerFont(with path: String) -> Bool {
        var isDir = ObjCBool(false)
        guard FileManager.default.fileExists(atPath: path,
                                             isDirectory: &isDir),
                !isDir.boolValue else {
            logger.error("字体文件的路径不合法，path: \(path)")
            return false
        }
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterFontsForURL(URL(fileURLWithPath: path) as CFURL,
                                             .process,
                                             &error) {
            if let error = error?.takeUnretainedValue() {
                logger.error("字体注册失败，error: \(error.localizedDescription)")
            } else {
                logger.error("字体注册失败，error: Unknown")
            }
            return false
        }
        
        return true
    }
}
