//
//  BsCollectionViewProxy.swift
//  BsUIKit
//
//  Created by crzorz on 2022/3/4.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class BsCollectionViewProxy: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var dataSource: BsCollectionViewDataSource!
    weak var collectionView: BsCollectionView!
    
    weak var target: UICollectionViewDelegate?

    convenience init(_ target: UICollectionViewDelegate?) {
        self.init()
        self.target = target
    }
        
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        target?.responds(to: aSelector) == true ? target : super.forwardingTarget(for: aSelector)
    }
        
    override func responds(to aSelector: Selector!) -> Bool {
        target?.responds(to: aSelector) == true || super.responds(to: aSelector)
    }

}

// MARK: - Cell

extension BsCollectionViewProxy {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard target?.collectionView?(collectionView, didSelectItemAt: indexPath) == nil
        else { return }

        dataSource[indexPath].didSelectItem(at: indexPath)
    }
        
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        dataSource[indexPath].didHighlightItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        dataSource[indexPath].didUnhighlightItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        dataSource[indexPath].willDisplay(cell, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        dataSource[indexPath].didEndDisplaying(cell, at: indexPath)
    }

}

// MARK: - Supplementary View

extension BsCollectionViewProxy {
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        
        if elementKind == UICollectionView.elementKindSectionHeader {
            dataSource[indexPath.section].willDisplay(header: view, at: indexPath)
        }
        else if elementKind == UICollectionView.elementKindSectionFooter {
            dataSource[indexPath.section].willDisplay(footer: view, at: indexPath)
        }
        else {
            dataSource[indexPath.section].collectionView(self.collectionView,
                                                         willDisplaySupplementaryView: view,
                                                         forElementKind: elementKind,
                                                         at: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String, at indexPath: IndexPath) {
        
        if elementKind == UICollectionView.elementKindSectionHeader {
            dataSource[indexPath.section].didEndDisplaying(header: view, at: indexPath)
        }
        else if elementKind == UICollectionView.elementKindSectionFooter {
            dataSource[indexPath.section].didEndDisplaying(footer: view, at: indexPath)
        }
        else {
            dataSource[indexPath.section].collectionView(self.collectionView,
                                                         didEndDisplayingSupplementaryView: view,
                                                         forElementOfKind: elementKind,
                                                         at: indexPath)
        }
        
    }

}

// MARK: - Flow Layout

extension BsCollectionViewProxy {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        dataSource[indexPath].cellSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        dataSource[section].insets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        dataSource[section].minimumLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        dataSource[section].minimumInteritemSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        dataSource[section].headerSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        dataSource[section].footerSize
    }

}
