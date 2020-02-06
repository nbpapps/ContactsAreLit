//
//  CALImageView.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 05/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

final class CALImageView: UIImageView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Text.noStoryboradImplementation)
    }
    
    override init(image : UIImage?) {
        super.init(frame: .zero)
        self.image = image
        config()
    }
    
    private func config() {
        layer.cornerRadius = Values.imageViewCornerRadius
        clipsToBounds = true
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
}
