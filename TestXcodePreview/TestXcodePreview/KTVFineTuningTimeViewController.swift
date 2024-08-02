//
//  KTVFineTuningTimeViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/30.
//

import UIKit

class KTVFineTuningTimeViewController: UIViewController {

    @IBOutlet weak var container: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        for view in container.subviews {
            view.removeFromSuperview()
        }
        let beginView = KTVScaleLineView(frame: CGRect(x: 0, y: 0, width: 397, height: 0), style: .begin, startTime: 0, endTime: 10000, firstLyric: "尽管讲出不快吧", secondLyric: "仍然紧守于身边")
        beginView.backgroundColor = rgba("#333333ff")
        
        self.container.addArrangedSubview(beginView)

        let label = UILabel()
        label.textColor = rgba("#FF3348FF")
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = "•••    中间歌词已省略    •••"
        self.container.addArrangedSubview(label)
        
//        let label2 = UILabel()
//        label2.textColor = rgba("#FF3348FF")
//        label2.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        label2.text = "请不必惊怕"
//        self.container.addArrangedSubview(label2)
        
        let endView = KTVScaleLineView(frame: CGRect(x: 0, y: 0, width: 397, height: 0), style: .end, startTime: 20, endTime: 50, firstLyric: "尽管讲出不快吧", secondLyric: "仍然紧守于身边")
        endView.backgroundColor = rgba("#333333ff")
        self.container.addArrangedSubview(endView)
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
    
    let parentController = UIViewController()
    parentController.view.backgroundColor = .white
    let controller = KTVFineTuningTimeViewController.controller()
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
