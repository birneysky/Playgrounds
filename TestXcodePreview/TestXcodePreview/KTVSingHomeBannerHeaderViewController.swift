//
//  KTVSingHomeBannerHeaderViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/10/21.
//

import UIKit

class KTVSingHomeBannerHeaderViewController: UIViewController, FSPagerViewDataSource,FSPagerViewDelegate {

    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.pagerView.transformer = FSPagerViewTransformer(type: .linearScale)
        let transform = CGAffineTransform(scaleX: 0.88, y: 1)
        self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
        self.pagerView.decelerationDistance = 1//FSPagerView.automaticDistance
        self.pagerView.automaticSlidingInterval = 2
        self.pagerView.isInfinite = true
    }


    
    // MARK:- FSPagerViewDataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    

}


#Preview {
    
    let parentController = UIViewController()
    parentController.view.backgroundColor = .white
    let controller = KTVSingHomeBannerHeaderViewController.controller()

    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor),
        controller.view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor),
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.heightAnchor.constraint(equalToConstant: 200),
    ])
    return parentController;
}
