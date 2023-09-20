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

public func setLoggerLevel(_ lv: BsLogger.Level) {
    logger.level = lv
}

public struct Screen {
    public static let bounds = UIScreen.main.bounds
    public static let size = bounds.size
    public static let width = bounds.width
    public static let height = bounds.height
    public static let scale = UIScreen.main.scale
}

public struct SafeArea {
    public static let insets = BsAppMainWindow?.safeAreaInsets ?? .zero
    public static let top = insets.top
    public static let bottom = insets.bottom
}

public enum LayoutSizeFitting {
    case none
    case vertical   /// 垂直方向自适应  as 定宽算高
    case horizontal /// 水平方向自适应  as 定高算宽
}

public enum FixedAxisSize {
    case none
    case vertical   /// 垂直方向撑满与父视图
    case horizontal /// 水平方向撑满父视图
}

public struct Design {
    /// 分割线高度
    public static let line = 1.0 / Screen.scale
}
