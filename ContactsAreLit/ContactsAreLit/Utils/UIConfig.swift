//
//  UIConfig.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 06/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

struct UIConfig {
    static func createFlowLayout(in view : UIView,numberOfColums : Int) -> UICollectionViewFlowLayout {
        
        let width = view.bounds.width
        let padding : CGFloat = Values.collectionViewPadding
        let minItemSpacing :CGFloat = Values.collectionViewMinItemSpacing
        
        let availableWidth = width - (padding * 2) - (minItemSpacing * 2)
        let itemWidth = availableWidth/CGFloat(numberOfColums)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + Values.collectionViewAdditionalItemHeight)
        
        return flowLayout
    }
}

