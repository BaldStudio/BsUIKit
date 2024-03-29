//
//  BsPresentationController.swift
//  BsUIKit
//
//  Created by changrunze on 2023/7/4.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

open class BsPresentationController: UIPresentationController {
    deinit {
        logger.debug("\(self.classForCoder) -> deinit 🔥")
    }
    
    public override init(presentedViewController: UIViewController,
                         presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController,
                   presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
    }
    
    var isPresentingAnimated = true
    
    lazy var dimmingView = UIView().then {
        $0.isUserInteractionEnabled = dismissWhenTappedDimmingView
        $0.backgroundColor = dimmingColor
        $0.isOpaque = false
        $0.alpha = 0
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(onTapDimmingView(_:)))
        $0.addGestureRecognizer(tap)
    }
    
    open var dimmingColor: UIColor = .black.withAlphaComponent(0.15) {
        willSet {
            dimmingView.backgroundColor = newValue
        }
    }
    
    open var dismissWhenTappedDimmingView = false {
        willSet {
            dimmingView.isUserInteractionEnabled = newValue
        }
    }
    
    open override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return .zero
        }
        let bounds = containerView.bounds;
        let contentSize = size(forChildContentContainer: presentedViewController,
                               withParentContainerSize:bounds.size)
        var frame = bounds
        frame.size.height = contentSize.height
        frame.origin.y = bounds.maxY - contentSize.height
        return frame
    }
    
    open override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        guard let coordinator = presentingViewController.transitionCoordinator else { return }
        
        isPresentingAnimated = coordinator.isAnimated
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0
        containerView.addSubview(dimmingView)
        
        if isPresentingAnimated {
            coordinator.animate { _ in
                self.dimmingView.alpha = 1
            }
        } else {
            dimmingView.alpha = 1
        }
        
        containerView.setNeedsLayout()
        containerView.layoutIfNeeded()
    }
    
    open override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            cleanup()
        }
    }
    
    open override func dismissalTransitionWillBegin() {
        guard let coordinator = presentingViewController.transitionCoordinator else { return }
        
        if coordinator.isAnimated {
            coordinator.animate { _ in
                self.dimmingView.alpha = 0
            }
        } else {
            dimmingView.alpha = 0
        }
    }
    
    open override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            cleanup()
        }
    }
    
    open override func size(forChildContentContainer container: UIContentContainer,
                            withParentContainerSize parentSize: CGSize) -> CGSize {
        if let target = container as? UIViewController,
           target == presentedViewController {
            return target.preferredContentSize
        }
        return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
    }
    
    open override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        if let target = container as? UIViewController,
           target == presentedViewController,
           let containerView = containerView {
            containerView.setNeedsLayout()
            containerView.layoutIfNeeded()
        }
    }
    
    open override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        if let bounds = containerView?.bounds {
            dimmingView.frame = bounds
        }
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    func cleanup() {
        dimmingView.removeFromSuperview()
        presentedViewController.bsModalTransition = nil
    }

}

// MARK: - Gestures

@objc
extension BsPresentationController {
    
    func onTapDimmingView(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: isPresentingAnimated)
    }
    
}

// MARK: - Transitioning

extension BsPresentationController: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        self
    }
    
}

// MARK: - Extensions

private struct RuntimeKey {
    static var presentation = 0
}

extension UIViewController {
    var bsModalTransition: BsPresentationController? {
        get {
            var p: BsPresentationController? = value(forAssociated: &RuntimeKey.presentation)
            if p.isNil {
                p = BsPresentationController(presentedViewController: self,
                                             presenting: nil)
                set(associate: p, for: &RuntimeKey.presentation)
            }
            return p
        }
        set {
            set(associate: newValue, for: &RuntimeKey.presentation)
        }
    }
}

public extension SwiftX where T: UIViewController {
    var modalTransition: BsPresentationController? { this.bsModalTransition }
}

// MARK: - Alert PresentationController

open class BsAlertPresentationController: BsPresentationController, UIViewControllerAnimatedTransitioning {
    public override init(presentedViewController: UIViewController,
                  presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController,
                   presenting: presentingViewController)
        presentedViewController.modalTransitionStyle = .crossDissolve
    }
    
    open override var frameOfPresentedViewInContainerView: CGRect {
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
    
    open func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.4
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
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

// MARK: - ActionSheet PresentationController

open class BsActionSheetPresentationController: BsPresentationController {
    open override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return .zero
        }
        let bounds = containerView.bounds;
        let contentSize = size(forChildContentContainer: presentedViewController,
                               withParentContainerSize:bounds.size)
        var frame = bounds
        frame.size.height = contentSize.height
        frame.origin.y = bounds.maxY - contentSize.height - containerView.safeAreaInsets.bottom
        return frame.insetBy(dx: AlertUtils.edgeInset, dy: 0)
    }
}

