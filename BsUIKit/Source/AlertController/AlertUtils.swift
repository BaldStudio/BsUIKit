//
//  AlertUtils.swift
//  BsUIKit
//
//  Created by changrunze on 2023/7/4.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import Foundation

enum AlertUtils {
    
    /// 弹出层与屏幕边距
    static let edgeInset: CGFloat = 8
    
    /// 默认圆角大小
    static let cornerRadius: CGFloat = 16
    
    /// 各个元素的间距，充当分割线
    static let itemSpacing: CGFloat = 0.5
    
    /// 主副标题的间距
    static let titleSpacing: CGFloat = 8
    
    /// 标题区域的上下左右边距
    static let titleMargin: CGFloat = 16
    
    /// ActionSheet 默认 cell 高度
    static let actionSheetCellHeight: CGFloat = 56
    
    /// ActionSheet 默认 section 间隔
    static let actionSheetSectionSpacing: CGFloat = 16
    
    /// Alert 的宽度
    static let alertWidth: CGFloat = 270
    
    /// Alert 默认 cell 高度
    static let alertCellHeight: CGFloat = 44
    
    static let dimmingColor: UIColor = .black.withAlphaComponent(0.15)
}
