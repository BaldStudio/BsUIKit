//
//  BsTableViewProxy.swift
//  BsUIKit
//
//  Created by crzorz on 2022/3/4.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class BsTableViewProxy: NSObject, UITableViewDelegate {
    private var impl: BsTableViewProxyImpl?
    
    weak var dataSource: BsTableViewDataSource!
    weak var tableView: BsTableView!
    
    weak var target: UITableViewDelegate?
    
    override init() {
        super.init()
        impl = BsTableViewProxyImpl(self)
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        target?.responds(to: aSelector) == true ? target : impl ?? super.forwardingTarget(for: aSelector)
    }
    
    override func responds(to aSelector: Selector!) -> Bool {
        target?.responds(to: aSelector) == true || impl?.responds(to: aSelector) == true || super.responds(to: aSelector)
    }
    
}

private class BsTableViewProxyImpl: NSObject, UITableViewDelegate {
    weak var proxy: BsTableViewProxy!
    convenience init(_ proxy: BsTableViewProxy) {
        self.init()
        self.proxy = proxy
    }
}

// MARK: - Cell

extension BsTableViewProxyImpl {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        proxy.dataSource[indexPath].tableView(tableView, preferredLayoutSizeFittingAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        proxy.dataSource[indexPath].cellHeight
    }

    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        proxy.dataSource[indexPath].tableView(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   didEndDisplaying cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        proxy.dataSource[indexPath].tableView(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        proxy.dataSource[indexPath].tableView(tableView, didSelectRowAt: indexPath)
    }

}

// MARK: - Header

extension BsTableViewProxyImpl {
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        proxy.dataSource[section].headerHeight
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        proxy.dataSource[section].headerHeight
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        proxy.dataSource[section].tableView(proxy.tableView, viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView, forSection section: Int) {
        proxy.dataSource[section].willDisplay(header: view, in: section)
    }
    
    func tableView(_ tableView: UITableView,
                   didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        proxy.dataSource[section].didEndDisplaying(header: view, in: section)
    }
    
}

// MARK: - Footer

extension BsTableViewProxyImpl {
    
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        proxy.dataSource[section].footerHeight
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForFooterInSection section: Int) -> CGFloat {
        proxy.dataSource[section].footerHeight
    }
    
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        proxy.dataSource[section].tableView(proxy.tableView, viewForFooterInSection: section)
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplayFooterView view: UIView,
                   forSection section: Int) {
        proxy.dataSource[section].willDisplay(footer: view, in: section)
    }
    
    func tableView(_ tableView: UITableView,
                   didEndDisplayingFooterView view: UIView,
                   forSection section: Int) {
        proxy.dataSource[section].didEndDisplaying(footer: view, in: section)
    }
    
}
