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
        children.isEmpty
    }

    open func append(_ child: Child) {
        guard !children.contains(child) else { return }
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
        guard !children.contains(child) else { return }
        child.removeFromParent()
        children.insert(child, at: index)
        child.parent = self
    }
    
    open func replace(childAt index: Int, with child: Child) {
        if children.contains(child), let otherIndex = children.firstIndex(of: child) {
            children.swapAt(index, otherIndex)
        } else {
            child.removeFromParent()
            children[index] = child
            child.parent = self
        }
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
        for child in children.reversed() {
            remove(child)
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
            replace(childAt: index, with: newValue)
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
        return self[section].isCustomHeader ? nil : self[section].headerTitle
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self[section].isCustomFooter ? nil : self[section].footerTitle
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
