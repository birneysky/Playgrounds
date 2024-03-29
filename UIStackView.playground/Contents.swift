//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

/// https://my.oschina.net/u/2340880/blog/531545

class StackViewController : UIViewController {
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.lightGray
        self.view.addSubview(self.stackView)
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let n = 10
        for _ in 0...n {
            let view = UIView(frame: CGRect.zero)
            view.frame.size.height = 30
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalToConstant: 100/*CGFloat(arc4random() % 100)*/ ).isActive = true
            view.heightAnchor.constraint(equalToConstant: 70).isActive = true
            view.backgroundColor = randomColor ?? UIColor.yellow
            self.stackView.addArrangedSubview(view)
        }
    }
    
    
    var randomColor: UIColor? {
        var color: UIColor?  = nil
        switch arc4random() % 5 {
        case 0:
            color = .green
        case 1:
            color = .blue
        case 2:
            color = .orange
        case 3:
            color = .red
        case 4:
            color = .gray
        default:
            color = .purple
        }
        return color
    }
    
    lazy var stackView: UIStackView = {
        /// 不能设置背景色
       let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 10
        stackView.alignment = UIStackView.Alignment.center
        stackView.distribution = UIStackView.Distribution.equalCentering
        return stackView
    }()
    
    func setupConstraints() {
        let mGuide = self.view.layoutMarginsGuide
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.leadingAnchor.constraint(equalTo: mGuide.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: mGuide.trailingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: mGuide.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: mGuide.bottomAnchor).isActive = true
    }

    
}

let svc = StackViewController()

svc.view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 320, height: 480))
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = svc.view
