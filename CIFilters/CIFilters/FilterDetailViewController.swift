//
//  FilterDetailViewController.swift
//  CIFilters
//
//  Created by birney on 2019/4/28.
//  Copyright © 2019 COOL. All rights reserved.
//

import UIKit

class FilterDetailViewController: UIViewController, FilterSliderViewDelegate {

    var filterName: String!
    private var filter: CIFilter!
    private var filterParameters: [FilterParameter] = []
    private let serialQueue = DispatchQueue(label: "cn.cool.filter.processing")
    
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
        
        //self.imageView.image = UIImage(named: "img_009")
        filterProcessingImage(img: self.img, param: nil)

        // Do any additional setup after loading the view.
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
        guard self.filter.inputKeys.contains(kCIInputImageKey) else {
            return
        }
        let indicator =  UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = UIColor.lightGray
        self.view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        indicator.startAnimating()
        serialQueue.async {
            self.filter.setValue(img, forKey: kCIInputImageKey)
            if let aparam = param {
                self.filter.setValue(aparam.currentValue, forKey: aparam.key)
            }
            DispatchQueue.main.async {
                indicator.stopAnimating();
                indicator.removeConstraints(indicator.constraints)
                indicator.removeFromSuperview()

                guard let outImg = self.filter.outputImage else {
                    //fatalError("outImg is nil")
                    print("📛📛📛📛  outImge is nil")
                    return
                }
                
                self.imageView.image = UIImage(ciImage: outImg)
            }
        }
    }
    
    func setupParameterDescriptors() {
        guard self.filter.inputKeys.contains(kCIInputImageKey) else {
            print("📛📛📛📛 inputkey not constains inputImge")
            return
        }
        
        let inputKeyNames = self.filter.inputKeys.filter { (keyName) -> Bool in
            return keyName != kCIInputImageKey
        }

        let attributes = self.filter.attributes;
        let parameters = inputKeyNames.map { (keyName) -> FilterParameter? in
            guard  let attribute = attributes[keyName] else {
                fatalError("invalid key name")
            }
            print("🤑🤑🤑🤑🤑 attributeType:\(type(of: attribute)):\(attribute)")
            if let attDic = attribute as? Dictionary<String, AnyObject>,
                let minValue = attDic[kCIAttributeSliderMin] as? Float,
                let maxValue = attDic[kCIAttributeSliderMax] as? Float,
                let defaultValue = attDic[kCIAttributeDefault] as? Float {
                let displayName = keyName
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
    @IBAction func composeAction(_ sender: Any) {
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
    
    // MARK: - lazy load
    private lazy var img: CIImage? = {
        //let path = Bundle.main.path(forResource: "img_009", ofType: "png")
//        let url = URL(fileURLWithPath: path!);
//        let img = CIImage(contentsOf: url)
        let imge = UIImage(named: "img_009")
        let img = CIImage(cgImage: (imge?.cgImage)!)
        return img
    }()

    private lazy var imageView: UIImageView = {
        let imgv = UIImageView(frame: CGRect.zero)
        imgv.contentMode = .scaleAspectFit
        imgv.clipsToBounds = true
        imgv.backgroundColor = UIColor.white
        return imgv
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
