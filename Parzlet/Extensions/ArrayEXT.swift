//
//  ArrayEXT.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/1/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import Foundation

extension Array
{
    func randomIndex() -> Int
    {
        let elementCount = self.count
        let randomIndex = Int(arc4random_uniform(UInt32(elementCount)))
       // let randomElement = self[randomIndex]
        return randomIndex
    }
}
