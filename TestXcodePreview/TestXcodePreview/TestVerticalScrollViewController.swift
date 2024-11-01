//
//  TestVerticalScrollViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/30.
//

import UIKit

class TestVerticalScrollViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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

}


@available(iOS 17.0, *)
#Preview{
    
    let parentController = UIViewController()
    parentController.view.backgroundColor = .white
    let controller = TestVerticalScrollViewController.controller()
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor),
        controller.view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor),
        controller.view.bottomAnchor.constraint(equalTo: parentController.view.bottomAnchor),
        controller.view.heightAnchor.constraint(equalToConstant: 420),
    ])
    return parentController;
}
