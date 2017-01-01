//
//  UIViewEXT.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/1/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import UIKit

extension UIView
{
    func drawBorder(color: UIColor, borderWidth: Double)
    {
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = color.cgColor
    }
}
