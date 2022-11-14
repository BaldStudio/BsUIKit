//
//  Manifest.swift
//  BsCoreServices
//
//  Created by crzorz on 2022/5/19.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import Foundation

public struct Manifest {
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

extension Manifest: CustomStringConvertible {
    public var description: String {
        String(format: "\(bundle).\(name) - \(id) - \(version) ")
    }
}

extension Manifest {
    var appletClass: Applet.Type? {
        NSClassFromString("\(bundle).\(name)") as? Applet.Type
    }
    
}
