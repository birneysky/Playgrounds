import UIKit
import Foundation

class FilterDetailViewController: UIViewController, FilterSliderViewDelegate {
    
    var filterName: String!
    private var filter: CIFilter!
    private var filterParameters: [FilterParameter] = []
    
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
        setupParameterDescriptors()

        filterProcessingImage(img: self.img, param: nil)
    }
    
    // MARK: - Helper
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
    
    func filterProcessingImage(img: CIImage?,param: FilterParameter?) {
        let indicator =  UIActivityIndicatorView(style: .whiteLarge)
        self.view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        indicator.startAnimating()
        DispatchQueue.global().async {
             self.filter.setValue(img, forKey: "inputImage")
            if let aparam = param {
                self.filter.setValue(aparam.currentValue, forKey: aparam.key)
                print("🤑🤑🤑🤑🤑 \(aparam.key):\(aparam.currentValue)")
            }
            DispatchQueue.main.async {
                guard let outImg = self.filter.outputImage else {
                    fatalError("outImg is nil")
                }
                indicator.stopAnimating();
                self.imageView.image = UIImage(ciImage: outImg)
                indicator.removeConstraints(indicator.constraints)
                indicator.removeFromSuperview()
            }
        }
    }
    
    func setupParameterDescriptors() {
        let inputKeyNames = self.filter.inputKeys.filter { (keyName) -> Bool in
            return keyName != kCIInputImageKey
        }
        let attributes = self.filter.attributes;
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
        for item in parameters {
            if item != nil {
                self.filterParameters.append(item!)
            }
        }
    }
    // MARK: - FilterSliderViewDelegate
    func valueDidChange(_ value: Float, minimum: Float, maximum: Float, forKey key: String) {
        print("didChangeValue:\(value),\(minimum),\(maximum)forKey:\(key)")
        let aparam = FilterParameter(name: key, key: key, minimumValue: minimum, maximumValue: maximum, currentValue: value)
        let index =  self.filterParameters.firstIndex { (filterParameter) -> Bool in
            return filterParameter.key == key
        }
        guard let i = index else {
            fatalError("\(key) was not foud")
        }
        self.filterParameters[i].currentValue = value
        filterProcessingImage(img: self.img, param: aparam)
    }
    
    
    // MARK: - Target action
    @objc private func composeAction() {
        print("composeAction")
       
        if self.filterParameters.count == 0 {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }
        print(self.filterParameters)
        let fppvc =  FilterParamPannelViewController(params: self.filterParameters)
        let fpc = FilterPresentationController(presentedViewController: fppvc, presenting: self)
        fppvc.transitioningDelegate = fpc
        self.present(fppvc, animated: true, completion: nil)
    }
    private lazy var img: CIImage? = {
        let path = Bundle.main.path(forResource: "img_009", ofType: "png")
        let url = URL(fileURLWithPath: path!);
        let img = CIImage(contentsOf: url)
        return img
    }()
    // MARK: - lazy load
    private lazy var imageView: UIImageView = {
        let imgv = UIImageView(frame: CGRect.zero)
        imgv.contentMode = .scaleAspectFit
        imgv.clipsToBounds = true
        imgv.backgroundColor = UIColor.lightGray
        return imgv
    }()
}
