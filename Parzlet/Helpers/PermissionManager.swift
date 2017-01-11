//
//  PermissionManager.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/9/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

class PermissionManager
{
    static func isCameraPermissionDenied() -> Bool
    {
        let avMediaVideoAuthStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        let isDenied = avMediaVideoAuthStatus == AVAuthorizationStatus.denied
        return isDenied
    }
    
    static func isPhotoLibraryPermissionDenied() -> Bool
    {
        if #available(iOS 8.0, *)
        {
            let photoLibraryAuthStatus = PHPhotoLibrary.authorizationStatus()
            let isDenied = photoLibraryAuthStatus == PHAuthorizationStatus.denied
            return isDenied
        }else
        {
            return false
        }
    }
}
