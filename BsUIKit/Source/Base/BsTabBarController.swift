//
//  BsTabBarController.swift
//  BsUIKit
//
//  Created by crzorz on 2022/8/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

// MARK: - BsTabBarControllerDelegate

public protocol BsTabBarControllerDelegate: AnyObject {
    func tabBarController(_ tabBarController: BsTabBarController,
                          shouldSelect viewController: UIViewController) -> Bool
    func tabBarController(_ tabBarController: BsTabBarController,
                          didSelect viewController: UIViewController)
}

extension BsTabBarControllerDelegate {
    func tabBarController(_ tabBarController: BsTabBarController,
                          shouldSelect viewController: UIViewController) -> Bool { true }
    
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {}
}

// MARK: - BsTabBarItem

open class BsTabBarItem: UIView {
    private lazy var contentView = UIStackView().then {
        $0.spacing = 4
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
    }
    private lazy var imageView = UIImageView().then {
        $0.contentMode = .center
    }
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    
    open var title: String?
    
    open var image: UIImage?
    open var selectedImage: UIImage?
    
    open var titleColor: UIColor = .systemBlue
    open var selectedTitleColor: UIColor = .systemBlue
    
    open var isSelected: Bool = false {
        didSet {
            imageView.isHighlighted = isSelected
            titleLabel.isHighlighted = isSelected
            self.setNeedsDisplay()
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public required init(with viewController: UIViewController) {
        super.init(frame: .zero)
        
        guard let tabBarItem = viewController.tabBarItem else { return }
        
        image = tabBarItem.image
        imageView.image = image
        
        selectedImage = tabBarItem.selectedImage ?? image
        imageView.highlightedImage = selectedImage
        
        title = tabBarItem.title ?? viewController.title
        titleLabel.text = title
        
        let colorKey = NSAttributedString.Key.foregroundColor
        if let attributes = tabBarItem.titleTextAttributes(for: .normal) {
            titleColor = attributes[colorKey] as? UIColor ?? .systemBlue
        }
        titleLabel.textColor = titleColor
        
        if let attributes = tabBarItem.titleTextAttributes(for: .selected) {
            selectedTitleColor = attributes[colorKey] as? UIColor ?? .systemBlue
        }
        titleLabel.highlightedTextColor = selectedTitleColor;
        
        contentView.addArrangedSubview(imageView)
        contentView.addArrangedSubview(titleLabel)
        addSubview(contentView)
        contentView.bs.edgesEqualToSuperview()
    }
    
    open override var intrinsicContentSize: CGSize {
        [76, 48]
    }
}

// MARK: - BsTabBar

open class BsTabBar: UIView {
    private lazy var contentView = UIStackView().then {
        $0.spacing = 24
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .top
    }
    private lazy var backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
    
    open var items: [BsTabBarItem] = []
    open var selectedIndex: Int = 0 {
        willSet {
            if selectedIndex == newValue { return }
            guard newValue < items.count else { return }
            items[selectedIndex].isSelected = false
            items[newValue].isSelected = true
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundView)
        backgroundView.bs.edgesEqualToSuperview()
        
        addSubview(contentView)
        contentView.bs.edgesEqualToSuperview(with: UIEdgeInsets(horizontal: 24, vertical: 0))
    }
    
    open override var intrinsicContentSize: CGSize {
        [UIView.noIntrinsicMetric, 49 + SafeArea.bottom]
    }
    
    open func reloadItems(with viewControllers: [UIViewController]) {
        contentView.bs.removeSubviews()
        items.removeAll()
        viewControllers.forEach {
            let item = BsTabBarItem(with: $0)
            items.append(item)
            contentView.addArrangedSubview(item)
        }
    }
}

// MARK: - BsTabBarController

open class BsTabBarController: BsViewController {
    open lazy var tabBar = BsTabBar().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview($0)
        NSLayoutConstraint.activate([
            $0.leftAnchor.constraint(equalTo: view.leftAnchor),
            $0.rightAnchor.constraint(equalTo: view.rightAnchor),
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    open var viewControllers: [UIViewController] = [] {
        willSet {
            removeSelectViewController()
            viewControllers.forEach {
                var vc = $0
                vc.bs.tabBarController = nil
            }
            newValue.forEach {
                var vc = $0
                vc.bs.tabBarController = self
            }
            reloadTabBar()
            selectedIndex = 0
        }
    }
    
    open var selectedIndex: Int = 0
    
    open var selectedViewController: UIViewController? {
        set {
            guard let viewController = newValue else {
                removeSelectViewController()
                return
            }
            addChild(viewController)
            view.addSubview(viewController.view)
            viewController.didMove(toParent: self)
            title = viewController.title
            view.bringSubviewToFront(tabBar)
            delegate?.tabBarController(self, didSelect: viewController)
        }
        get {
            viewControllers.isEmpty ? nil : viewControllers[selectedIndex]
        }
    }
    
    open weak var delegate: BsTabBarControllerDelegate?
    
    open override var title: String? {
        set {
            super.title = newValue
            parent?.title = newValue
        }
        get {
            super.title ?? tabBarItem.title
        }
    }
    
    open func reloadTabBar() {
        tabBar.reloadItems(with: viewControllers)
        tabBar.items.forEach {
            let tap = UITapGestureRecognizer(target: self, action: #selector(onTapTabBarItem(_:)))
            $0.addGestureRecognizer(tap)
        }
    }
    
    open override var shouldAutorotate: Bool {
        selectedViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        selectedViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        selectedViewController
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        selectedViewController
    }
    
    open override var childForHomeIndicatorAutoHidden: UIViewController? {
        selectedViewController
    }
    
    open override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
        selectedViewController
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        selectedViewController?.preferredInterfaceOrientationForPresentation ?? super.preferredInterfaceOrientationForPresentation
    }
    
    open override var prefersHomeIndicatorAutoHidden: Bool {
        selectedViewController?.prefersHomeIndicatorAutoHidden ?? super.prefersHomeIndicatorAutoHidden
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        selectedViewController?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }
}

private extension BsTabBarController {
    @objc
    func onTapTabBarItem(_ sender: UITapGestureRecognizer) {
        guard let item = sender.view as? BsTabBarItem else { return }
        guard let index = tabBar.items.firstIndex(of: item) else { return }
        selectedIndex = index;
    }
    
    func removeSelectViewController() {
        guard let selectedViewController = selectedViewController else { return }
        selectedViewController.willMove(toParent: nil)
        selectedViewController.view.removeFromSuperview()
        selectedViewController.removeFromParent()
    }
}

// MARK: - Extensions

private struct AssociateKey {
    static var tabBarController = 0
}

public extension SwiftX where T: UIViewController {
    var tabBarController: BsTabBarController? {
        get {
            this.value<BsTabBarController>(forAssociated: &AssociateKey.tabBarController)
        }
        set {
            this.set(associate: newValue, for: &AssociateKey.tabBarController)
        }
    }
}
