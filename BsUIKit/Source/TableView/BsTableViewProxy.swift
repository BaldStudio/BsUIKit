//
//  BsTableViewProxy.swift
//  BsUIKit
//
//  Created by crzorz on 2022/3/4.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class BsTableViewProxy: NSObject {
    
    weak var dataSource: BsTableViewDataSource!
    weak var tableView: BsTableView!
    
    weak var target: UITableViewDelegate?

    convenience init(_ target: UITableViewDelegate?) {
        self.init()
        self.target = target
    }
        
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        target?.responds(to: aSelector) == true ? target : super.forwardingTarget(for: aSelector)
    }
        
    override func responds(to aSelector: Selector!) -> Bool {
        target?.responds(to: aSelector) == true || super.responds(to: aSelector)
    }

}

// MARK: - Cell

extension BsTableViewProxy: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        dataSource[indexPath].cellHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        dataSource[indexPath].cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        dataSource[indexPath].willDisplay(cell, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        dataSource[indexPath].didEndDisplaying(cell, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard target?.tableView?(tableView, didSelectRowAt: indexPath) == nil else { return }
        dataSource[indexPath].didSelectRow(at: indexPath)
    }
    
}

// MARK: - Header

extension BsTableViewProxy {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        dataSource[section].headerHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        dataSource[section].headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        dataSource[section].tableView(self.tableView, viewForHeaderInSection: section)
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        dataSource[section].willDisplay(header: view, in: section)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        dataSource[section].didEndDisplaying(header: view, in: section)
    }

}

// MARK: - Footer

extension BsTableViewProxy {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        dataSource[section].footerHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        dataSource[section].footerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        dataSource[section].tableView(self.tableView, viewForFooterInSection: section)
    }

    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        dataSource[section].willDisplay(footer: view, in: section)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        dataSource[section].didEndDisplaying(footer: view, in: section)
    }

}
