//
//  BsViewController.swift
//  BsUIKit
//
//  Created by crzorz on 2022/8/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

open class BsViewController: UIViewController {
    
    deinit {
        logger.debug("\(self.classForCoder) -> deinit 🔥")
    }
    
    public override init(nibName nibNameOrNil: String?,
                         bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {

    }
    
    open override var shouldAutorotate: Bool {
        children.first?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        children.first?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        children.first
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        children.first
    }
    
    open override var childForHomeIndicatorAutoHidden: UIViewController? {
        children.first
    }
    
    open override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
        children.first
    }

}
