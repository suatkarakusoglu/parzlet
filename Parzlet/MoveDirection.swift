//
//  MoveDirection.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/1/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import Foundation

enum MoveDirection: Int {
    case LEFT
    case RIGHT
    case UP
    case DOWN
    
    static func randomDirection() -> MoveDirection
    {
        let elementCount = 4
        let randomDirectionInt = Int(arc4random_uniform(UInt32(elementCount)))
        return MoveDirection.init(rawValue: randomDirectionInt)!
    }
}
    
