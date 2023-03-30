//
//  BsAlertAction.swift
//  BsUIKit
//
//  Created by changrunze on 2023/7/4.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit

extension BsAlertAction {
    
    public enum Style {
        case `default`
        case destructive
        case custom
    }
    
}

open class BsAlertAction {
    
    public required init(title: String?, style: Style = .default, handler: ((BsAlertAction) -> Void)? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    public convenience init(customView: UIView) {
        self.init(title: nil, style: .custom)
        self.customView = customView
    }
    
    weak var alertController: BsAlertController?

    var handler: ((BsAlertAction) -> Void)?
    
    public static let cancel = BsAlertAction(title: "取消", style: .destructive)
    
    open internal(set) var title: String?
    
    open internal(set) var style: Style = .default
    
    open internal(set) var customView: UIView?
    
    // 添加自定义视图后，是否自适应高度，false时会使用customView的高度
    open var autoFitHeight = true
}
