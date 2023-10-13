//
//  ActionSheetContext.swift
//  BsUIKit
//
//  Created by changrunze on 2023/7/4.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

final class ActionSheetContext {
    
    private lazy var primarySection = PrimarySection()
    private lazy var destructiveSection = DestructiveSection()
    
    private weak var controller: BsAlertController!
    
    required init(with controller: BsAlertController) {
        self.controller = controller
        controller.collectionView.append(section: primarySection)
        controller.collectionView.append(section: destructiveSection)
        controller.bsModalTransition = BsActionSheetPresentationController(presentedViewController: controller,
                                                                           presenting: nil)
    }
    
    func append(_ action: BsAlertAction) {
        if action.style == .default {
            primarySection.append(PrimaryItem(with: action))
        } else if action.style == .destructive {
            destructiveSection.append(DestructiveItem(with: action))
        } else {
            // 自定义视图添加到 primarySection 上
            primarySection.append(CustomItem(with: action))
        }
    }
    
    private func showTitleIfNeeded() {
        var isNeedTitle = false
        if let title = controller.title, !title.isEmpty {
            isNeedTitle = true
        }
        
        if let message = controller.message, !message.isEmpty {
            isNeedTitle = true
        }
        
        if isNeedTitle {
            let item = TitleItem(title: controller.title, message: controller.message)
            primarySection.insert(item, at: 0)
        }
    }
    
    func prepareDisplay() {
        showTitleIfNeeded()
        controller.collectionView.reloadData()
    }
    
}

// MARK: - Base

private class ActionSheetBaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        contentView.backgroundColor = .white
    }
    
}

private final class ActionSheetCell: ActionSheetBaseCell {
    
    var onPressButton: (() -> Void)?
    
    lazy var button = UIButton(type: .custom).then {
        $0.addTarget(self, action: #selector(onPressButtonAction(_:)), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
        $0.titleLabel?.textAlignment = .center
        $0.setTitleColor(.systemBlue, for: .normal)
        let color = UIColor.black.withAlphaComponent(0.05)
        $0.bs.setBackgroundColor(color, for: .highlighted)
    }
    
    override func commonInit() {
        super.commonInit()
        contentView.addSubview(button)
        button.bs.edgesEqualToSuperview()
    }
    
    @objc
    func onPressButtonAction(_ sender: UIButton)  {
        onPressButton?()
    }
    
}

private class ActionSheetItem: BsCollectionViewMutableItem {
    
    lazy var cornerLayer = CAShapeLayer()
    
    var action: BsAlertAction!
    
    override init() {
        super.init()
        cellClass = ActionSheetCell.self
    }
    
    convenience init(with action: BsAlertAction) {
        self.init()
        self.action = action
    }
    
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        guard let section = parent else {
            return
        }
        
        /// 点击事件
        if let cell = cell as? ActionSheetCell {
            cell.onPressButton = { [weak self] in
                guard let self = self else { return }
                self.action.handler?(self.action)
                let viewController = self.action.alertController ?? cell.bs.viewController
                viewController?.dismiss(animated: true)
            }
        }
        
        /// 圆角处理
        var corners: UIRectCorner = []
        
        /// 只有 1 个 Cell 的情况
        if section.count == 1 {
            corners.insert(.allCorners)
        } else {
            /// 首尾的 Cell 加圆角
            if indexPath.row == 0 {
                corners.insert([.topLeft, .topRight])
            } else if indexPath.row == section.count - 1 {
                corners.insert([.bottomLeft, .bottomRight])
            }
        }
        
        if corners.isEmpty {
            cell.layer.mask = nil
        } else {
            cornerLayer.bs.applyCorners(with: cell.bounds,
                                        radius: AlertUtils.cornerRadius,
                                        corners: corners)
            cell.layer.mask = cornerLayer
        }
    }
    
}

//MARK: - Destructive UI

private final class DestructiveSection: BsCollectionViewSection {
    
    override init() {
        super.init()
        minimumLineSpacing = AlertUtils.actionSheetSectionSpacing
        insets = UIEdgeInsets(vertical: AlertUtils.actionSheetSectionSpacing)
    }
    
}

private final class DestructiveItem: ActionSheetItem {
    
    override init() {
        super.init()
        cellSize = [0, AlertUtils.actionSheetCellHeight]
        preferredFixedAxisSize = .horizontal
    }
    
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        // 此处不调用 super 中实现的圆角逻辑，在下面自行实现圆角，点击的 closure 也要重新赋值
        guard let cell = cell as? ActionSheetCell else {
            return
        }
        
        cornerLayer.bs.applyCorners(with: cell.bounds,
                                    radius: AlertUtils.cornerRadius,
                                    corners: .allCorners)
        
        cell.layer.mask = cornerLayer
        cell.button.setTitle(action.title, for: .normal)
        cell.onPressButton = { [weak self] in
            guard let self else { return }
            self.action.handler?(self.action)
            let viewController = self.action.alertController ?? cell.bs.viewController
            viewController?.dismiss(animated: true)
        }
    }
    
}

//MARK: - Primary UI

private final class PrimarySection: BsCollectionViewSection {
    
    override init() {
        super.init()
        minimumLineSpacing = AlertUtils.itemSpacing
    }
    
}

private final class PrimaryItem: ActionSheetItem {
    
    override init() {
        super.init()
        cellSize = [0, AlertUtils.actionSheetCellHeight]
        preferredFixedAxisSize = .horizontal
    }
    
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        
        guard let cell = cell as? ActionSheetCell else {
            return
        }
        
        cell.button.titleLabel?.font = .systemFont(ofSize: 20)
        cell.button.setTitle(action.title, for: .normal)
    }
    
}

// MARK: - Title UI

private final class TitleCell: ActionSheetBaseCell {
    
    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .black.withAlphaComponent(0.4)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    lazy var messageLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .black.withAlphaComponent(0.4)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    override func commonInit() {
        super.commonInit()
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        stackView.spacing = AlertUtils.titleSpacing
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        contentView.addSubview(stackView)
        stackView.bs.edgesEqualToSuperview(with: .all(AlertUtils.titleMargin))
    }
    
}

private final class TitleItem: ActionSheetItem {
    
    var title: String?
    var message: String?
    
    override init() {
        super.init()
        cellClass = TitleCell.self
        preferredFixedAxisSize = .horizontal
        preferredLayoutSizeFitting = .vertical
    }
    
    convenience init(title: String?, message: String?) {
        self.init()
        self.title = title
        self.message = message
    }
    
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        
        guard let cell = cell as? TitleCell else {
            return
        }
        
        cell.titleLabel.text = title
        cell.titleLabel.isHidden = title == nil
        
        cell.messageLabel.text = message
        cell.messageLabel.isHidden = message == nil
    }
    
}

// MARK: - Custom UI

private final class CustomCell: ActionSheetBaseCell {
    
    override func commonInit() {
        super.commonInit()
    }
    
}

private final class CustomItem: ActionSheetItem {
    
    override init() {
        super.init()
        cellClass = CustomCell.self
        preferredFixedAxisSize = .horizontal
    }
    
    convenience init(with action: BsAlertAction) {
        self.init()
        self.action = action
        if action.autoFitHeight {
            preferredLayoutSizeFitting = .vertical
        } else {
            cellSize = [0, action.customView?.bounds.height ?? 0]
        }
    }
    
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        
        guard let cell = cell as? CustomCell else {
            return
        }
        
        if let customView = action.customView {
            cell.contentView.bs.removeSubviews()
            cell.contentView.addSubview(customView)
            customView.bs.edgesEqualToSuperview()
        }
    }
    
}
