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
        let beginView = KTVScaleLineView(frame: CGRect(x: 0, y: 0, width: 397, height: 0), style: .begin, startTime: 0, endTime: 10000, firstLyric: "尽管讲出不快吧", secondLyric:nil)
        beginView.backgroundColor = rgba("#333333ff")
        
        self.container.addArrangedSubview(beginView)
        //self.container.spacing = -20
//        let label = UILabel()
//        label.textColor = rgba("#FF3348FF")
//        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        label.text = "•••    中间歌词已省略    •••"
//        self.container.addArrangedSubview(label)
        
        let statckView = UIStackView()
        statckView.axis = .horizontal
        statckView.alignment = .center
        statckView.distribution = .equalSpacing;
        statckView.spacing = 0;
        
        let leftlabel = UILabel()
        leftlabel.textColor = rgba("#FF3348FF")
        leftlabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        leftlabel.text = "•••    "
        statckView.addArrangedSubview(leftlabel)
        
        let middlelabel = UILabel()
        middlelabel.textAlignment = .center
        middlelabel.textColor = rgba("#FF3348FF")
        middlelabel.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        middlelabel.text = "中间歌词已省略"
        middlelabel.backgroundColor = UIColor(_colorLiteralRed: 255.0/255.0, green: 51/255.0, blue: 72/255.0, alpha: 0.08)
        middlelabel.layer.cornerRadius = 4
        middlelabel.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            middlelabel.widthAnchor.constraint(equalToConstant: 93),
            middlelabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        statckView.addArrangedSubview(middlelabel)
        
        let rightlabel = UILabel()
        rightlabel.textColor = rgba("#FF3348FF")
        rightlabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        rightlabel.text = "    •••"
        statckView.addArrangedSubview(rightlabel)
        self.container.addArrangedSubview(statckView)
        //middlelabel.height = statckView.height
        
        
        
//        let label2 = UILabel()
//        label2.textColor = rgba("#FF3348FF")
//        label2.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        label2.text = "请不必惊怕"
//        self.container.addArrangedSubview(label2)
        
        let endView = KTVScaleLineView(frame: CGRect(x: 0, y: 0, width: 397, height: 0), style: .end, startTime: 20, endTime: 50, firstLyric: nil, secondLyric: "仍然紧守于身边")
        endView.backgroundColor = .clear
        //endView.backgroundColor = rgba("#333333ff")
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
