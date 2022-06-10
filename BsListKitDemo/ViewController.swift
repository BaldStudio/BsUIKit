//
//  ViewController.swift
//  BsListKitDemo
//
//  Created by crzorz on 2021/12/02.
//  Copyright © 2021 BaldStudio. All rights reserved.
//

import UIKit
import BsListKit

class ViewController: UIViewController, UITableViewDelegate {
    
    lazy var tableView = BsTableView(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        setupDataSource()
    }
    
    func setupTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupDataSource() {
        let section = BsTableViewSection()
        tableView.append(section: section)
        
        let row = TableViewRow()
        row.vc = self
        section.append(row)
    }
}

