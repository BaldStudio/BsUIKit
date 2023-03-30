//
//  BsCollectionViewProxy.swift
//  BsUIKit
//
//  Created by crzorz on 2022/3/4.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class BsCollectionViewProxy: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private var impl: BsCollectionViewProxyImpl?
    
    weak var dataSource: BsCollectionViewDataSource!
    weak var collectionView: BsCollectionView!
    
    weak var target: UICollectionViewDelegate?
    
    override init() {
        super.init()
        impl = BsCollectionViewProxyImpl(self)
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        target?.responds(to: aSelector) == true ? target : impl ?? super.forwardingTarget(for: aSelector)
    }
    
    override func responds(to aSelector: Selector!) -> Bool {
        target?.responds(to: aSelector) == true || impl?.responds(to: aSelector) == true || super.responds(to: aSelector)
    }
}

private class BsCollectionViewProxyImpl: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    weak var proxy: BsCollectionViewProxy!
    convenience init(_ proxy: BsCollectionViewProxy) {
        self.init()
        self.proxy = proxy
    }
}


// MARK: - Cell

extension BsCollectionViewProxyImpl {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        proxy.dataSource[indexPath].collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        proxy.dataSource[indexPath].collectionView(collectionView, didHighlightItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        proxy.dataSource[indexPath].collectionView(collectionView, didUnhighlightItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        proxy.dataSource[indexPath].collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        proxy.dataSource[indexPath].collectionView(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    }

}

// MARK: - Supplementary View

extension BsCollectionViewProxyImpl {
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        let element = proxy.dataSource[indexPath.section]
        if elementKind == UICollectionView.elementKindSectionHeader {
            element.willDisplay(header: view, at: indexPath)
        } else if elementKind == UICollectionView.elementKindSectionFooter {
            element.willDisplay(footer: view, at: indexPath)
        } else {
            element.collectionView(proxy.collectionView,
                                   willDisplaySupplementaryView: view,
                                   forElementKind: elementKind,
                                   at: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String, at indexPath: IndexPath) {
        let element = proxy.dataSource[indexPath.section]
        if elementKind == UICollectionView.elementKindSectionHeader {
            element.didEndDisplaying(header: view, at: indexPath)
        } else if elementKind == UICollectionView.elementKindSectionFooter {
            element.didEndDisplaying(footer: view, at: indexPath)
        } else {
            element.collectionView(proxy.collectionView,
                                   didEndDisplayingSupplementaryView: view,
                                   forElementOfKind: elementKind,
                                   at: indexPath)
        }
    }
    
}

// MARK: - Flow Layout

extension BsCollectionViewProxyImpl {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = proxy.dataSource[indexPath]
        var size = item.collectionView(collectionView, preferredFixedAxisSizeAt: indexPath)
        size = item.collectionView(collectionView, preferredLayoutSizeFittingAt: indexPath)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        proxy.dataSource[section].insets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        proxy.dataSource[section].minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        proxy.dataSource[section].minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        proxy.dataSource[section].headerSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        proxy.dataSource[section].footerSize
    }
    
}
