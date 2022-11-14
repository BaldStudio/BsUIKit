//
//  AppletManager.swift
//  BsCoreServices
//
//  Created by crzorz on 2022/5/19.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import Foundation
import BsFoundation

class AppletManager: Service {
    
    var applets: ContiguousArray<Applet> = []
    var residentApplets: ContiguousArray<Applet> = []

    var manifestsById: [String: Manifest] = [:]

    init() {
        
    }
    
    static let shared = AppletManager()
    
    static var lastAppet: Applet? {
        shared.applets.last
    }

}

//MARK: - Applet

extension AppletManager {
    
    static func create(by id: String) -> Applet? {
        guard let manifest = shared.manifestsById[id],
              let appletClass = manifest.appletClass
        else {
            return nil
        }

        logger.debug("当前 Appelt 所在 Bundle 为：\(manifest.bundle)")
        let applet = appletClass.init()
        applet.manifest = manifest
        if !applet.shouldTerminate {
            add(resident: applet)
        }
        logger.debug("初始化 \(manifest.description)")
        return applet
    }
    
    static func lookup(applet id: String) -> Applet? {
        for app in shared.applets {
            if let m = app.manifest, m.id == id {
                return app
            }
        }

        return nil
    }
    
    static func push(_ applet: Applet) {
        shared.applets.append(applet)
    }

    @discardableResult
    static func pop(to target: Applet? = nil) -> Applet? {
        if let target = target {
            for a in shared.applets.reversed() {
                if a == target {
                    target.willEnterForeground()
                    return target
                }

                if a.shouldTerminate {
                    a.willTerminate()
                }
                else {
                    a.didEnterBackground()
                }
                
                shared.applets.removeLast()
                
            }

            return target
        }

        guard let applet = lastAppet else {
            logger.debug("当前应用栈 \(shared.applets)")
            return nil
        }

        defer {
            logger.debug("当前应用栈 \(shared.applets)")
            logger.debug("当前后台应用栈 \(shared.residentApplets)")
        }

        logger.debug("退出当前应用 \(applet.description)")

        shared.applets.removeLast()

        if applet.shouldTerminate {
            applet.willTerminate()
        }
        else {
            applet.didEnterBackground()
        }

        lastAppet?.willEnterForeground()
        
        return applet
    }
}


//MARK: - Manifest

extension AppletManager {
    
    static func add(manifest: Manifest) {
        shared.manifestsById[manifest.id] = manifest
    }
    
}

//MARK: - Resident

extension AppletManager {
    static func lookup(residentApplet id: String) -> Applet? {
        for app in shared.residentApplets {
            if let m = app.manifest, m.id == id {
                return app
            }
        }
        return nil
    }

    static func add(resident applet: Applet) {
        shared.residentApplets.append(applet)
    }

    static func remove(resident applet: Applet) {
        let temp = shared.residentApplets
        for (idx, item) in temp.enumerated() {
            if item == applet {
                shared.residentApplets.remove(at: idx)
                return
            }
        }
    }
}

//MARK: - Debug

extension AppletManager {
    
    static func printStackData() {
        logger.debug("当前应用栈 \(AppletManager.shared.applets)")
        logger.debug("当前后台应用栈 \(AppletManager.shared.residentApplets)")
    }
}
