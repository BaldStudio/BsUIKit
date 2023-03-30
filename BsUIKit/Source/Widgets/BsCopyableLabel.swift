//
//  BsCopyableLabel.swift
//  BsUIKit
//
//  Created by crzorz on 2022/5/28.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

@IBDesignable
open class BsCopyableLabel: UILabel {
    
    open var longPressGesture: UILongPressGestureRecognizer!
    
    open var copyItemTitle = "复制"

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {
        isUserInteractionEnabled = true
        
        longPressGesture = UILongPressGestureRecognizer(target: self,
                                                        action: #selector(onLongPress(_:)))
        longPressGesture.minimumPressDuration = 0.5
        addGestureRecognizer(longPressGesture)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onMenuDidHide(_:)),
                                               name: UIMenuController.didHideMenuNotification,
                                               object: self)
    }
    
    open override var canBecomeFirstResponder: Bool { true }
    
    open override func canPerformAction(_ action: Selector,
                                        withSender sender: Any?) -> Bool {
        action == #selector(onCopy(_:))
    }
    
}

@objc
extension BsCopyableLabel {
    
    open func onCopy(_ sender: UIMenuItem) {
        UIPasteboard.general.string = text
    }
    
    open func onLongPress(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else { return }
        guard canBecomeFirstResponder else { return }

        becomeFirstResponder()
        
        let copy = UIMenuItem(title: copyItemTitle, action: #selector(onCopy(_:)))
        UIMenuController.shared.menuItems = [copy]
        UIMenuController.shared.showMenu(from: self, rect: self.bounds)
    }
    
    private func onMenuDidHide(_ note: Notification) {
        guard let obj = note.object as? Self, obj == self else { return }
        guard isFirstResponder else { return }
        
        resignFirstResponder()
    }

}
