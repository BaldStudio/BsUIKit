//
//  BsDivideLine.swift
//  BsUIKit
//
//  Created by changrunze on 2023/9/20.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

open class BsDivideLine: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {
        backgroundColor = UIColor(0xD8D8D8)
    }
    
    open override var intrinsicContentSize: CGSize {
        [UIView.noIntrinsicMetric, Design.line]
    }
}
