//
//  BsTableView.swift
//  BsUIKit
//
//  Created by crzorz on 2022/3/4.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

open class BsTableView: UITableView {
        
    public final private(set) var bs = Extends()

    open private(set) var registryMap: [String: AnyObject] = [:]
        
    public override init(frame: CGRect, style: Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public convenience init(delegate: UITableViewDelegate) {
        self.init(frame: .zero, style: .insetGrouped)
        self.delegate = delegate
    }

    open func commonInit() {
        
        delegate = bs.proxy
        dataSource = bs.dataSource
        
        bs.proxy.tableView = self
    }
       
    // MARK: - Override

    open override var dataSource: UITableViewDataSource? {
        set {
            if let dataSource = newValue as? BsTableViewDataSource {
                super.dataSource = dataSource
                bs.dataSource = dataSource
                bs.proxy.dataSource = dataSource
                dataSource.tableView = self
            }
            else {
                super.dataSource = newValue
            }
        }
        get {
            bs.dataSource
        }
    }
    
    open override var delegate: UITableViewDelegate? {
        set {
            guard let newValue = newValue else {
                bs.proxy.target = nil
                return
            }
            
            if !(newValue is BsTableViewProxy) {
                bs.proxy.target = newValue
            }
            
            super.delegate = bs.proxy
        }
        get {
            super.delegate
        }
    }
    
    open override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        super.register(cellClass, forCellReuseIdentifier: identifier)
        registryMap[identifier] = cellClass
    }
    
    open override func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        super.register(nib, forCellReuseIdentifier: identifier)
        registryMap[identifier] = nib
    }
    
    open override func register(_ nib: UINib?, forHeaderFooterViewReuseIdentifier identifier: String) {
        super.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
        registryMap[identifier] = nib
    }
    
    open override func register(_ aClass: AnyClass?, forHeaderFooterViewReuseIdentifier identifier: String) {
        super.register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
        registryMap[identifier] = aClass
    }

    // MARK: - Additions

    open func append(section: BsTableViewSection) {
        bs.dataSource.append(section)
    }
    
    open func remove(section: BsTableViewSection) {
        bs.dataSource.remove(section)
    }

}

// MARK: - Extends

public extension BsTableView {
    
    struct Extends {
        fileprivate var proxy = BsTableViewProxy()
        public var dataSource = BsTableViewDataSource()
    }

}

// MARK: - Registry

extension BsTableView {
    
    final func registerCellIfNeeded(_ row: BsTableViewRow) {
        
        let id = row.reuseIdentifier
        if registryMap.contains(where: { $0.key == id }) {
            return
        }
        
        if let nib = row.nib {
            register(nib, forCellReuseIdentifier: id)
        }
        else {
            register(row.cellClass, forCellReuseIdentifier: id)
        }
        
    }
    
    final func registerHeaderIfNeeded(_ section: BsTableViewSection) {
        
        let id = section.headerReuseIdentifier
        if registryMap.contains(where: { $0.key == id }) {
            return
        }
        
        if let nib = section.headerNib {
            register(nib, forHeaderFooterViewReuseIdentifier: id)
        }
        else {
            register(section.headerClass, forHeaderFooterViewReuseIdentifier: id)
        }
        
    }

    final func registerFooterIfNeeded(_ section: BsTableViewSection) {
        
        let id = section.footerReuseIdentifier
        if registryMap.contains(where: { $0.key == id }) {
            return
        }
        
        if let nib = section.footerNib {
            register(nib, forHeaderFooterViewReuseIdentifier: id)
        }
        else {
            register(section.footerClass, forHeaderFooterViewReuseIdentifier: id)
        }

    }

}
