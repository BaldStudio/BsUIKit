//
//  BsUIKit.swift
//  BsUIKit
//
//  Created by crzorz on 2021/12/02.
//  Copyright © 2021 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

let logger: BsLogger = {
    let logger = BsLogger(subsystem: "com.bald-studio.BsUIKit",
                          category: "BsUIKit")
    logger.level = .none
    return logger
}()

public struct Screen {
    public static let bounds = UIScreen.main.bounds
    public static let size = bounds.size
    public static let width = bounds.width
    public static let height = bounds.height
    public static let scale = UIScreen.main.scale
}
