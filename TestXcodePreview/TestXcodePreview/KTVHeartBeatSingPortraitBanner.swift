//
//  KTVHeartBeatSingPortraitBanner1.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/10/24.
//

import UIKit

// 自定义 UICollectionViewFlowLayout 用于实现堆叠布局
class StackedFlowLayout: UICollectionViewFlowLayout {
    
    let itemOverlap: CGFloat = 22.0 // 控制头像之间的重叠量
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        for (index, attribute) in attributes.enumerated() {
            if attribute.frame.origin.x != 0 {
                attribute.frame.origin.x -= itemOverlap * CGFloat(attribute.indexPath.item)
                attribute.zIndex = index
            }
        }
        
        return attributes
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else {
            return CGSize.zero
        }
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        
        // 获取 cell 的大小（默认为 itemSize）
        let itemHeight = itemSize.height
        let collectionViewWidth = collectionView.bounds.width
        
        // 计算 contentSize 的高度
        // 无论头像数量大于还是小于 3，都使用堆叠效果
        let totalWidth = CGFloat(numberOfItems) * itemSize.width - CGFloat(numberOfItems-1) * itemOverlap
        
        // 返回计算出的 contentSize
        return CGSize(width: totalWidth + 16, height: itemHeight)
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

// 自定义 UICollectionViewCell
class AvatarCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16 // 圆形头像
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.backgroundColor = .red
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with avatar: String) {
        // 假设头像是本地图片
        imageView.image = UIImage(named: avatar)
        //imageView.setImageURLAndLoading(URL(string: avatar))
    }
}

class KTVHeartBeatSingPortraitBanner: UIView ,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    private var collectionView: UICollectionView!
    private var startIndex = 0
    var avatars: [String] = []  {
           didSet {
               self.clipsToBounds = true
               setupCollectionView()
               startAvatarCarousel()
           }
    }
    
  
        private var displayedAvatars: [String] = [] // 当前显示的头像
        private var timer: Timer?

        
        private func setupCollectionView() {
            if collectionView != nil {
                collectionView.removeFromSuperview()
                collectionView = nil
            }
            
            let layout = StackedFlowLayout()
            layout.itemSize = CGSize(width: 32, height: 32)
            layout.scrollDirection = .horizontal
            
            collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
            collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: "AvatarCell")
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = .clear
            
            self.addSubview(collectionView)
            
            // 初始化显示的头像（最多3个）
            displayedAvatars = Array(avatars.prefix(3))
            self.startIndex = min(3,self.avatars.count)
        }
        
        private func startAvatarCarousel() {
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(performAvatarCarousel), userInfo: nil, repeats: true)
        }
    
    override func layoutSubviews() {
        if self.collectionView == nil {
            return
        }
        if displayedAvatars.count < 3 {
            let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
            let x = (self.bounds.size.width - contentSize.width) / 2
            self.collectionView.frame = CGRect(x: x, y: 0, width: contentSize.width, height: self.bounds.size.height)
        } else {
            self.collectionView.frame = CGRect(x: 1, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        }
        
    }
        
        @objc private func performAvatarCarousel() {
            guard avatars.count > 3 else {
                timer?.invalidate() // 当头像数量小于 3 时停止轮播
                return
            }

            // 移除第一个头像
            let _ = displayedAvatars.removeFirst()

            // 查找下一个要插入的头像
            let nextAvatar =  self.avatars[self.startIndex % self.avatars.count]
            displayedAvatars.append(nextAvatar)
//            if let nextAvatar = avatars.first(where: { !displayedAvatars.contains($0) }) {
//                // 在末尾插入一个新的头像
//                displayedAvatars.append(nextAvatar)
//            }
            
            // 删除第一个头像
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [IndexPath(item: 0, section: 0)])
                self.collectionView.insertItems(at: [IndexPath(item: self.displayedAvatars.count - 1, section: 0)])
            }, completion: { _ in
            })
            self.startIndex = self.startIndex + 1
        }
        
        // MARK: - UICollectionView DataSource
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return displayedAvatars.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as! AvatarCell
            let avatar = displayedAvatars[indexPath.item]
            cell.configure(with: avatar)
            return cell
        }
    
        override var intrinsicContentSize: CGSize {
            return self.bounds.size
        }

}


#Preview("PortraitBanner", traits: .portrait) {
    let view = KTVHeartBeatSingPortraitBanner(frame: CGRect(x: 0, y: 100, width: 100, height: 32))
    //    view.icons = ["avatar1", "avatar2", "avatar3","child", "cup", "member", "like_test"]
    //view.icons = ["avatar1", "avatar2", "avatar3"]
    view.avatars = ["avatar1", "avatar2", "avatar3","child"]
    //view.backgroundColor = .red
    return view
}
