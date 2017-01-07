//
//  RangeEXT.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/3/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import Foundation

extension RandomAccessCollection{
    func randomInt() -> Int? {
        guard let startNumber = self.first as? Int else { return nil }
        guard let endNumber = self.last as? Int else { return nil }
        let rangeNumber = endNumber - startNumber
        let random = Int(arc4random_uniform(UInt32(rangeNumber))) + startNumber;
        return random
    }
}
