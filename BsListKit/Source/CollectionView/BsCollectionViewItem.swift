//
//  BsCollectionViewItem.swift
//  BsListKit
//
//  Created by crzorz on 2022/3/4.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

open class BsCollectionViewItem {
    
    public typealias Parent = BsCollectionViewSection

    open internal(set) weak var parent: Parent? = nil

    open var nib: UINib? = nil

    open var cellClass: UICollectionViewCell.Type = UICollectionViewCell.self

    open var cellSize: CGSize = .zero

    open var reuseIdentifier: String {
        "\(Self.self).\(cellClass).Cell"
    }
        
    public init() {}

    open var collectionView: BsCollectionView? {
        parent?.collectionView
    }

    open var cell: UICollectionViewCell? {
        guard let collectionView = collectionView,
              let indexPath = indexPath else {
            return nil
        }
        
        return collectionView.cellForItem(at: indexPath)
    }

    open var indexPath: IndexPath? {
        guard let parent = parent,
            let section = parent.index,
            let item = parent.children.firstIndex(of: self) else {
            return nil
        }
        
        return IndexPath(row: item, section: section)
    }
    
    open func reload() {
        guard let collectionView = collectionView,
              let indexPath = indexPath else { return }
        collectionView.reloadItems(at: [indexPath])
    }
    
    // MARK: - Additions

    open func removeFromParent() {
        parent?.remove(self)
    }
    
    // MARK: - Cell
    
    open func collectionView(_ collectionView: BsCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.registerCellIfNeeded(self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath)
        update(cell, at: indexPath)
        return cell
    }
    
    open func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {}

    open func willDisplay(_ cell: UICollectionViewCell, at indexPath: IndexPath) {}
    
    open func didEndDisplaying(_ cell: UICollectionViewCell, at indexPath: IndexPath) {}
    
    open func didSelectItem(at indexPath: IndexPath) {}
    
    open func didHighlightItem(at indexPath: IndexPath) {}
    
    open func didUnhighlightItem(at indexPath: IndexPath) {}

}

extension BsCollectionViewItem: Equatable {
    
    public static func == (lhs: BsCollectionViewItem, rhs: BsCollectionViewItem) -> Bool {
        ObjectIdentifier(lhs).hashValue == ObjectIdentifier(rhs).hashValue
    }
    
}
