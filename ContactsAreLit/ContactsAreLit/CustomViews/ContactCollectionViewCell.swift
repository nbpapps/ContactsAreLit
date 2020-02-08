//
//  ContactCollectionViewCell.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 06/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = Text.contactCellId
    
    let contactImageView = CALImageView(frame: .zero)
    let contactName = CALLabel(textAlignment: .center, fontSize: Values.contactNameFontSize, weight: .bold,color: .label)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
       
    required init?(coder: NSCoder) {
        fatalError(Text.noStoryboradImplementation)
    }
    
    private func configure() {
        addSubview(contactImageView)
        addSubview(contactName)
        
        contentView.backgroundColor = UIColor(named: Text.mainAppColor)
        contentView.alpha = Values.cellAlpha
        contentView.layer.cornerRadius = Values.cellRadius
        
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: Values.imageViewPadding),
            contactImageView.heightAnchor.constraint(equalToConstant: Values.imageViewHeight),
            contactImageView.widthAnchor.constraint(equalTo: contactImageView.heightAnchor),
            contactImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            contactName.topAnchor.constraint(equalTo: contactImageView.bottomAnchor, constant:Values.viewSpasing),
            contactName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Values.labelPadding),
            contactName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Values.labelPadding),
            contactName.heightAnchor.constraint(equalToConstant: Values.labelHeight)
        ])
    }
}
