//
//  BsCollectionViewController.swift
//  BsUIKit
//
//  Created by crzorz on 2022/8/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

open class BsCollectionViewController: BsViewController, UICollectionViewDelegate {
    
    public convenience init(layout: UICollectionViewLayout) {
        self.init(nibName: nil, bundle: nil)
        collectionView = BsCollectionView(frame: .zero,
                                          collectionViewLayout: layout)

    }
        
    open class func setupDefaultCollectionView() -> BsCollectionView {
        BsCollectionView(frame: .zero,       
                         collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    @Lazy(body: setupDefaultCollectionView)
    open var collectionView: BsCollectionView!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.bs.edgesEqualToSuperview()
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
    }
    
}
