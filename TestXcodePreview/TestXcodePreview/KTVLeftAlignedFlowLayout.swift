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
}
