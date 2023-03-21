//
//  AppletContext.swift
//  BsUIKit
//
//  Created by crzorz on 2022/11/14.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

public struct AppletContext {
    init() {
        
    }
    
    public static let shared = AppletContext()
}

//MARK: - Applet

public extension AppletContext {
    
    struct LaunchOptions {
        public var params: [String: Any]? = nil
        public var animated: Bool = true
        public var completion: (() -> Void)? = nil
    }
    
    static var topApplet: Applet? {
        AppletManager.lastAppet
    }
    
    static func lookup(applet id: String) -> Applet? {
        AppletManager.lookup(applet: id) ?? AppletManager.lookup(residentApplet: id)
    }
    
    static func register(applet manifest: AppletManifest) {
        AppletManager.add(manifest: manifest)
    }
}

public extension AppletContext {
    
    static var navigator: UINavigationController!

    static func push(_ viewController: UIViewController, animated: Bool = true) {
        navigator.pushViewController(viewController,
                                     animated: animated)
    }
    
    static func pop(animated: Bool = true) {
        navigator.popViewController(animated: animated)
    }
    
    static func pop(to viewController: UIViewController, animated: Bool = true) {
        navigator.popToViewController(viewController,
                                      animated: animated)
    }
}

public extension AppletContext {
    
    @discardableResult
    static func start(applet id: String,
                      closure: ((inout LaunchOptions) -> Void)? = nil) -> Applet? {
        let appet = lookup(applet: id) ?? AppletManager.create(by: id)

        // TODO: 默认给个404的applet
        guard let toApplet = appet else {
            logger.debug("未找到 Applet: \(id)")
            return nil
        }

        var options = LaunchOptions()
        if let closure = closure {
            closure(&options)
        }

        let fromApplet = AppletManager.lastAppet

        if toApplet.isLaunched {
            toApplet.willEnterForeground()
        }
        else {
            toApplet.willFinishLaunching(options: options.params)
        }

        AppletManager.push(toApplet)

        CATransaction.setCompletionBlock(options.completion)
        CATransaction.begin()
        push(toApplet.root, animated: options.animated)
        CATransaction.commit()

        fromApplet?.didEnterBackground()

        if !toApplet.isLaunched {
            toApplet.didFinishLaunching(options: options.params)
            toApplet.isLaunched = true
        }

        AppletManager.printStackData()
        
        return toApplet
    }
    
    @discardableResult
    static func exit(toApplet id: String? = nil,
                     closure: ((inout LaunchOptions) -> Void)? = nil) -> Applet? {

        var options = LaunchOptions()
        if let closure = closure {
            options = LaunchOptions()
            closure(&options)
        }

        if id == nil || id!.count == 0 {
            CATransaction.setCompletionBlock(options.completion)
            CATransaction.begin()
            pop(animated: options.animated)
            CATransaction.commit()
            return AppletManager.pop()
        }

        guard let target = lookup(applet: id!) else { return nil }

        AppletManager.pop(to: target)

        CATransaction.setCompletionBlock(options.completion)
        CATransaction.begin()
        pop(to: target.root, animated: options.animated)
        CATransaction.commit()

        AppletManager.printStackData()
        
        return target
    }

}
