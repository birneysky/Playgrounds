//
//  NoteLeftAlignedFlowLayout.swift
//  Paste
//
//  Created by Bruce on 2024/3/16.
//

import UIKit

class KTVLeftAlignedFlowLayout: UICollectionViewFlowLayout {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        let horizontalSpacing: CGFloat = minimumInteritemSpacing
        
        // Loop through the cache and adjust items if necessary
        for attributes in layoutAttributes {
            if attributes.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            attributes.frame.origin.x = leftMargin
            
            leftMargin += attributes.frame.size.width + horizontalSpacing
            maxY = max(attributes.frame.maxY, maxY)
        }
        
        return layoutAttributes
    }
    
    
//    override var collectionViewContentSize: CGSize {
//        guard let collectionView = collectionView else { return .zero }
//        
//        // 获取每个 section 的内容宽度和内容高度
//        var contentWidth: CGFloat = collectionView.bounds.width
//        var contentHeight: CGFloat = 0
//        
//        // 计算内容的最大宽度和高度
//        var leftMargin = sectionInset.left
//        var maxY: CGFloat = -1.0
//        let horizontalSpacing: CGFloat = minimumInteritemSpacing
//        let verticalSpacing: CGFloat = minimumLineSpacing
//        
//        for section in 0..<collectionView.numberOfSections {
//            let itemCount = collectionView.numberOfItems(inSection: section)
//            
//            // 遍历 section 中的每一个 item
//            for item in 0..<itemCount {
//                let indexPath = IndexPath(item: item, section: section)
//                guard let attributes = layoutAttributesForItem(at: indexPath) else { continue }
//                
////                // 如果该 item 需要换行
////                if attributes.frame.origin.y >= maxY {
////                    leftMargin = sectionInset.left
////                    contentHeight += attributes.frame.height + verticalSpacing
////                }
////                
////                // 计算每个 item 的 x 位置并调整 leftMargin
////                attributes.frame.origin.x = leftMargin
////                leftMargin += attributes.frame.width + horizontalSpacing
//                maxY = max(attributes.frame.maxY, maxY)
//            }
//        }
//        
//        // 最终计算的 contentHeight 需要加上最后一个 section 的底部间距
//        contentHeight += sectionInset.bottom
//        
//        return CGSize(width: contentWidth, height: maxY)
//    }
}
