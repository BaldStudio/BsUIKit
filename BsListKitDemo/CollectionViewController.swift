//
//  CollectionViewController.swift
//  BsListKitDemo
//
//  Created by crzorz on 2022/6/10.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import BsListKit

class CollectionViewController: UIViewController, UICollectionViewDelegate {
    
    lazy var collectionView = BsCollectionView(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CollectionView 演示"
        
        setupNavigationItems()
        
        setupCollectionView()
        
        setupDataSource()
    }
    
    func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "切换布局",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onPressRightBarButton))
    }

    func setupCollectionView() {
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupDataSource() {
        let section = BsCollectionViewSection()
        collectionView.append(section: section)
        
        for _ in 0...20 {
            let item = CollectionViewItem()
            section.append(item)
        }
        
    }
}

var isCustomLayout = false

@objc
extension CollectionViewController: WBGridViewLayoutDelegate {
    
    func onPressRightBarButton() {
        
        if isCustomLayout {
            isCustomLayout = false
            let layout = UICollectionViewFlowLayout()
            collectionView.setCollectionViewLayout(layout, animated: true)
        }
        else {
            isCustomLayout = true
            let layout = WBGridViewLayout()
            layout.delegate = self
            collectionView.setCollectionViewLayout(layout, animated: true)
        }

    }
    
}
