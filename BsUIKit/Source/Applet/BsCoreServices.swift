//
//  BsCoreServices.swift
//  BsCoreServices
//
//  Created by crzorz on 2021/12/02.
//  Copyright © 2021 BaldStudio. All rights reserved.
//

@_exported import UIKit
@_exported import BsFoundation

let logger: BsLogger = {
    let logger = BsLogger(subsystem: "com.bald-studio.BsCoreServices",
                          category: "BsCoreServices")
    logger.level = .none
    return logger
}()

//MARK: - bootstrap

public func loadRoutines(_ filePath: String? = nil) {
        
    guard let path = filePath ?? Bundle.main.path(forResource: "AppletRoutines",
                                                   ofType: "plist"),
          let plist = FileManager.default.contents(atPath: path)
    else { fatalError("路由数据路径识别失败") }
    
    guard let result = try? PropertyListSerialization.propertyList(from: plist,
                                                                   options: .mutableContainersAndLeaves,
                                                                   format: nil)
    else { fatalError("路由数据读取失败") }
    
    guard result is [[String: String]] else { fatalError("路由数据的格式异常") }
    let list = result as! [[String: String]]
    
    _ = list.compactMap {
        let m = Manifest(id: $0["id"]!,
                         name: $0["name"]!,
                         bundle: $0["bundle"]!,
                         version: $0["version"]!)
        BsContext.register(applet: m)
    }
}
