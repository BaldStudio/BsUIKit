//
//  BsContext.swift
//  BsCoreServices
//
//  Created by crzorz on 2022/5/12.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

public struct BsContext: Service {
    
    init() {
        
    }
    
    public static let shared = BsContext()
}

//MARK: - Applet

public extension BsContext {
    
    struct LaunchOptions {
        public var params: [String: Any]? = nil
        public var animated: Bool? = true
        public var completion: (() -> Void)? = nil
    }
    
    static var currentApplet: Applet? {
        AppletManager.lastAppet
    }
    
    static func lookup(applet id: String) -> Applet? {
        AppletManager.lookup(applet: id) ?? AppletManager.lookup(residentApplet: id)
    }
    
    static func register(applet manifest: Manifest) {
        AppletManager.add(manifest: manifest)
    }
}

public extension BsContext {
    
    static var navigationController: UINavigationController!

    static func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController,
                                                animated: animated)
    }
}

public extension BsContext {
    
    @discardableResult
    static func start(applet id: String,
                      closure: ((inout LaunchOptions) -> Void)? = nil) -> Applet? {
        let app = lookup(applet: id) ?? AppletManager.create(by: id)

        /// 是否要默认给个404的applet
        guard let toApp = app else { logger.debug("未找到 Applet: \(id)");  return nil }

        var options: LaunchOptions? = nil
        if let closure = closure {
            options = LaunchOptions()
            closure(&(options!))
        }

        let fromApp = AppletManager.lastAppet

        if toApp.launched {
            toApp.willEnterForeground()
        }
        else {
            toApp.willFinishLaunching(options: options?.params)
        }

        AppletManager.push(toApp)

        let animated = options?.animated ?? true
        CATransaction.setCompletionBlock(options?.completion)
        CATransaction.begin()
        navigationController?.pushViewController(toApp.rootViewController,
                                                 animated: animated)
        CATransaction.commit()

        fromApp?.didEnterBackground()

        if !toApp.launched {
            toApp.didFinishLaunching(options: options?.params)
            toApp.launched = true
        }

        AppletManager.printStackData()
        
        return toApp
    }
    
    @discardableResult
    static func exit(toApplet id: String? = nil,
                     closure: ((inout LaunchOptions) -> Void)? = nil) -> Applet? {

        var options: LaunchOptions? = nil
        if let closure = closure {
            options = LaunchOptions()
            closure(&(options!))
        }

        let animated = options?.animated ?? true

        if id == nil || id!.count == 0 {
            CATransaction.setCompletionBlock(options?.completion)
            CATransaction.begin()
            navigationController?.popViewController(animated: animated)
            CATransaction.commit()
            return AppletManager.pop()
        }

        guard let target = lookup(applet: id!) else { return nil }

        AppletManager.pop(to: target)

        CATransaction.setCompletionBlock(options?.completion)
        CATransaction.begin()
        navigationController?.popToViewController(target.rootViewController,
                                                  animated: animated)
        CATransaction.commit()

        AppletManager.printStackData()
        
        return target
    }

}
