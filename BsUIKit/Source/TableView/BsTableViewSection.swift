//
//  BsTableViewSection.swift
//  BsUIKit
//
//  Created by crzorz on 2022/3/4.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

open class BsTableViewSection: NSObject {
    
    public typealias Parent = BsTableViewDataSource
    public typealias Child = BsTableViewNode

    open weak internal(set) var parent: Parent? = nil
    
    open var children: ContiguousArray<Child> = []
        
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
        children.isEmpty
    }

    open var index: Int? {
        parent?.children.firstIndex(of: self)
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

    /// 是否是自定义Header，为 true 时，默认的 headerTitle 样式会失效
    var isCustomHeader = false

    open var headerClass: UITableViewHeaderFooterView.Type = UITableViewHeaderFooterView.self {
        didSet {
            isCustomHeader = true
        }
    }
    
    open var headerNib: UINib? {
        didSet {
            isCustomHeader = headerNib != nil
        }
    }

    open var headerTitle: String?
    
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
    
    open func tableView(_ tableView: BsTableView,
                        viewForHeaderInSection section: Int) -> UIView? {
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
    
    /// 是否是自定义 Footer，为 true 时，默认的 footerTitle 样式会失效
    var isCustomFooter = false
    open var footerClass: UITableViewHeaderFooterView.Type = UITableViewHeaderFooterView.self {
        didSet {
            isCustomFooter = true
        }
    }
    
    open var footerNib: UINib? {
        didSet {
            isCustomFooter = footerNib != nil
        }
    }

    open var footerTitle: String?
    
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
    
    open func tableView(_ tableView: BsTableView,
                        viewForFooterInSection section: Int) -> UIView? {
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
