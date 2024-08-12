//
//  GradientLabel2.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/8/13.
//

import UIKit

class GradientLabel2: UIView {

    private lazy  var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }()
    
    private lazy var label: UILabel = {
       UILabel()
    }()
    
    private lazy var label2: UILabel = {
       UILabel()
    }()
    
    var text: String? {
        didSet {
            self.label.text = text
            self.label.sizeToFit()
            
            self.label2.attributedText = createAttributedString(from: text ?? "")
            //self.label2.textColor = .red
            self.label2.sizeToFit()
        }
    }
    
    var font: UIFont? {
        didSet {
            self.label.font = font
            self.label.sizeToFit()
            
            self.label2.font = font
            self.label2.sizeToFit()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
        self.addSubview(label)
        self.addSubview(label2)
        gradientLayer.mask = self.label.layer
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bounds = self.label.bounds
        gradientLayer.frame = self.label.frame
    }
    
    override var intrinsicContentSize: CGSize {
        self.label.bounds.size
    }
    
    func createAttributedString(from text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)

        // Emoji Regular Expression Pattern
        let emojiPattern = "[\\p{Emoji}\\p{Emoji_Presentation}\\p{Emoji_Modifier}\\p{Emoji_Modifier_Base}\\p{Emoji_Component}]"
        
        do {
            // Create a regex object for matching emojis
            let regex = try NSRegularExpression(pattern: emojiPattern, options: [])
            
            // Find all matches in the string
            let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
            
            // Set the default text color to red
            attributedString.addAttribute(.foregroundColor, value: UIColor.clear, range: NSRange(location: 0, length: text.utf16.count))
            
            // Loop through all the matches and reset their color to default (black or system)
            for match in matches {
                attributedString.addAttribute(.foregroundColor, value: UIColor.label, range: match.range)
            }
            
        } catch {
            print("Failed to create regex: \(error)")
        }

        return attributedString
    }


}


#Preview {
    let view  = GradientLabel2()
    //let view  = StackViewTest()
    view.text = "Hello 🌎♻️🛜🚼🟡🌤️🌞 world"
    view.font = UIFont.systemFont(ofSize: 25)
    return view
}
