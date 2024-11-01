//
//  KTVSoundEditingCouponPromptViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/8/22.
//

import UIKit

class KTVSoundEditingCouponPromptViewController: UIViewController {
    @objc var okHandler: (()->Void)? = nil
    @objc var cancelHandler: (()->Void)? = nil
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.borderColor = rgba("#EEEEEEFF").cgColor
        cancelButton.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func okAction(_ sender: UIButton) {
        okHandler?()
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        cancelHandler?()
    }
}


@available(iOS 17.0, *)
#Preview{
    let parentController = UIViewController()
    parentController.view.backgroundColor = .black
    let controller = KTVSoundEditingCouponPromptViewController.controller()
    controller.okHandler = {
        print("0kaaaaa")
    }
    controller.cancelHandler = {
        print("cancel")
    }
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.centerXAnchor.constraint(equalTo: parentController.view.centerXAnchor),
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.widthAnchor.constraint(equalToConstant: 291),
        controller.view.heightAnchor.constraint(equalToConstant: 377),
    ])
    return parentController;
}
