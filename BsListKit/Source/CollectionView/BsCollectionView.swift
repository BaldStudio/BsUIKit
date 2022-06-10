//
//  BsCollectionView.swift
//  BsListKit
//
//  Created by crzorz on 2022/3/4.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

open class BsCollectionView: UICollectionView {
    
    public final private(set) var bs = Extends()
    
    open private(set) var registryMap: [String: AnyObject] = [:]

    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public convenience init(delegate: UICollectionViewDelegate) {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.delegate = delegate
    }

    open func commonInit() {
        dataSource = bs.dataSource
        
        bs.proxy.dataSource = bs.dataSource
        bs.proxy.collectionView = self
    }
    
    // MARK: - Override

    open override var dataSource: UICollectionViewDataSource? {
        get {
            bs.dataSource
        }
        set {
            if let dataSource = newValue as? BsCollectionViewDataSource {
                super.dataSource = dataSource
                bs.dataSource = dataSource
                dataSource.collectionView = self
            }
            else {
                super.dataSource = newValue
            }
        }
    }
    
    open override var delegate: UICollectionViewDelegate? {
        set {
            if newValue == nil {
                super.delegate = nil
                return
            }
            
            bs.proxy.target = newValue
            super.delegate = bs.proxy
        }
        get {
            super.delegate
        }
    }
    
    open override func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        super.register(cellClass, forCellWithReuseIdentifier: identifier)
//        guard identifier != "com.apple.UIKit.shadowReuseCellIdentifier" else { return }
        registryMap[identifier] = cellClass
    }
    
    open override func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        super.register(nib, forCellWithReuseIdentifier: identifier)
        registryMap[identifier] = nib
    }
    
    open override func register(_ viewClass: AnyClass?,
                                forSupplementaryViewOfKind elementKind: String,
                                withReuseIdentifier identifier: String) {
        super.register(viewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        registryMap[identifier] = viewClass
    }
    
    open override func register(_ nib: UINib?,
                                forSupplementaryViewOfKind kind: String,
                                withReuseIdentifier identifier: String) {
        super.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        registryMap[identifier] = nib
    }

    // MARK: - Additions

    open func append(section: BsCollectionViewSection) {
        bs.dataSource.append(section)
    }
    
    open func remove(section: BsCollectionViewSection) {
        bs.dataSource.remove(section)
    }

}

// MARK: - Extends

public extension BsCollectionView {
    
    struct Extends {
        fileprivate var proxy = BsCollectionViewProxy()
        public var dataSource = BsCollectionViewDataSource()
    }
    
}

// MARK: - Registry

extension BsCollectionView {
    
    final func registerCellIfNeeded(_ item: BsCollectionViewItem) {
        
        let id = item.reuseIdentifier
        if registryMap.contains(where: { $0.key == id }) {
            return
        }
        
        if let nib = item.nib {
            register(nib, forCellWithReuseIdentifier: id)
        }
        else {
            register(item.cellClass, forCellWithReuseIdentifier: id)
        }
    }
    
    final func registerHeaderIfNeeded(_ section: BsCollectionViewSection) {
        
        let id = section.headerReuseIdentifier
        if registryMap.contains(where: { $0.key == id }) {
            return
        }

        if let nib = section.headerNib {
            register(nib,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                     withReuseIdentifier: id)
        }
        else {
            register(section.headerClass,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                     withReuseIdentifier: id)
        }
        
    }

    final func registerFooterIfNeeded(_ section: BsCollectionViewSection) {
        
        let id = section.footerReuseIdentifier
        if registryMap.contains(where: { $0.key == id }) {
            return
        }

        if let nib = section.footerNib {
            register(nib,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                     withReuseIdentifier: id)
        }
        else {
            register(section.footerClass,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,               
                     withReuseIdentifier: id)
        }

    }

}
