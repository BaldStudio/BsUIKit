//
//  ViewController.swift
//  BsUIKitDemo
//
//  Created by crzorz on 2021/12/02.
//  Copyright © 2021 BaldStudio. All rights reserved.
//

import BsUIKit
import UIKit

class TestRow: BsTableViewRow {
    override init() {
        super.init()
        cellClass = TestRowCell.self
        cellHeight = UITableView.automaticDimension
    }
}

class TestRowCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        contentView.addSubview(lbl)
        NSLayoutConstraint.activate([
            lbl.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            lbl.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            lbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            lbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
        ])
                
        var text = "芜湖"
        for _ in 0..<Int.random(in: 0...10) {
            text += text
        }
        lbl.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let tableView = BsTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        let sec = BsTableViewSection()
        tableView.bs.dataSource.append(sec)
        
        func create() {
            let row = TestRow()
            sec.append(row)
        }
        
        for _ in 0..<100 {
            create()
        }

    }
}

