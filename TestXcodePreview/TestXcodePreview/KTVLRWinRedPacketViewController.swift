//
//  KTVLRWinRedPacketViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/17.
//

import UIKit

class KTVLRWinRedPacketViewController: UIViewController {

    @IBOutlet weak var contentContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
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
    // MARK: - Action Selector
    @IBAction func closeAction(_ sender: Any) {
        self.view.isHidden  = true
    }
}


#Preview {
    let parentController = UIViewController()
    parentController.view.backgroundColor = .black
    let controller = KTVLRWinRedPacketViewController.controller()
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.centerXAnchor.constraint(equalTo: parentController.view.centerXAnchor),
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.widthAnchor.constraint(equalToConstant: 243),
        controller.view.heightAnchor.constraint(equalToConstant: 391),
    ])
    return parentController;
}
