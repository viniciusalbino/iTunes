
import Foundation
import UIKit

final class HomeLayout {
    var layout: UICollectionViewCompositionalLayout {
        
        // setting up item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: .fixed(CGFloat.spacing(.spacingSm)), trailing: nil, bottom: nil)
        
        // setting up group
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitem: layoutItem, count: 1)
        
        layoutGroup.contentInsets = .init(top: CGFloat.spacing(.spacingMd), leading: 0, bottom: -CGFloat.spacing(.spacingMd), trailing: 0)
        
        // setting up section
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let compLayout = UICollectionViewCompositionalLayout(section: layoutSection)
        return compLayout
    }
}
