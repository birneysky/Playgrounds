//
//  KTVHorizontalScrollingBanner.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/5/21.
//

import UIKit


protocol KTVBannerDataConfigurable {
    associatedtype T
    func setData(_ data: T?)
    static func createView() -> Self
}

protocol KTVBannerItemData {
    associatedtype T
    var data: T? { get }
    
}

class KTVHorizontalScrollingBanner <Item: KTVBannerItemData, ItemView: KTVBannerDataConfigurable>
: UIView, UIScrollViewDelegate where ItemView: UIView, ItemView.T == Item.T {
    private var scrollView = UIScrollView()
    private var itemViews:[ItemView] = []
    private var preContentOffse: CGPoint = .zero
    private var timer: Timer?
    private var currentPageIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var items: [Item] = [] {
        didSet {
            stopTimer()
            itemViews.forEach { $0.removeFromSuperview() }
            scrollView.removeFromSuperview()
            itemViews.removeAll()
            setup()
        }
    }
    
    private func setup() {
        guard  items.count > 0 else { return }
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize(width: width * 3, height: height)
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        for i in 0 ..< 3 {
            let itemView = ItemView.createView()
            itemView.frame =  CGRect(x: width * CGFloat(i), y: 0, width:width , height: height)
            scrollView.addSubview(itemView)
            //contentViews.append(contentView)
            itemViews.append(itemView)
        }
        
        if items.count > 1 {
            itemViews[0].setData(items.last?.data ?? nil)
            itemViews[1].setData(items[0].data)
            itemViews[2].setData(items[1].data)
            
            scrollView.contentOffset = CGPoint(x: width, y: 0)
            preContentOffse = CGPoint(x: width, y: 0)
            startTimer()
        } else {
            itemViews[0].setData(items.first?.data )
            scrollView.isScrollEnabled = false
        }
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        guard let t = timer else { fatalError() }
        RunLoop.current.add(t, forMode: .common)
    }
   
    @objc private  func autoScroll() {
        let width = self.bounds.size.width
        var offset = scrollView.contentOffset
        offset.x = offset.x + width
        scrollView.setContentOffset(offset, animated: true)
    }
    
    private func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    private func resetCotentOffsetAndContent(_ scrollView: UIScrollView) {
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        if abs(scrollView.contentOffset.x - preContentOffse.x) != width {
            return
        }
        if scrollView.contentOffset.x - preContentOffse.x > 0 {
            currentPageIndex = (currentPageIndex + 1) % items.count
        } else {
            if currentPageIndex - 1 < 0 {
                currentPageIndex = items.count - 1
            } else {
                currentPageIndex = (currentPageIndex - 1) % items.count
            }
        }
        NSLog("############# \(currentPageIndex) offset :\(scrollView.contentOffset.x), previous:\(preContentOffse.x)")

        if scrollView.contentOffset.x == scrollView.contentSize.width -  width  {
            let first =  itemViews.removeFirst()
            itemViews.append(first)
        }
        
        if scrollView.contentOffset.x == 0 {
            let last =  itemViews.removeLast()
            itemViews.insert(last, at: 0)
        }
        
        for i in 0 ..< 3 {
            itemViews[i].frame = CGRect(x: width * CGFloat(i), y: 0, width: width, height: height)
        }
        
        if currentPageIndex - 1 < 0 {
            itemViews[0].setData(items.last?.data ?? nil)
        } else {
            itemViews[0].setData(items[currentPageIndex - 1].data)
        }
        
        itemViews[1].setData(items[currentPageIndex].data)
        
        if currentPageIndex + 1 >= items.count {
            itemViews[2].setData(items.first?.data ?? nil)
        } else {
            itemViews[2].setData(items[currentPageIndex + 1].data)
        }
       
        scrollView.contentOffset = CGPoint(x: width, y: 0)
        preContentOffse = scrollView.contentOffset
    }
    
    // MARK: - Auto layout
    override var intrinsicContentSize: CGSize {
        return self.bounds.size
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        resetCotentOffsetAndContent(scrollView)
        startTimer()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        resetCotentOffsetAndContent(scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = self.bounds.size.width
        if scrollView.contentOffset.x == scrollView.contentSize.width -  width ||
            scrollView.contentOffset.x == 0 {
            resetCotentOffsetAndContent(scrollView)
        }
        
    }
}

#Preview("KTVHorizontalScrollingBannerA", traits: .portrait) {
    let frame = CGRect(x: 0, y: 0, width: 193, height: 54)
    let banner = KTVHorizontalScrollingBanner<ItemA, KTVBannerItemViewA>(frame: frame)
    banner.backgroundColor = .green
    banner.items = [
        ItemA(backgroundImageName: "ktv_sing_with_past_self", iconImageName: "ktv_past_self_icon", titleText: "0001", subTitleLabel: "0001sub"),
        ItemA(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0002", subTitleLabel: "0002sub"),
        ItemA(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0003", subTitleLabel: "0003sub"),
        ItemA(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0004", subTitleLabel: "0004sub"),
        ItemA(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0005", subTitleLabel: "0005sub"),
        ItemA(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0006", subTitleLabel: "0006sub"),
    ]
    return banner
}

#Preview("KTVHorizontalScrollingBannerB", traits: .portrait) {
    let frame = CGRect(x: 0, y: 0, width: 193, height: 54)
    let banner = KTVHorizontalScrollingBanner<ItemB, KTVBannerItemViewB>(frame: frame)
    banner.backgroundColor = .green
    banner.items = [
        ItemB(backgroundImageName: "ktv_sing_with_past_self", iconImageName: "ktv_past_self_icon", titleText: "0001", subTitleLabel: "0001sub"),
        ItemB(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0002", subTitleLabel: "0002sub"),
        ItemB(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0003", subTitleLabel: "0003sub"),
        ItemB(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0004", subTitleLabel: "0004sub"),
        ItemB(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0005", subTitleLabel: "0005sub"),
        ItemB(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0006", subTitleLabel: "0006sub"),
    ]
    return banner
}
