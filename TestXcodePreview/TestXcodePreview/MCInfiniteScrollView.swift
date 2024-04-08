//
//  MCInfiniteScrollView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/4/8.
//

import UIKit

class MCInfiniteScrollView: UIScrollView, UIScrollViewDelegate {

    // 图片数组
      private var images: [UIImage] = [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(systemName: "square.and.arrow.up")!]

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
        // 设置 contentSize
        contentSize = CGSize(width: frame.width * 3, height: frame.height)

        // 添加子视图
        for i in 0..<3 {
          let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * frame.width, y: 0, width: frame.width, height: frame.height))
          imageView.image = images[currentPageIndex + i]
          addSubview(imageView)
        }

        // 设置初始偏移量
        contentOffset = CGPoint(x: frame.width, y: 0)

        // 添加代理
        delegate = self
      }

      // UIScrollViewDelegate 方法
      func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 判断是否滑动到最后一张图片
        if contentOffset.x == contentSize.width - frame.width {
          // 将第一个 UIImageView 的 frame 设置为 x = 屏幕宽度 * 2
          let imageView1 = subviews[0] as! UIImageView
          imageView1.frame = CGRect(x: frame.width * 2, y: 0, width: frame.width, height: frame.height)

          // 将第二个 UIImageView 的 frame 设置为 x = 0
          let imageView2 = subviews[1] as! UIImageView
          imageView2.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

          // 更新 currentPageIndex
          currentPageIndex = (currentPageIndex + 1) % images.count

          // 将 contentOffset 设置为 x = 屏幕宽度
          contentOffset = CGPoint(x: frame.width, y: 0)
        }
      }
    
    override var intrinsicContentSize: CGSize {
        return self.bounds.size
    }

}

#Preview("MCInfiniteScrollView", traits: .portrait) {
    let scrollView = MCInfiniteScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    return scrollView
}
