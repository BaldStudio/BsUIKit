//
//  BsUIKit.swift
//  BsUIKit
//
//  Created by crzorz on 2021/12/02.
//  Copyright © 2021 BaldStudio. All rights reserved.
//

@_exported import BsFoundation

let logger: BsLogger = {
    let logger = BsLogger(subsystem: "com.bald-studio.BsUIKit",
                          category: "BsUIKit")
    logger.level = .none
    return logger
}()
