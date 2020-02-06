//
//  CALTextField.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 06/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

final class CALTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Text.noStoryboradImplementation)
    }
    
    init(placeholderText : String,keyboardType: UIKeyboardType){
        super.init(frame: .zero)
        self.placeholder = placeholderText
        self.keyboardType = keyboardType
        configure()

    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Values.textFieldCornerRadius
        layer.borderWidth = Values.textFieldBorderWidth
        layer.borderColor = UIColor(named: Text.mainAppColor)?.cgColor
        
        textColor = .label
//        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = Values.minimumFontSize
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
    }
}
