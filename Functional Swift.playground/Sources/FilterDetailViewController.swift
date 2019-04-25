import UIKit

class FilterDetailViewController: UIViewController {
    var imageView: UIImageView!
    override func loadView() {
        super.loadView()
        addSubViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupConstraints()
    }
    
    func addSubViews() {
        imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 30)))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.blue
        self.view.addSubview(imageView)
    }
    
    func setupConstraints() {
        let mGuide = self.view.layoutMarginsGuide
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: mGuide.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: mGuide.bottomAnchor).isActive = true
    }
}
