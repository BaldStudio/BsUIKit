//
//  AppletManifest.swift
//  BsUIKit
//
//  Created by crzorz on 2022/11/14.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import Foundation

public struct AppletManifest {
    public let id: String
    public let name: String
    public let bundle: String
    public let version: String
    
    public init(id: String,
                name: String,
                bundle: String,
                version: String = "1.0.0") {
        self.id = id
        self.name = name
        self.bundle = bundle
        self.version = version
    }
}

extension AppletManifest: CustomStringConvertible {
    public var description: String {
        String(format: "\(bundle).\(name) - \(id) - \(version) ")
    }
}

extension AppletManifest {
    var appletClass: Applet.Type? {
        NSClassFromString("\(bundle).\(name)") as? Applet.Type
    }
    
}

