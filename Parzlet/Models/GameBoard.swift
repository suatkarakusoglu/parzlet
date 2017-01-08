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
        self.boxes[gameBoxPoint.x][gameBoxPoint.y] = gameBox
    }
    
    func isSucceeded() -> Bool
    {
        let isFailed = boxes.contains { (gameBoxesRow: [GameBox]) -> Bool in
            gameBoxesRow.contains(where: { (gameBox: GameBox) -> Bool in
                !(gameBox.currentPoint == gameBox.realPoint)
            })
        }
        
        return !isFailed
    }
}
