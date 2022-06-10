//
//  CollectionViewItem.swift
//  BsListKitDemo
//
//  Created by crzorz on 2022/6/10.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import BsListKit

class CollectionViewItem: BsCollectionViewItem {
    
    override init() {
        super.init()
        cellSize = CGSize(width: 80, height: 80)
    }
    
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        let range = 0...255
        cell.contentView.backgroundColor = UIColor(red: CGFloat(Int.random(in: range)) / 255,
                                                   green: CGFloat(Int.random(in: range)) / 255,
                                                   blue: CGFloat(Int.random(in: range)) / 255,
                                                   alpha: 1)
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        print("You are selecting a item at \(indexPath)")
    }
    
}
