//
//  BsTableViewRow.swift
//  BsListKit
//
//  Created by crzorz on 2022/3/4.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

open class BsTableViewRow {

    public typealias Parent = BsTableViewSection

    open internal(set) weak var parent: Parent? = nil

    open var nib: UINib? = nil

    open var cellClass: UITableViewCell.Type = UITableViewCell.self
        
    open var cellHeight: CGFloat = 44.0
    
    public init() {}

    open var reuseIdentifier: String {
        "\(Self.self).\(cellClass).Cell"
    }

    open var tableView: BsTableView? {
        parent?.tableView
    }

    open var cell: UITableViewCell? {
        guard let indexPath = indexPath,
              let tableView = tableView else {
            return nil
        }
        
        return tableView.cellForRow(at: indexPath)
    }

    open var indexPath: IndexPath? {
        guard let parent = parent,
            let section = parent.index,
            let row = parent.children.firstIndex(of: self) else {
            return nil
        }
        
        return IndexPath(row: row, section: section)
    }
    
    open func reload(with animation: UITableView.RowAnimation = .none) {
        guard let tableView = tableView, let indexPath = indexPath else { return }
        tableView.reloadRows(at: [indexPath], with: animation)
    }
        
    // MARK: - Additions

    open func removeFromParent() {
        parent?.remove(self)
    }

    // MARK: -  Cell

    open func tableView(_ tableView: BsTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.registerCellIfNeeded(self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                 for: indexPath)
        update(cell, at: indexPath)
        return cell
    }
    
    open func update(_ cell: UITableViewCell, at indexPath: IndexPath) {}

    open func willDisplay(_ cell: UITableViewCell, at indexPath: IndexPath) {}
    
    open func didEndDisplaying(_ cell: UITableViewCell, at indexPath: IndexPath) {}
    
    open func didSelectRow(at indexPath: IndexPath) {}

}

extension BsTableViewRow: Equatable {
    
    public static func == (lhs: BsTableViewRow, rhs: BsTableViewRow) -> Bool {
        ObjectIdentifier(lhs).hashValue == ObjectIdentifier(rhs).hashValue
    }
    
}

