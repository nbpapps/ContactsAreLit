//
//  MediaPermitions.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 06/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
import Photos

typealias photoLibraryPermissionsCompletion = (PhotoPermissions) -> Void

enum PhotoPermissions {
    //in a live app, we would support all the status options
    case authorized
    case unauthorized
}


struct MediaPermissions {
    func checkPhotoLibraryPermission(with completion : @escaping photoLibraryPermissionsCompletion) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            completion(.authorized)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization() { status in
                switch status {
                case .authorized:
                    completion(.authorized)
                case .denied,.notDetermined,.restricted:
                    completion(.unauthorized)
                @unknown default:
                    completion(.unauthorized)
                }
            }
        case .denied,.restricted:
           completion(.unauthorized)
        @unknown default:
            completion(.unauthorized)
        }
    }
}
