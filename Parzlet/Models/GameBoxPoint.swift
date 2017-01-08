//
//  GameBoxPoint.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/1/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import UIKit
infix operator == { associativity left precedence 140 } // 1

class GameBoxPoint: CustomStringConvertible {
    var x: Int
    var y: Int
    init(x:Int, y:Int){
        self.x = x
        self.y = y
    }
    
    var description: String{
        return "[x:\(self.x), y: \(self.y)]"
    }
    
    static func ==(leftGameBoxPoint: GameBoxPoint, rightGameBoxPoint: GameBoxPoint) -> Bool {
        return (leftGameBoxPoint.x == rightGameBoxPoint.x) &&
            (leftGameBoxPoint.y == rightGameBoxPoint.y)
    }
}
