//
//  BsTableViewCell.swift
//  BsUIKit
//
//  Created by changrunze on 2023/9/20.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

open class BsTableViewCell: UITableViewCell {
    
    deinit {
        logger.debug("\(self.classForCoder) -> deinit 🔥")
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {
        
    }
    
}
