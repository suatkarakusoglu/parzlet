//
//  GameBoard.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/7/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import Foundation

class GameBoard
{
    var boxes: [[GameBox]] = [[]]
    var emptyBoxes: [GameBox] = []
    
    func getGameBox(gameBoxPoint: GameBoxPoint) -> GameBox
    {
        return self.boxes[gameBoxPoint.x][gameBoxPoint.y]
    }
    
    func setGameBox(gameBox: GameBox, gameBoxPoint: GameBoxPoint)
    {
      //  let oldGameBox = self.getGameBox(gameBoxPoint: gameBoxPoint)
        self.boxes[gameBoxPoint.x][gameBoxPoint.y] = gameBox
      //  return oldGameBox
    }
}
