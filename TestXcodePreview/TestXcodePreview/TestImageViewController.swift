//
//  TestImageViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/16.
//

import UIKit

class TestImageViewController: UIViewController {

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

#Preview {
    let controller = TestImageViewController.controller()
    return controller;
}
