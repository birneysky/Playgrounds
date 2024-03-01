//
//  TestGradientViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/3/1.
//

import UIKit

class TestGradientViewController: UIViewController {

    @IBOutlet weak var gradientView1: KTVColorsGradientView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let y = self.gradientView1.frame.maxY + 20
        let view  = KTVColorsGradientView(frame: CGRect(x: 16, y: y, width: 300, height: 44))
        view.layer.cornerRadius = 22
        view.setColors([
            UIColor(named: "#FFB2D933")!,
            UIColor(named: "#FCD5FF")!
        ])
        
        self.view.addSubview(view)
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
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let controller = sb.instantiateViewController(withIdentifier: "TestGradientViewController")
    return controller;
}
