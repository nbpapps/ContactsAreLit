//
//  CALButton.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 05/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

final class CALButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        //this is the init for story board
        fatalError(Text.noStoryboradImplementation)
    }
    
    
    init(backgroundColor : UIColor = UIColor(named: Text.mainAppColor) ?? .systemBlue,title : String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    init(backgroundColor : UIColor = UIColor(named: Text.mainAppColor) ?? .systemBlue,image : UIImage) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.setImage(image, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = Values.buttonCornerRadius
        setTitleColor(.label, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline) //this is for dynamic type
        translatesAutoresizingMaskIntoConstraints = false //this will let us use AutoLayout
    }

}
