//
//  KTVHeartBeatSingPortraitBanner1.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/10/24.
//

import UIKit

// 自定义 UICollectionViewFlowLayout 用于实现堆叠布局
class StackedFlowLayout: UICollectionViewFlowLayout {
    
    var spacing: CGFloat = -8.0 // 控制头像之间的重叠量
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        for (index, attribute) in attributes.enumerated() {
            if attribute.frame.origin.x != 0 {
                attribute.frame.origin.x += spacing * CGFloat(attribute.indexPath.item)
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
        
        let itemHeight = itemSize.height
        
        // 计算 contentSize 的宽度
        let totalWidth = CGFloat(numberOfItems) * itemSize.width + CGFloat(numberOfItems-1) * spacing + sectionInset.left + sectionInset.right
        
        return CGSize(width: totalWidth , height: itemHeight)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        attributes?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        attributes?.alpha = 0
        return attributes
    }

    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        attributes?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        attributes?.alpha = 0
        return attributes
    }
}


class AvatarCell: UICollectionViewCell {
    
     let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
    
    override func layoutSubviews() {
        imageView.frame = self.bounds
    }
    
    func configure(with avatar: String) {
        // 假设头像是本地图片
        imageView.image = UIImage(named: avatar)
        //imageView.setImageURLAndLoading(URL(string: avatar))
    }
}

class KTVHeartBeatSingPortraitBanner: UIView ,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    private var displayedAvatars: [String] = [] // 当前显示的头像
    private var timer: Timer?
    private var collectionView: UICollectionView!
    private var layout: StackedFlowLayout!
    private var startIndex = 0
    
    var avatars: [String] = []  {
           didSet {
               self.clipsToBounds = true
               setupCollectionView()
               startAvatarCarousel()
           }
    }
    var itemSize: CGSize = CGSize(width: 32, height: 32) {
        didSet {
            if self.layout != nil {
                self.layout.itemSize = itemSize
                self.layout.invalidateLayout()
            }
        }
    }
    
    var itemSpaceing: CGFloat = -8 {
        didSet {
            if self.layout != nil {
                self.layout.spacing = itemSpaceing
                self.layout.invalidateLayout()
            }
        }
    }
    
    private func setupCollectionView() {
        if collectionView != nil {
            collectionView.removeFromSuperview()
            collectionView = nil
        }
        
        let layout = StackedFlowLayout()
        layout.itemSize = CGSize(width: 32, height: 32)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.spacing = itemSpaceing
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: "AvatarCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        self.addSubview(collectionView)
        self.layout = layout
        
        // 初始化显示的头像（最多3个）
        displayedAvatars = Array(avatars.prefix(3))
        self.startIndex = min(3,self.avatars.count)
    }
        
    private func startAvatarCarousel() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(performAvatarCarousel), userInfo: nil, repeats: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = self.bounds
    }
        
    @objc private func performAvatarCarousel() {
        guard avatars.count > 3 else {
            timer?.invalidate()
            return
        }

        let _ = displayedAvatars.removeFirst()
        collectionView.deleteItems(at: [IndexPath(item: 0, section: 0)])

        let nextAvatar =  self.avatars[self.startIndex % self.avatars.count]
        displayedAvatars.append(nextAvatar)
        self.collectionView.insertItems(at: [IndexPath(item: self.displayedAvatars.count - 1, section: 0)])

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
        cell.imageView.layer.cornerRadius = self.itemSize.height / 2
        cell.imageView.clipsToBounds = true
        cell.imageView.layer.borderWidth = 1
        cell.imageView.layer.borderColor = UIColor.white.cgColor
        return cell
    }

    override var intrinsicContentSize: CGSize {
        if self.collectionView  != nil {
            return self.collectionView.collectionViewLayout.collectionViewContentSize
        }
        return self.bounds.size
    }

}

@available(iOS 17.0, *)
#Preview("PortraitBanner", traits: .portrait) {
    let view = KTVHeartBeatSingPortraitBanner()
    view.avatars = ["avatar1", "avatar2", "avatar3","child", "cup", "member", "like_test"]
    //view.avatars = ["avatar1", "avatar2", "avatar3"]
    //view.avatars = ["avatar1", "avatar2"]
    //view.avatars = ["avatar1", "avatar2", "avatar3","child"]
    view.itemSize = CGSize(width: 50, height: 50)
    view.itemSpaceing = -8
    view.backgroundColor = .green
    return view
}
