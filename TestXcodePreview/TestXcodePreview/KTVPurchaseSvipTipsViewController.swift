//
//  KTVPurchaseTipsViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/10/10.
//

import UIKit

@objc enum KTVPurchaseSvipTipsStyle: Int {
    case buy = 0
    case setting = 1
}


class KTVPurchaseSvipTipsViewController: UIViewController {
    @objc var tipStyle: KTVPurchaseSvipTipsStyle = .buy
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tipsLabel: UILabel!
    //@IBOutlet weak var button: UIButton!
    @IBOutlet weak var buttonBackground: KTVColorsGradientView!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    @objc var tipText = ""
    @objc var buttonText = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        tipsLabel.text = tipText
        buttonLabel.text = buttonText
        if tipStyle == .buy {
            iconImageView.removeFromSuperview()
            arrowIcon.removeFromSuperview()
            tipsLabel.text = tipText
            buttonBackground.isHidden = false
            buttonLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
            buttonLabel.textColor = rgba("#593000FF")
        }
        
        if tipStyle == .setting {
            buttonBackground.isHidden = true
            buttonLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            buttonLabel.textColor = rgba("#593000FF")
        }
    }
    


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func buttonAction(_ sender: UIControl) {
        print("hahahhahahah489490284902")
    }
}



#Preview {
    
    let parentController = UIViewController()
    parentController.view.backgroundColor = .white
    let controller = KTVPurchaseSvipTipsViewController.controller()
//    controller.tipStyle = .setting
//    controller.tipText = "隐藏关注列表"
//    controller.buttonText = "已设置"
    
    controller.tipStyle = .buy
    controller.tipText = "开通SVIP，背景图上限可提升至30张ii"
    controller.buttonText = "开通SVIP"
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor),
        controller.view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor),
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.heightAnchor.constraint(equalToConstant: 44),
    ])
    return parentController;
}
