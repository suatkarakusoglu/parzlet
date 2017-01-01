//
//  UIImageEXT.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/1/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resize(newWidth: CGFloat) -> UIImage?
    {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        UIGraphicsBeginImageContext(newSize)
        let newRect = CGRect(x:0,y:0,width: newWidth, height: newHeight)
        self.draw(in: newRect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    func smaller(maxWidth: CGFloat) -> UIImage?
    {
        return self.size.width > maxWidth ? self.resize(newWidth: maxWidth) : self
    }
}
