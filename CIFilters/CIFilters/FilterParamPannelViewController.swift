import UIKit

class FilterParamPannelViewController: UIViewController {
    var parameters: [FilterParameter]!
    let spacing = 16
    init(params: [FilterParameter]) {
        self.parameters = params
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(self.effectView)
        self.effectView.contentView.addSubview(self.stackView)
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let height: CGFloat = max(self.view.bounds.height / 2, CGFloat(54 * self.parameters.count))
        self.preferredContentSize = CGSize(width: self.view.frame.width, height: height)
        for item in self.parameters {
            let slider =  FilterSliderView(parameter: item)
            if let navvc = self.presentingViewController as? UINavigationController {
                slider.deletate = navvc.topViewController as? FilterSliderViewDelegate
            }
            //slider.backgroundColor = UIColor.lightGray
            self.stackView.addArrangedSubview(slider)
            
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.heightAnchor.constraint(equalToConstant: 54).isActive = true
            guard let superview = slider.superview else {
                fatalError("the superview of slider is nil")
            }
            slider.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 16).isActive = true
            slider.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -16).isActive = true
        }
    }

    
    // MARK - Helper
    func setupConstraints() {
        let mGuide = self.view.layoutMarginsGuide;
        
        self.effectView.translatesAutoresizingMaskIntoConstraints = false
        self.effectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.effectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.effectView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.effectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.leadingAnchor.constraint(equalTo: mGuide.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: mGuide.trailingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: mGuide.topAnchor,constant: 16).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: CGFloat(self.parameters.count*54+(self.parameters.count-1)*spacing)).isActive = true
    }
 
    // MARK: - Properties
    lazy var effectView: UIVisualEffectView = {
        let visualeffect = UIBlurEffect.init(style: .light)
        let view = UIVisualEffectView(effect: visualeffect)
        view.alpha = 0.85
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect.zero)
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.center
        stackView.distribution = UIStackView.Distribution.equalCentering
        return stackView
    }()
}
