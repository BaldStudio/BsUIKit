//
//  BsTableViewController.swift
//  BsUIKit
//
//  Created by crzorz on 2022/8/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

open class BsTableViewController: BsViewController, UITableViewDelegate {
    
    public convenience init(style: UITableView.Style) {
        self.init(nibName: nil, bundle: nil)
        tableView = BsTableView(frame: .zero, style: style)
    }
    
    open class func setupDefaultTableView() -> BsTableView {
        BsTableView(frame: .zero, style: .insetGrouped)
    }
    
    @Lazy(body: setupDefaultTableView)
    open var tableView: BsTableView!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.bs.edgesEqualToSuperview()
        tableView.delegate = self
    }

}
