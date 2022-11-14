//
//  Applet.swift
//  BsUIKit
//
//  Created by crzorz on 2022/11/14.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

open class Applet {
    deinit {
        logger.debug("销毁 \(description)")
    }
    
    public required init() {

    }
    
    var isLaunched = false
    
    var root = AppletViewController()
    
    public var content: UIViewController? {
        willSet {
            guard let vc = newValue else {
                if let child = content {
                    child.willMove(toParent: nil)
                    child.removeFromParent()
                    child.view.removeFromSuperview()
                }
                return
            }

            root.applet = self
            root.addChild(vc)
            root.view.addSubview(vc.view)
            vc.didMove(toParent: root)
        }
    }

    public internal(set) var manifest: AppletManifest!
    
    open var shouldTerminate: Bool {
        true
    }
    
    open func willFinishLaunching(options: [String: Any]? = nil) {
        logger.debug("\(description) \(#function)")
    }

    open func didFinishLaunching(options: [String: Any]? = nil) {
        logger.debug("\(description) \(#function)")
    }

    open func didEnterBackground() {
        logger.debug("\(description) \(#function)")
    }

    open func willEnterForeground() {
        logger.debug("\(description) \(#function)")
    }

    open func willTerminate() {
        logger.debug("\(description) \(#function)")
    }

}

extension Applet: CustomStringConvertible, Equatable {
    
    public var description: String {
        manifest.description
    }
    
    public static func == (lhs: Applet, rhs: Applet) -> Bool {
        lhs === rhs
    }
}

