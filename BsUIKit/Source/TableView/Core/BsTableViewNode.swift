//
//  BsTableViewNode.swift
//  BsUIKit
//
//  Created by changrunze on 2023/8/21.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

// MARK: - Property

open class BsTableViewNode: NSObject {
    public typealias Parent = BsTableViewSection
    
    /// 自动计算尺寸的缓存
    private var layoutSizeFittingCache = UIView.noIntrinsicMetric

    var cellClass: UITableViewCell.Type { UITableViewCell.self }
    
    open internal(set) weak var parent: Parent? = nil
    
    open var nib: UINib? = nil
    
    /// 指定cell的固定高度，在使用自适应高度时，则为最小高度
    open var cellHeight: CGFloat = 44
    
    /// 自适应尺寸，设置 vertical 自适应高度
    open var preferredLayoutSizeFitting: LayoutSizeFitting = .none
    
    /// 选中cell的回调闭包
    open var onSelectRow: ((IndexPath) -> Void)?
    
    /// 默认选中后立刻反选（调用 deselectRow 实现），展示类似按钮点击高亮的状态，这会影响 tableView 的 selection 相关逻辑
    open var isSelectionAnimated = true
    
    open var reuseIdentifier: String {
        "\(Self.self).\(cellClass).Cell"
    }
    
    open var tableView: BsTableView? {
        parent?.tableView
    }
    
    open var cell: UITableViewCell? {
        guard let indexPath = indexPath,
              let tableView = tableView else {
            return nil
        }
        
        return tableView.cellForRow(at: indexPath)
    }
    
    open var indexPath: IndexPath? {
        guard let parent = parent,
              let section = parent.index,
              let row = parent.children.firstIndex(of: self) else {
            return nil
        }
        
        return IndexPath(row: row, section: section)
    }
    
    open func reload(with animation: UITableView.RowAnimation = .none) {
        guard let tableView = tableView, let indexPath = indexPath else { return }
        tableView.reloadRows(at: [indexPath], with: animation)
    }
    
    open func invalidateCellSize() {
        layoutSizeFittingCache = UIView.noIntrinsicMetric
    }

    // MARK: - Additions
    
    open func removeFromParent() {
        parent?.remove(self)
    }
    
    // MARK: -  Cell
    
    func prepareLayoutSizeFitting(_ cell: UITableViewCell, at indexPath: IndexPath) {}
    
    func tableView(_ tableView: BsTableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.registerCellIfNeeded(self)
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                             for: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView,
                   didEndDisplaying cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
    }
    
    open func tableView(_ tableView: UITableView,
                        didSelectRowAt indexPath: IndexPath) {
        if isSelectionAnimated {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        onSelectRow?(indexPath)
    }

}

// MARK: - Layout Fitting

private var EPSILON: CGFloat = 1e-2

extension BsTableViewNode {
    
    /// 自适应尺寸计算
    func tableView(_ tableView: UITableView, preferredLayoutSizeFittingAt indexPath: IndexPath) -> CGFloat {
        if preferredLayoutSizeFitting == .none { return cellHeight }
        guard EPSILON > abs(layoutSizeFittingCache - UIView.noIntrinsicMetric) else { return layoutSizeFittingCache }
        let cell = cellClass.init(frame: tableView.bounds)
        prepareLayoutSizeFitting(cell, at: indexPath)
        // contentView本身和cell没有约束关系，如果需要使用 systemLayoutSizeFitting 计算高度，则需要添加约束关系
        // 另外此处的cell是临时创建的，在计算完毕之后会自动销毁，所以可以不用移除添加的约束
        cell.contentView.bs.edgesEqualToSuperview()
        let layoutSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
        layoutSizeFittingCache = max(cellHeight, layoutSize.height)
        return layoutSizeFittingCache
    }

}
