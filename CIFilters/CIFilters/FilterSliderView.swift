import UIKit

protocol FilterSliderViewDelegate: class {
    func valueDidChange(_ value: Float, minimum: Float, maximum: Float, forKey key: String)
}


class FilterSliderView: UIView {
    
    weak var deletate: FilterSliderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    convenience init(parameter: FilterParameter) {
        self.init(frame: CGRect.zero)
        self.slider.maximumValue = parameter.maximumValue ?? 1
        self.slider.minimumValue = parameter.minimumValue ?? 0
        self.slider.value = parameter.currentValue
        self.nameLabel.text = parameter.key
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
    }
    
    override func layoutSubviews() {
        self.nameLabel.frame = CGRect(x: 10, y: 0, width: self.bounds.width-20, height: 20)
        self.slider.frame = CGRect(x: 8, y: self.nameLabel.frame.maxY+8, width: self.bounds.width-16, height: self.bounds.height-20-16)
        
    }
    
    // MAKR: - Helper
    func addSubviews() {
        self.addSubview(self.nameLabel)
        self.addSubview(self.slider)
    }
    
    
    // MARK: - Target action
    @objc func sliderValueChange(sender: UISlider) {
        if  self.deletate != nil {
            self.deletate?.valueDidChange(sender.value, minimum: sender.minimumValue, maximum: sender.maximumValue, forKey: self.nameLabel.text!)
        }
    }
    
    lazy var slider: UISlider = {
       let slider = UISlider(frame: CGRect.zero)
        slider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .touchUpInside)
        slider.value = 0
        return slider
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        label.text = "xxxx"
        label.textAlignment = .left
        return label
    }()
}

