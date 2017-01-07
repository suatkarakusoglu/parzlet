//
//  NSObjectEXT.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/7/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import Foundation

extension NSObject
{
    class func className() -> String
    {
        return self.description().components(separatedBy: ".").last ?? ""
    }
    
    func className() -> String
    {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }
}
