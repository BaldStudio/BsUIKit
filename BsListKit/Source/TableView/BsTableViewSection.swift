//
//  BsTableViewSection.swift
//  BsListKit
//
//  Created by crzorz on 2022/3/4.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

open class BsTableViewSection {
    
    public typealias Parent = BsTableViewDataSource
    public typealias Child = BsTableViewRow

    open weak internal(set) var parent: Parent? = nil
    
    open var children: ContiguousArray<Child> = []
    
    public init() {}

    open var tableView: BsTableView? {
        parent?.tableView
    }
    
    open func reload(with animation: UITableView.RowAnimation = .none) {
        guard let tableView = tableView, let index = index else { return }
        tableView.reloadSections([index], with: animation)
    }
    
    // MARK: - Node Actions

    open var count: Int {
        children.count
    }
    
    open var isEmpty: Bool {
        children.count < 1
    }
    
    open var index: Int? {
        parent?.children.firstIndex(of: self)
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
    
    open func removeFromParent() {
        parent?.remove(self)
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

    // MARK: - Header

    open var headerHeight: CGFloat = 0

    open var headerClass: UITableViewHeaderFooterView.Type = UITableViewHeaderFooterView.self
    
    open var headerNib: UINib? = nil

    open var headerReuseIdentifier: String {
        "\(Self.self).\(headerClass).Header"
    }
          
    open var headerView: UITableViewHeaderFooterView? {
        guard let index = index,
              let tableView = tableView else {
            return nil
        }
        
        return tableView.headerView(forSection: index)
    }
    
    open func tableView(_ tableView: BsTableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.registerHeaderIfNeeded(self)
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier)
        else { return nil }
        update(header: header, in: section)
        return header
    }

    open func update(header: UITableViewHeaderFooterView,
                     in section: Int) {}

    open func willDisplay(header view: UIView, in section: Int) {}
    
    open func didEndDisplaying(header view: UIView, in section: Int) {}

    // MARK: - Footer

    open var footerHeight: CGFloat = 0

    open var footerClass: UITableViewHeaderFooterView.Type = UITableViewHeaderFooterView.self
    
    open var footerNib: UINib? = nil

    open var footerReuseIdentifier: String {
        "\(Self.self).\(footerClass).Footer"
    }
    
    open var footerView: UITableViewHeaderFooterView? {
        guard let index = index,
              let tableView = tableView else {
            return nil
        }
        
        return tableView.footerView(forSection: index)
    }

    open func tableView(_ tableView: BsTableView, viewForFooterInSection section: Int) -> UIView? {
        tableView.registerFooterIfNeeded(self)
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerReuseIdentifier)
        else {
            return nil
        }
        update(footer: footer, in: section)
        return footer
    }

    open func update(footer: UITableViewHeaderFooterView,
                     in section: Int) {}
    
    open func willDisplay(footer view: UIView, in section: Int) {}
    
    open func didEndDisplaying(footer view: UIView, in section: Int) {}

}

extension BsTableViewSection: Equatable {
    
    public static func == (lhs: BsTableViewSection, rhs: BsTableViewSection) -> Bool {
        ObjectIdentifier(lhs).hashValue == ObjectIdentifier(rhs).hashValue
    }
    
}

public extension BsTableViewSection {
    
    @inlinable
    static func += (left: BsTableViewSection, right: Child) {
        left.append(right)
    }
    
    @inlinable
    static func -= (left: BsTableViewSection, right: Child) {
        left.remove(right)
    }
}
