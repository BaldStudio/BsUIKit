//
//  BsTableViewDataSource.swift
//  BsUIKit
//
//  Created by crzorz on 2022/3/4.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

open class BsTableViewDataSource: NSObject {
    
    public typealias Child = BsTableViewSection

    open internal(set) weak var tableView: BsTableView!

    open var children: ContiguousArray<Child> = []
    
    // MARK: - Node Actions
    
    open var count: Int {
        children.count
    }
    
    open var isEmpty: Bool {
        children.count < 1
    }
    
    open func append(_ child: Child) {
        child.removeFromParent()
        
        children.append(child)
        child.parent = self
    }
    
    open func append(children: [Child]) {
        for child in children {
            append(child)
        }
    }
    
    open func insert(_ child: Child, at index: Int) {
        child.removeFromParent()
        
        children.insert(child, at: index)
        child.parent = self
    }
    
    open func replace(childAt index: Int, with child: Child) {
        child.removeFromParent()
        
        children[index] = child
        child.parent = self
    }
    
    open func remove(at index: Int) {
        children[index].parent = nil
        children.remove(at: index)
    }
    
    open func remove(_ child: Child) {
        if let index = children.firstIndex(of: child) {
            remove(at: index)
        }
    }
    
    open func remove(children: [Child]) {
        for child in children {
            remove(child)
        }
    }
    
    open func removeAll() {
        for i in 0..<children.count {
            remove(at: i)
        }
    }
    
    open func child(at index: Int) -> Child {
        children[index]
    }
    
    open func contains(_ child: Child) -> Bool {
        children.contains { $0 == child }
    }
    
    open subscript(index: Int) -> Child {
        set {
            newValue.removeFromParent()
            
            children[index] = newValue
            newValue.parent = self
        }
        get {
            children[index]
        }
    }
    
    open subscript(indexPath: IndexPath) -> Child.Child {
        set {
            self[indexPath.section][indexPath.row] = newValue
        }
        get {
            self[indexPath.section][indexPath.row]
        }
    }
    
}

// MARK: - UITableViewDataSource

extension BsTableViewDataSource: UITableViewDataSource {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        count
    }
    
    open func tableView(_ tableView: UITableView,
                        numberOfRowsInSection section: Int) -> Int {
        self[section].count
    }
    
    open func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self[indexPath].tableView(self.tableView, cellForRowAt: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self[section].headerTitle
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        self[section].footerTitle
    }
    
}

public extension BsTableViewDataSource {
    
    @inlinable
    static func += (left: BsTableViewDataSource, right: Child) {
        left.append(right)
    }
    
    @inlinable
    static func -= (left: BsTableViewDataSource, right: Child) {
        left.remove(right)
    }
    
}
