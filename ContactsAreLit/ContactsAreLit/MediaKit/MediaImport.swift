//
//  MediaImport.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 06/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

class MediaImport : UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //we use this closure to tell the calling VC that an image has been selected
    var onImageSelect : (UIImage) -> () = {_ in }
    
    func openPhotoLibrary() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage {
            onImageSelect(image)
        }else if let image = info[.originalImage] as? UIImage {
            onImageSelect(image)
        }else{
            return
        }
    }
}
