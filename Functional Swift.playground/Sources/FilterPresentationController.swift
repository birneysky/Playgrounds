import UIKit


class FilterPresentationController: UIPresentationController, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {

    // MARK: - Init
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        print("FilterPresentationController")
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
    }
    
    // MARK: - override
    override var presentedView: UIView? {
        print("xxxx \(self.presentationWrappingView)")
        return self.presentationWrappingView
    }
    
    override func presentationTransitionWillBegin() {
        print("presentationTransitionWillBegin")
        guard let presentedViewControllerView = super.presentedView else {
            fatalError("super.presentedView is nil")
        }
        let roundedInset = UIEdgeInsets(top: 0, left: 0, bottom: -CORNER_RADIUS, right: 0)
        let roundedRect = self.presentationWrappingView.bounds.inset(by: roundedInset)
        let presentationRoundedCornerView = UIView(frame: roundedRect)
        presentationRoundedCornerView.autoresizingMask = [.flexibleWidth ,.flexibleHeight]
        presentationRoundedCornerView.layer.cornerRadius = CORNER_RADIUS
        presentationRoundedCornerView.layer.masksToBounds = true;
        
        let wrapperInset = UIEdgeInsets(top: 0, left: 0, bottom: CORNER_RADIUS, right: 0)
        let wrapperRect = presentationRoundedCornerView.bounds.inset(by: wrapperInset)
        let presentedViewControllerWrapperView = UIView(frame: wrapperRect)
        
        presentedViewControllerWrapperView.addSubview(presentedViewControllerView)
        presentationRoundedCornerView.addSubview(presentedViewControllerWrapperView)
        self.presentationWrappingView.addSubview(presentationRoundedCornerView)
        
        self.containerView?.addSubview(self.dummyView)
        self.dummyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped)))
        guard let transitionCoordinator =  self.presentingViewController.transitionCoordinator else {
            fatalError("transitionCoordinator is nil")
        }
        
        self.dummyView.alpha = 0
        transitionCoordinator .animate(alongsideTransition: { (context) in
            self.dummyView.alpha = 0.5
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            self.presentationWrappingView.removeFromSuperview()
            self.dummyView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = self.presentingViewController.transitionCoordinator else {
            fatalError("coordinator is nil")
        }
        coordinator.animate(alongsideTransition: { (context) in
            self.dummyView.alpha = 0
        }, completion: nil);
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.presentationWrappingView.removeFromSuperview()
            self.dummyView.removeFromSuperview()
        }
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        /// 判断是否为同一块内存
        if container === self.presentedViewController {
            self.containerView?.setNeedsLayout()
        }
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if container === self.presentedViewController {
            let vc = container as! UIViewController
            return vc.preferredContentSize
        } else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let containerViewBounds = self.containerView!.bounds;
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerViewBounds.size)
//        CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
        
        var presentedViewControllerFrame = containerViewBounds;
        presentedViewControllerFrame.size.height = presentedViewContentSize.height;
        presentedViewControllerFrame.origin.y = containerViewBounds.maxY - presentedViewContentSize.height;
        return presentedViewControllerFrame;
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        self.dummyView.frame = self.containerView!.bounds
         self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        guard let context = transitionContext else {
            return 0
        }
        return context.isAnimated ? 0.35 : 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print("animateTransition")
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            fatalError("fromViewController is nil")
        }
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            fatalError("toViewController is nil")
        }
        
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            fatalError("toView is nil")
        }
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            fatalError("fromView is nil")
        }
        
        let isPresenting = fromViewController === self.presentingViewController
        
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromViewController)
        var toViewInitialFrame = transitionContext.initialFrame(for: toViewController)
        let toViewFinalFrame = transitionContext.finalFrame(for: toViewController)
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        if isPresenting {
            toViewInitialFrame.origin = CGPoint(x: containerView.bounds.minX, y: containerView.bounds.midY)
            toViewInitialFrame.size = toViewFinalFrame.size
            toView.frame = toViewInitialFrame
        } else {
            fromViewFinalFrame = fromView.frame.offsetBy(dx: 0, dy: fromView.frame.height)
        }
        let animateDuration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: animateDuration, animations: {
            if isPresenting {
                toView.frame = toViewFinalFrame
            } else {
                fromView.frame = fromViewFinalFrame
            }
        }) { (_) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
    // MARK: - Action selector
     @objc private func dimmingViewTapped() {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
    // MARK: - Properties
    private let CORNER_RADIUS: CGFloat = 8.0
    lazy private var presentationWrappingView: UIView = {
        let view = UIView(frame: self.frameOfPresentedViewInContainerView)
        view.layer.shadowOpacity = 0.44
        view.layer.shadowRadius = 13.0
        view.layer.shadowOffset = CGSize(width: 0, height: -6)
        return view
    }()
    
    lazy private var dummyView: UIView  = {
        let view = UIView(frame: self.containerView?.bounds ?? CGRect.zero)
        view.backgroundColor = UIColor.black
        view.isOpaque = false
        view.autoresizingMask = [.flexibleWidth ,.flexibleHeight]
        return view
    }()
}

