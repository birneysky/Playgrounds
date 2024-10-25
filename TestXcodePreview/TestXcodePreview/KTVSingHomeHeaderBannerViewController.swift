//
//  KTVSingHomeBannerHeaderViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/10/21.
//

import UIKit

class KTVSingHomeHeaderBannerViewController: UIViewController, FSPagerViewDataSource,FSPagerViewDelegate {

//    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    fileprivate let imageNames = ["12.png"]
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            
            self.pagerView.register(UINib(nibName: "KTVSingHomeInteractionBannerCell", bundle: nil), forCellWithReuseIdentifier: "InteractionCell")
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.pagerView.transformer = FSPagerViewTransformer(type: .linearScale)
        let transform = CGAffineTransform(scaleX: 0.88, y: 1)
        self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
        self.pagerView.decelerationDistance = 1//FSPagerView.automaticDistance
        self.pagerView.automaticSlidingInterval = 6
        self.pagerView.isInfinite = imageNames.count + 1  > 1
    }


    
    // MARK:- FSPagerViewDataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count + 1
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        if index == 0 {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "InteractionCell", at: index)
            if let aCell = cell as? KTVSingHomeInteractionBannerCell {
                aCell.hahah()
            }
            return cell
        } else {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
            cell.imageView?.image = UIImage(named: self.imageNames[index-1])
            cell.imageView?.contentMode = .scaleAspectFit
            return cell
        }
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        print("----------------\(index)")
        if index >= 1 {
            print("----------------\(self.imageNames[index-1])")
        }
    }
    

}


#Preview {
    
    let parentController = UIViewController()
    parentController.view.backgroundColor = .white
    let controller = KTVSingHomeHeaderBannerViewController.controller()

    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor),
        controller.view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor),
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.heightAnchor.constraint(equalToConstant: 109),
    ])
    return parentController;
}
