//
//  BsAlertController.swift
//  BsUIKit
//
//  Created by changrunze on 2023/7/4.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

extension BsAlertController {
    
    public enum Style {
        case actionSheet
        case alert
    }
    
}

open class BsAlertController: UIViewController {
    private var actionSheetContext: ActionSheetContext?
    private var alertContext: AlertContext?
    
    lazy var collectionView = BsCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.allowsSelection = false
    }

    deinit {
        logger.debug("\(self.classForCoder) -> deinit 🔥")
    }
    
    public convenience init(title: String?, message: String?, preferredStyle: Style = .alert) {
        self.init()
        self.title = title
        self.message = message
        self.preferredStyle = preferredStyle
        
        if preferredStyle == .alert {
            alertContext = AlertContext(with: self)
        } else {
            actionSheetContext = ActionSheetContext(with: self)
        }
        transitioningDelegate = bs.modalTransition
    }

    /// the UIViewController already has this property `title`
    /// open var title: String?
    
    open var message: String?
    
    /// 点击背景关闭弹窗
    open var dismissWhenTappedDimmingView: Bool {
        set {
            bsModalTransition?.dismissWhenTappedDimmingView = newValue
        }
        get {
            bsModalTransition?.dismissWhenTappedDimmingView ?? false
        }
    }
    
    open var dimmingViewColor: UIColor {
        set {
            bsModalTransition?.dimmingColor = newValue
        }
        get {
            bsModalTransition?.dimmingColor ?? AlertUtils.dimmingColor
        }
    }
    open private(set) var preferredStyle: Style = .alert
    
    open private(set) var actions: [BsAlertAction] = []

    open override func loadView() {
        view = collectionView
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        assert(!actions.isEmpty || (title != nil) || (message != nil))
        if preferredStyle == .alert {
            alertContext?.prepareDisplay()
        } else {
            actionSheetContext?.prepareDisplay()
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preferredContentSize = collectionView.collectionViewLayout.collectionViewContentSize
    }

    //MARK: - public methods
    
    open func addAction(_ action: BsAlertAction) {
        actions.append(action)
        
        if preferredStyle == .alert {
            alertContext?.append(action)
            return
        }
        
        actionSheetContext?.append(action)
    }
    
}

