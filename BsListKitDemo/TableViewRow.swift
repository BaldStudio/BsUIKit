//
//  TableViewRow.swift
//  BsListKitDemo
//
//  Created by crzorz on 2022/6/10.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import BsListKit

class TableViewRow: BsTableViewRow {
        
    weak var vc: ViewController!
    
    override func update(_ cell: UITableViewCell, at indexPath: IndexPath) {
        cell.textLabel?.text = "CollectionView 演示"
        cell.accessoryType = .disclosureIndicator
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let nav = UINavigationController(rootViewController: CollectionViewController())
        vc.present(nav, animated: true)
    }
}
