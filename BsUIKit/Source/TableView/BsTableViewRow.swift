//
//  BsTableViewRow.swift
//  BsUIKit
//
//  Created by crzorz on 2022/3/4.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

// MARK: - Property

open class BsTableViewRow<T: UITableViewCell>: BsTableViewNode {
    override var cellClass: UITableViewCell.Type {
        T.self
    }
    
    override func prepareLayoutSizeFitting(_ cell: UITableViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? T else { return }
        update(cell, at: indexPath)
    }
    
    override func tableView(_ tableView: BsTableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let cell = cell as? T {
            update(cell, at: indexPath)
        }
        return cell
    }
    
    open func update(_ cell: T, at indexPath: IndexPath) {}
    
    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        guard let cell = cell as? T else { return }
        willDisplay(cell, at: indexPath)
    }
    
    open func willDisplay(_ cell: T, at indexPath: IndexPath) {}
    
    override func tableView(_ tableView: UITableView,
                            didEndDisplaying cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        guard let cell = cell as? T else { return }
        didEndDisplaying(cell, at: indexPath)
    }
    
    open func didEndDisplaying(_ cell: T, at indexPath: IndexPath) {}
}

// MARK: - Mutable Cell Class

open class BsTableViewMutableRow: BsTableViewRow<UITableViewCell> {    
    private var _cellClass: UITableViewCell.Type = UITableViewCell.self
    
    open override var cellClass: UITableViewCell.Type {
        set { _cellClass = newValue }
        get { _cellClass }
    }
}
