import UIKit
import Foundation

class FilterDetailViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let imgv = UIImageView(frame: CGRect.zero)
        imgv.contentMode = .scaleAspectFit
        imgv.clipsToBounds = true
        imgv.backgroundColor = UIColor.lightGray
        return imgv
    }()
    
    var filterName: String!
    private var filter: CIFilter!
    
    init(filterName:String) {
        self.filterName = filterName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
        addSubViews()
        setupConstraints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.filter = CIFilter(name: filterName)
        self.title = self.filter.attributes[kCIAttributeFilterDisplayName] as? String
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeAction))
        
        let path = Bundle.main.path(forResource: "img_010", ofType: "png")
        let url = URL(fileURLWithPath: path!);
        let img = CIImage(contentsOf: url)
        DispatchQueue.global().async {
            self.filter.setValue(img, forKey: "inputImage")
            DispatchQueue.main.async {
                guard let outImg = self.filter.outputImage else {
                    fatalError("outImg is nil")
                }
                
                self.imageView.image = UIImage(ciImage: outImg)
            }
        }
    }
    
    func addSubViews() {
        self.view.addSubview(self.imageView)
    }
    
    func setupConstraints() {
        let mGuide = self.view.layoutMarginsGuide
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: mGuide.topAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: mGuide.bottomAnchor).isActive = true
    }
    
    @objc private func composeAction() {
        print("composeAction")
        let inputKeyNames = self.filter.inputKeys.filter { (keyName) -> Bool in
            return keyName != kCIInputImageKey
        }
        print("🌵🌵🌵🌵inputKeyNames:\(type(of: inputKeyNames)):\(inputKeyNames)")
        let attributes = self.filter.attributes;
        print("☘️☘️☘️☘️ attributes:\(type(of: attributes)):\(attributes)")
        let parameters = inputKeyNames.map { (keyName) -> FilterParameter? in
            guard  let attribute = attributes[keyName] else {
                fatalError("invalid key name")
            }
            print("🤑🤑🤑🤑🤑 attributeType:\(type(of: attribute)):\(attribute)")
            if let attDic = attribute as? Dictionary<String, AnyObject> {
                let displayName = keyName
                let minValue = attDic[kCIAttributeSliderMin] as! Float
                let maxValue = attDic[kCIAttributeSliderMax] as! Float
                let defaultValue = attDic[kCIAttributeDefault] as! Float
                return FilterParameter(name: displayName, key: keyName, minimumValue: minValue, maximumValue: maxValue, currentValue: defaultValue)
            } else {
                return nil
            }
        }
        let aParameters = parameters.filter { (param) -> Bool in
            if param != nil {
                return true;
            } else {
                return false
            }
        }
        if aParameters.count == 0 {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }
        
        let fppvc =  FilterParamPannelViewController(params:aParameters as! [FilterParameter])
        let fpc = FilterPresentationController(presentedViewController: fppvc, presenting: self)
        fppvc.transitioningDelegate = fpc
        self.present(fppvc, animated: true, completion: nil)
    }
}
