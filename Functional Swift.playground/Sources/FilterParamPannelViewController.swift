import UIKit

class FilterParamPannelViewController: UIViewController {
    var parameters: [FilterParameter]!
    init(params: [FilterParameter]) {
        self.parameters = params
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(self.stackView)
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let height: CGFloat = max(screenHeight / 2, CGFloat(20 * self.parameters.count)) 
        self.preferredContentSize = CGSize(width: self.view.frame.width, height: height)
        for _ in 0...3 {
            let slider =  FilterSliderView()
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.heightAnchor.constraint(equalToConstant: 20).isActive = true
            slider.widthAnchor.constraint(equalToConstant: 100).isActive = true
            slider.backgroundColor = UIColor.randomColor
            self.stackView.addArrangedSubview(slider)
        }
    }
    
    
    // MARK - Helper
    func setupConstraints() {
        let mGuide = self.view.layoutMarginsGuide;
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.leadingAnchor.constraint(equalTo: mGuide.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: mGuide.trailingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: mGuide.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: mGuide.bottomAnchor).isActive = true
    }
    // MARK: - Properties
    var stackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect.zero)
        stackView.axis = NSLayoutConstraint.Axis.vertical
//        stackView.spacing = 10
        stackView.distribution = UIStackView.Distribution.equalSpacing
        return stackView
    }()
}
