//
//  BsIconFont.swift
//  BsUIKit
//
//  Created by changrunze on 2023/6/8.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit

public typealias BsIconFontAttributes = [NSAttributedString.Key : Any]

public protocol BsIconFont: BsIconFontRepresentable, CaseIterable, RawRepresentable where RawValue == String {}

public extension BsIconFont {
    
    var unicode: String {
        rawValue
    }
    
}
