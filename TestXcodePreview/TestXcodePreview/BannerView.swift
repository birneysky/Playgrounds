//
//  BannerView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/4/8.
//

import UIKit

class BannerView: UIView {

    // MARK: - Properties

       private var scrollView: UIScrollView!
       private var pageControl: UIPageControl!
       private var timer: Timer?
       private var images: [UIImage] = [UIImage(named: "image1")!, UIImage(named: "image2")!]
       private var currentPage = 0

       // MARK: - Initialization

       override init(frame: CGRect) {
           super.init(frame: frame)
           setup()
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           setup()
       }

       // MARK: - Setup

       private func setup() {
           // 初始化scrollView
           scrollView = UIScrollView(frame: bounds)
           scrollView.delegate = self
           scrollView.isPagingEnabled = true
           scrollView.showsHorizontalScrollIndicator = false
           addSubview(scrollView)

           // 初始化pageControl
           pageControl = UIPageControl(frame: CGRect(x: 0, y: bounds.height - 20, width: bounds.width, height: 20))
           pageControl.currentPageIndicatorTintColor = .red
           pageControl.pageIndicatorTintColor = .gray
           addSubview(pageControl)

           // 初始化timer
           timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
           reload()
       }

       // MARK: - Public Methods

       func setImages(_ images: [UIImage]) {
           self.images = images
           reload()
       }

       // MARK: - Private Methods

       private func reload() {
           // 更新scrollView
           scrollView.contentSize = CGSize(width: bounds.width * CGFloat(images.count * 2), height: bounds.height)
           scrollView.setContentOffset(CGPoint(x: bounds.width * CGFloat(images.count), y: 0), animated: false)

           for (index, image) in images.enumerated() {
               let imageView = UIImageView(frame: CGRect(x: bounds.width * CGFloat(index), y: 0, width: bounds.width, height: bounds.height))
               imageView.image = image
               scrollView.addSubview(imageView)
           }

           // 更新pageControl
           pageControl.numberOfPages = images.count
           currentPage = 0
           pageControl.currentPage = currentPage

           // 重置timer
           timer?.invalidate()
           timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
       }

       @objc private func autoScroll() {
           currentPage = (currentPage + 1) % images.count
           UIView.animate(withDuration: 2) {
               self.scrollView.contentOffset = CGPoint(x: self.bounds.width * CGFloat(self.currentPage), y: 0)
           }
//           scrollView.setContentOffset(CGPoint(x: bounds.width * CGFloat(currentPage), y: 0), animated: true)
           
       }
    
        override var intrinsicContentSize: CGSize {
            return self.bounds.size
        }
}

// MARK: - UIScrollViewDelegate
extension BannerView: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / bounds.width)
        currentPage = index % images.count
        pageControl.currentPage = currentPage
        if scrollView.contentOffset.x < bounds.width * CGFloat(images.count) {
            scrollView.setContentOffset(CGPoint(x: bounds.width * CGFloat(images.count * 2), y: 0), animated: false)
        }
    }
}


#Preview("BannerView", traits: .portrait) {
    var view = BannerView(frame: .init(x: 0, y: 0, width: 300, height: 100))
    //view.cornerSize = 32
    //view.backgroundColor = .systemPink
    return view
}

