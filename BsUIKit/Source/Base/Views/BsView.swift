//
//  BsView.swift
//  BsUIKit
//
//  Created by changrunze on 2023/9/20.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

open class BsView: UIView {
    
    deinit {
        logger.debug("\(self.classForCoder) -> deinit 🔥")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {
        backgroundColor = .white
    }

}
