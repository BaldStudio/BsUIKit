//
//  AlertContext.swift
//  BsUIKit
//
//  Created by changrunze on 2023/7/4.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

final class AlertContext {
    private lazy var primarySection = PrimarySection()
    
    private weak var controller: BsAlertController!
    
    required init(with controller: BsAlertController) {
        self.controller = controller
        controller.collectionView.layer.cornerRadius = AlertUtils.cornerRadius
        controller.collectionView.layer.masksToBounds = true
        controller.collectionView.backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        controller.collectionView.append(section: primarySection)
        controller.bsModalTransition = PresentationController(presentedViewController: controller,
                                                               presenting: nil)
    }
    
    func append(_ action: BsAlertAction) {
        if action.style == .custom {
            primarySection.append(CustomItem(with: action))
        } else {
            primarySection.append(PrimaryItem(with: action))
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
    
    private func relayoutForTwoPrimaryItemsIfCould() {
        guard primarySection.children.count > 1 else { return }
        
        let items = primarySection.children.filter {
            $0 is PrimaryItem
        }
        
        /// 只处理 PrimaryItem 元素数量为 2 个的情况
        guard items.count == 2 else { return }
        
        items.forEach {
            $0.preferredFixedAxisSize = .none
            $0.cellSize.width = (AlertUtils.alertWidth - AlertUtils.itemSpacing) * 0.5
        }
    }
    
    func prepareDisplay() {
        showTitleIfNeeded()
        // 出现 2个 Primary Item 时，特殊布局
        relayoutForTwoPrimaryItemsIfCould()
        controller.collectionView.reloadData()
    }
    
}

// MARK: - PresentationController

private extension AlertContext {
    class PresentationController: BsPresentationController, UIViewControllerAnimatedTransitioning {
        override init(presentedViewController: UIViewController,
                      presenting presentingViewController: UIViewController?) {
            super.init(presentedViewController: presentedViewController,
                       presenting: presentingViewController)
            presentedViewController.modalTransitionStyle = .crossDissolve
        }
        
        override var frameOfPresentedViewInContainerView: CGRect {
            guard let containerView = containerView else {
                return .zero
            }
            let bounds = containerView.bounds;
            let contentSize = size(forChildContentContainer: presentedViewController,
                                   withParentContainerSize:bounds.size)
            var frame: CGRect = .zero
            frame.size.width = AlertUtils.alertWidth
            frame.size.height = contentSize.height
            frame.origin.x = (bounds.width - frame.width) * 0.5
            frame.origin.y = (bounds.height - contentSize.height - containerView.safeAreaInsets.vertical) * 0.5
            return frame
        }
        
        func animationController(forPresented presented: UIViewController,
                                 presenting: UIViewController,
                                 source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            self
        }
        
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            0.4
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            guard let toView = transitionContext.view(forKey: .to) else { return }
            
            let container = transitionContext.containerView
            container.addSubview(toView)
            
            let duration = transitionDuration(using: transitionContext)
            
            toView.alpha = 0
            toView.transform = CGAffineTransformMakeScale(1.2, 1.2)
            
            UIView.animate(withDuration: duration,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: {
                toView.alpha = 1
                toView.transform = .identity
            }, completion: { _ in
                transitionContext.completeTransition(true)
            })
        }
    }
}

// MARK: - Base

private class AlertBaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        contentView.backgroundColor = .white.withAlphaComponent(0.8)
    }
    
}

private final class AlertCell: AlertBaseCell {
    
    var onPressButton: (() -> Void)?
    
    lazy var button = UIButton(type: .custom).then {
        $0.addTarget(self, action: #selector(onPressButtonAction(_:)), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.textAlignment = .center
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.bs.setBackgroundColor(.black.withAlphaComponent(0.05), for: .highlighted)
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

private class AlertItem: BsCollectionViewMutableItem {
    
    var action: BsAlertAction!
    
    override init() {
        super.init()
        cellClass = AlertCell.self
    }
    
    convenience init(with action: BsAlertAction) {
        self.init()
        self.action = action
    }
    
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        /// 点击事件
        if let cell = cell as? AlertCell {
            cell.onPressButton = { [weak self] in
                guard let self else { return }
                self.action.handler?(self.action)
                let viewController = self.action.alertController ?? cell.bs.viewController
                viewController?.dismiss(animated: true)
            }
        }
    }
    
}

// MARK: - Title UI

private final class TitleCell: AlertBaseCell {
    
    lazy var titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 17)
        $0.textColor = .black.withAlphaComponent(0.9)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    lazy var messageLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black.withAlphaComponent(0.9)
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
        stackView.bs.edgesEqualToSuperview(with: UIEdgeInsets(all: AlertUtils.titleMargin))
    }
}

private final class TitleItem: AlertItem {
    
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

// MARK: - Primary UI

private final class PrimarySection: BsCollectionViewSection {
    
    override init() {
        super.init()
        minimumLineSpacing = AlertUtils.itemSpacing
        minimumInteritemSpacing = AlertUtils.itemSpacing
    }
    
}

private final class PrimaryItem: AlertItem {
    
    override init() {
        super.init()
        cellSize = [0, AlertUtils.alertCellHeight]
        preferredFixedAxisSize = .horizontal
    }
    
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        
        guard let cell = cell as? AlertCell else {
            return
        }
        
        if action.style == .default {
            cell.button.titleLabel?.font = .systemFont(ofSize: 17)
        } else {
            cell.button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        }
        
        cell.button.setTitle(action.title, for: .normal)
    }
    
}

// MARK: - Custom UI

private final class CustomCell: AlertBaseCell {
    
    override func commonInit() {
        super.commonInit()
    }
    
}

private final class CustomItem: AlertItem {
    
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

