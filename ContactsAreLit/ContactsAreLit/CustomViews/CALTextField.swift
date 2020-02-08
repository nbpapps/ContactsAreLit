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
    
    init(placeholderText : String,keyboardType: UIKeyboardType = .default){
        super.init(frame: .zero)
        self.placeholder = placeholderText
        self.keyboardType = keyboardType
        configure()
        configureForEnteringText()
    }
    
    init(text : String?,keyboardType: UIKeyboardType = .default,textColor : UIColor = .label) {
        super.init(frame: .zero)
        self.text = text
        self.keyboardType = keyboardType
        self.textColor = textColor
        configure()
        configureForShowingText(with: textColor)
    }
    
    private func configureForEnteringText() {
        layer.borderColor = UIColor(named: Text.mainAppColor)?.cgColor
        layer.cornerRadius = Values.textFieldCornerRadius
        layer.borderWidth = Values.textFieldBorderWidth
        
        isUserInteractionEnabled = true

        backgroundColor = .systemGroupedBackground
        textColor = .label

    }
    
    private func configureForShowingText(with color : UIColor = .label) {
        layer.borderColor = UIColor.clear.cgColor
        
        isUserInteractionEnabled = false
        
        backgroundColor = .clear
        textColor = color
        
        placeholder = ""
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = Values.minimumFontSize
        autocorrectionType = .no
    }
    
    func updateForEditing(withPlaceHolderText placeHolderText : String) {
        configureForEnteringText()
        self.placeholder = placeHolderText
    }
    
    func updateForShowingText(with color : UIColor = .label) {
        configureForShowingText(with: color)
    }
    
    
}
