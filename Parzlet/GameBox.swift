//
//  GameBox.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/1/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import UIKit

class GameBox {

    var image: UIImage
    var realPoint: GameBoxPoint
    var currentPoint: GameBoxPoint
    var gameSizeLevel: Int
    var isEmpty: Bool = false
    
    init(image: UIImage, realPoint: GameBoxPoint, currentPoint: GameBoxPoint, gameSizeLevel: Int, isEmpty: Bool = false)
    {
        self.image = image
        self.realPoint = realPoint
        self.currentPoint = currentPoint
        self.gameSizeLevel = gameSizeLevel
    }
    
    func getLeftBoxPoint() -> GameBoxPoint?
    {
        guard self.currentPoint.y - 1 >= 0 else { return nil }
        return GameBoxPoint(x: self.currentPoint.x, y: self.currentPoint.y - 1)
    }
    
    func goLeftBox()
    {
        self.currentPoint.y = self.currentPoint.y - 1
    }
    
    func goRightBox()
    {
        self.currentPoint.y = self.currentPoint.y + 1
    }
    
    
}
    
