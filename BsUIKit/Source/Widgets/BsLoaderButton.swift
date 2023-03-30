//
//  BsLoaderButton.swift
//  BsUIKit
//
//  Created by changrunze on 2023/8/17.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit

public protocol IndicatorProtocol {
    var isAnimating: Bool { get }
    func startAnimating()
    func stopAnimating()
}

extension UIActivityIndicatorView: IndicatorProtocol {}

open class BsLoaderButton: UIButton {
    open var spinner: UIView & IndicatorProtocol = UIActivityIndicatorView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.hidesWhenStopped = true
        $0.color = .white
        $0.style = .medium
    }
    
    open var isLoading = false {
        didSet {
            updateView()
        }
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
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    open func updateView() {
        if isLoading {
            isUserInteractionEnabled = false
            spinner.startAnimating()
            titleLabel?.alpha = 0
            imageView?.alpha = 0
        } else {
            spinner.stopAnimating()
            titleLabel?.alpha = 1
            imageView?.alpha = 1
            isUserInteractionEnabled = true
        }
    }
}
