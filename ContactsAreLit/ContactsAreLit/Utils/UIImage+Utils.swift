//
//  UIImage+Utils.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 07/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

extension UIImage {
    var imageData : Data? {
        return self.jpegData(compressionQuality: 0.5)
    }
}
