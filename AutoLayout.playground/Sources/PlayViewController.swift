import UIKit

public class PlayViewController : UIViewController {
    
    // MARK: - override
    override public func loadView() {
        super.loadView()
        self.title = "AutoLayout"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.label)
        self.view.addSubview(self.viewA)
        self.view.addSubview(self.viewB)
        self.view.addSubview(self.viewC)
        self.view.addSubview(self.viewD)
        setupConstraints()
    }
    
    // MARK: -  Helpers
    func setupConstraints() {
        let mGuide = self.view.layoutMarginsGuide
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.label.centerXAnchor.constraint(equalTo: mGuide.centerXAnchor).isActive = true
        self.label.centerYAnchor.constraint(equalTo: mGuide.centerYAnchor).isActive = true
        
        self.viewA.translatesAutoresizingMaskIntoConstraints = false
        self.viewA.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.viewA.heightAnchor.constraint(equalTo: self.viewA.widthAnchor).isActive = true
        self.viewA.leadingAnchor.constraint(equalTo: mGuide.leadingAnchor, constant: 16).isActive = true
        self.viewA.topAnchor.constraint(equalTo: mGuide.topAnchor, constant: 16).isActive = true
        
        self.viewB.translatesAutoresizingMaskIntoConstraints = false
        self.viewB.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.viewB.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.viewB.topAnchor.constraint(equalTo: mGuide.topAnchor, constant: 16).isActive = true
        self.viewB.trailingAnchor.constraint(equalTo: mGuide.trailingAnchor, constant: -16).isActive = true
        
        self.viewC.translatesAutoresizingMaskIntoConstraints = false
        self.viewC.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.viewC.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.viewC.leadingAnchor.constraint(equalTo: mGuide.leadingAnchor, constant: 16).isActive = true
        self.viewC.bottomAnchor.constraint(equalTo: mGuide.bottomAnchor, constant: -16).isActive = true
        
        self.viewD.translatesAutoresizingMaskIntoConstraints = false
        self.viewD.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.viewD.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.viewD.bottomAnchor.constraint(equalTo: mGuide.bottomAnchor, constant: -16).isActive = true
        self.viewD.trailingAnchor.constraint(equalTo: mGuide.trailingAnchor, constant: -16).isActive = true
    }
    
    // MARK: -  Properties
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Hello World"
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var viewA: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.red
        return view
    }()
    
    lazy var viewB: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    lazy var viewC: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    lazy var viewD: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.green
        return view
    }()
    

}
