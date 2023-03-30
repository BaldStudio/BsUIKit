//
//  BsIconFontRepresentable.swift
//  BsUIKit
//
//  Created by changrunze on 2023/6/8.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import Foundation

private class IconFontAnchor {}

public protocol BsIconFontRepresentable {
    // ttf文件名
    var name: String { get }
    
    // 文件路径
    var path: String? { get }
    
    // icon原始值
    var unicode: String { get }
}

public extension BsIconFontRepresentable {
    var path: String? {
        if let path = Bundle.main.path(forResource: name, ofType: "ttf") {
            return path
        }
        
        if let path = Bundle(for: IconFontAnchor.self).path(forResource: name, ofType: "ttf") {
            return path
        }
        
        return nil
    }
}
