//
//  MCInfiniteScrollView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/4/8.
//

import UIKit

class MCInfiniteScrollView: UIView, UIScrollViewDelegate {

    private var scrollView = UIScrollView()
    private var imageView1 = UIImageView()
    private var imageView2 = UIImageView()
    private var imageView3 = UIImageView()
    private var imageViews:[UIImageView] = []
    private var preContentOffse: CGPoint = .zero
    // 图片数组
      private var images: [UIImage] = [UIImage(systemName: "0.circle")!, UIImage(systemName: "1.circle")!, UIImage(systemName: "2.circle")!,  UIImage(systemName: "3.circle")!,  UIImage(systemName: "4.circle")!]

      // 当前显示的图片索引
      private var currentPageIndex: Int = 0

      // 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
      }

      required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }

      // 私有方法，用于设置 UIScrollView 的属性和添加子视图
      private func setup() {
          let width = self.bounds.size.width
          let height = self.bounds.size.height
          scrollView.frame = self.bounds
          scrollView.contentSize = CGSize(width: width * 3, height: height)
          scrollView.delegate = self
          scrollView.isPagingEnabled = true
          scrollView.showsHorizontalScrollIndicator = false
          addSubview(scrollView)
          
          
          imageView1.image = images[0]
          imageView1.frame =  CGRect(x: 0, y: 0, width:width , height: height)
          imageView1.backgroundColor = .red
          scrollView.addSubview(imageView1)
          imageViews.append(imageView1)
          
          imageView2.image = images[1]
          imageView2.frame =  CGRect(x: width, y: 0, width:width , height: height)
          imageView2.backgroundColor = .green
          scrollView.addSubview(imageView2)
          imageViews.append(imageView2)
          
          imageView3.image = images[2]
          imageView3.frame =  CGRect(x: width * 2, y: 0, width:width , height: height)
          imageView3.backgroundColor = .blue
          scrollView.addSubview(imageView3)
          imageViews.append(imageView3)
        
      }

      // UIScrollViewDelegate 方法
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        
        
        if abs(scrollView.contentOffset.x - preContentOffse.x) != width {
            return
        }
        if scrollView.contentOffset.x - preContentOffse.x > 0 {
            currentPageIndex = (currentPageIndex + 1) % images.count
        } else {
            if currentPageIndex - 1 < 0 {
                currentPageIndex = images.count - 1
            } else {
                currentPageIndex = (currentPageIndex - 1) % images.count
            }
        }
        NSLog("############# \(currentPageIndex) offset :\(scrollView.contentOffset.x), previous:\(preContentOffse.x)")

        if scrollView.contentOffset.x == scrollView.contentSize.width -  width  {
            let first =  imageViews.removeFirst()
            imageViews.append(first)
            //currentPageIndex = 0
        }
        
        if scrollView.contentOffset.x == 0 {
            let last =  imageViews.removeLast()
            imageViews.insert(last, at: 0)
        }
        
        for i in 0 ..< 3 {
            imageViews[i].frame = CGRect(x: width * CGFloat(i), y: 0, width: width, height: height)
        }
        
        if currentPageIndex - 1 < 0 {
            imageViews[0].image = images.last
        } else {
            imageViews[0].image = images[currentPageIndex - 1]
        }
        
        imageViews[1].image = images[currentPageIndex]
        if currentPageIndex + 1 >= images.count {
            imageViews[2].image = images[0]
        } else {
            imageViews[2].image = images[currentPageIndex + 1]
        }
       
        
        
      scrollView.contentOffset = CGPoint(x: width, y: 0)
        preContentOffse = scrollView.contentOffset
    }
    
    override var intrinsicContentSize: CGSize {
        return self.bounds.size
    }

}

#Preview("MCInfiniteScrollView", traits: .portrait) {
    let scrollView = MCInfiniteScrollView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
    return scrollView
}
