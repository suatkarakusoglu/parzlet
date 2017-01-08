//
//  ShuffleLevel.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/8/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import Foundation

enum ShuffleLevel: Int
{
    case EASY
    case NORMAL
    case HARD
    case PRO
    
    func getLevelShuffleAmount() -> Int
    {
        switch self {
        case .EASY:
            return 5
        case .NORMAL:
            return 10
        case .HARD:
            return 15
        case .PRO:
            return 30
        }
    }
}
