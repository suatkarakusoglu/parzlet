//
//  PZGameView.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/7/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import UIKit

class PZGameView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var gameBoard : GameBoard = GameBoard()
    var divisionLevel: Int!
    var imageToShow: UIImage!
    var clickAmount: Int = 0
    
    convenience init(
        frame: CGRect,
        imageToShow: UIImage,
        divisionLevel: Int)
    {
        self.init(frame: frame)
        self.imageToShow = imageToShow
        self.divisionLevel = divisionLevel
        self.prepareGameBoard()
        self.drawGameBoard()
    }
    
    private func prepareGameBoard() {
        let imageOfGame = imageToShow.smaller(maxWidth: frame.width)!
        
        let imageOfGameSize = imageOfGame.size
        let gameBoxWidth = imageOfGameSize.width / CGFloat(divisionLevel)
        let gameBoxHeight = imageOfGameSize.height / CGFloat(divisionLevel)
        
        var gameBoxItems: [[GameBox]] = [[GameBox]]()
        
        for i in 0..<divisionLevel{
            gameBoxItems.append([GameBox]())
            for j in 0..<divisionLevel{
                let xToCrop = CGFloat(j) * gameBoxWidth
                let yToCrop = CGFloat(i) * gameBoxHeight
                let croppedImagePart = imageOfGame.cgImage!.cropping(to:
                    CGRect(x: xToCrop,
                           y: yToCrop,
                           width: gameBoxWidth,
                           height: gameBoxHeight)
                )
                let croppedImage = UIImage(cgImage: croppedImagePart!)
                
                let createdGameBox = GameBox(
                    image: croppedImage,
                    realPoint: GameBoxPoint(x:i,y:j),
                    currentPoint: GameBoxPoint(x:i,y:j),
                    gameSizeLevel: divisionLevel
                )
                
                if i == divisionLevel - 1 && j == divisionLevel - 1 {
                    self.gameBoard.emptyBoxes.append(createdGameBox)
                    createdGameBox.isEmpty = true
                }
                
                gameBoxItems[i].append(createdGameBox)
            }
        }
        
        self.gameBoard.boxes = gameBoxItems
    }
    
    func shuffleGameBox(randomMovementAmount: Int)
    {
        var i = 0
        var previousDirection: MoveDirection?
        
        while i < randomMovementAmount
        {
            // It works for one empty box for now
            if let emptyGameBox = self.gameBoard.emptyBoxes.first
            {
                let randomDirection = MoveDirection.randomDirection()
                "\(randomDirection) is generated.".logMe()
                "\(previousDirection) was prev direction.".logMe()
                if randomDirection == previousDirection ||
                    randomDirection == previousDirection?.getReverseDirection() {
                    "Continueing".logMe()
                    continue
                }
                
                let isMoved = self.moveGameBox(
                    gameBox: emptyGameBox,
                    direction: randomDirection
                )
                previousDirection = randomDirection
                if isMoved { i = i + 1 }
            }
        }
        
        self.drawGameBoard()
    }
    
    private func moveGameBox(gameBox: GameBox, direction: MoveDirection) -> Bool
    {
        guard let nextDestinationBoxPoint = gameBox.getNextBoxPoint(direction: direction)
            else {
                "No \(direction)".logMe()
                return false
        }
        
        let nextDestinationBox = self.gameBoard.getGameBox(gameBoxPoint: nextDestinationBoxPoint)
        
        if gameBox.isNotEmpty() && nextDestinationBox.isNotEmpty()
        {
            "\(direction) full!".logMe()
            return false
        }
        self.changePlaces(gameBox1: gameBox, gameBox2: nextDestinationBox)
        nextDestinationBox.goToDirection(direction: direction.getReverseDirection())
        gameBox.goToDirection(direction: direction)
        
        if gameBoard.isSucceeded(){
            "Congrats".logMe()
        }
        self.drawGameBoard()
        return true
    }

    private func changePlaces(gameBox1: GameBox, gameBox2: GameBox)
    {
        self.gameBoard.setGameBox(gameBox: gameBox1, gameBoxPoint: gameBox2.currentPoint)
        self.gameBoard.setGameBox(gameBox: gameBox2, gameBoxPoint: gameBox1.currentPoint)
    }
    
    func drawGameBoard()
    {
        self.subviews.forEach({ $0.removeFromSuperview() })
        
        let viewGameBoardFrame = self.frame
        let gameBoardWidth = viewGameBoardFrame.width
        let gameBoardHeight = viewGameBoardFrame.height
        
        let rowCount = self.divisionLevel
        let gameBoxHeight = gameBoardHeight / CGFloat(rowCount!)
        
        for gameBoxRows in self.gameBoard.boxes{
            for gameBoxItem in gameBoxRows{
                let gameBoxWidth = gameBoardWidth / CGFloat(self.divisionLevel)
                let imageToDraw = gameBoxItem.image
                
                let xOffset = CGFloat(gameBoxItem.currentPoint.y) * gameBoxWidth
                let yOffset = CGFloat(gameBoxItem.currentPoint.x) * gameBoxHeight
                
                let frameToDrawImage = CGRect(
                    x: xOffset,
                    y: yOffset,
                    width: gameBoxWidth,
                    height: gameBoxHeight
                )
                let currentImageView = GameBoxImageView(frame: frameToDrawImage)
                currentImageView.gameBox = gameBoxItem
                currentImageView.isUserInteractionEnabled = true
                if gameBoxItem.isEmpty {
                
                    let labelClickAmount = UILabel(
                        frame: CGRect(x:8, y:4 , width: 60, height: 40))
                    labelClickAmount.textColor = UIColor.black
                    labelClickAmount.font = UIFont.boldSystemFont(ofSize: 24)
                    labelClickAmount.text = String(self.clickAmount)
                        
                    currentImageView.image = UIImage(named: "empty_box")!
                    currentImageView.addSubview(labelClickAmount)
                
                }else{
                    currentImageView.image = imageToDraw
                    
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
                    currentImageView.addGestureRecognizer(tapGesture)
                    self.addDirectionSwipeGestures(imageSwiped: currentImageView)
                }
                currentImageView.drawBorder(
                    color: UIColor.black,
                    borderWidth: 1)
                self.addSubview(currentImageView)
            }
        }
    }
    
    func tapped(_ sender: UITapGestureRecognizer)
    {
        guard let gameBoxImageView = sender.view as? GameBoxImageView else { return }
        guard let gameBoxToMove = gameBoxImageView.gameBox else { return }
        
        let isMovedSuccessfully =
            self.moveGameBox(gameBox: gameBoxToMove, direction: .UP) ||
                self.moveGameBox(gameBox: gameBoxToMove, direction: .DOWN) ||
                self.moveGameBox(gameBox: gameBoxToMove, direction: .LEFT) ||
                self.moveGameBox(gameBox: gameBoxToMove, direction: .RIGHT)
    
        if isMovedSuccessfully {
            self.incrementMoveCount()
        }
    }
    
    private func addDirectionSwipeGestures(imageSwiped: UIImageView)
    {
        let gestureDirections: [UISwipeGestureRecognizerDirection] = [.right, .left, .up, .down]
        gestureDirections.forEach{
            imageSwiped.addGestureRecognizer(
                self.createSwipeGestureRecognizer(direction: $0)
            )
        }
    }
    
    private func createSwipeGestureRecognizer(direction: UISwipeGestureRecognizerDirection) -> UISwipeGestureRecognizer
    {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeGestureRecognizer.direction = direction
        return swipeGestureRecognizer
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        guard let swipeGesture = gesture as? UISwipeGestureRecognizer else { return }
        guard let gameBoxImageView = gesture.view as? GameBoxImageView else { return }
        guard let activeGameBox = gameBoxImageView.gameBox else { return }

        var isMovedSuccessfully = false
        switch swipeGesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            isMovedSuccessfully = self.moveGameBox(gameBox: activeGameBox,
                                    direction: .RIGHT)
        case UISwipeGestureRecognizerDirection.down:
            isMovedSuccessfully = self.moveGameBox(gameBox: activeGameBox,
                                    direction: .DOWN)
        case UISwipeGestureRecognizerDirection.up:
            isMovedSuccessfully = self.moveGameBox(gameBox: activeGameBox,
                                    direction: .UP)
        case UISwipeGestureRecognizerDirection.left:
            isMovedSuccessfully = self.moveGameBox(gameBox: activeGameBox,
                                    direction: .LEFT)
        default:
            isMovedSuccessfully = false
        }
       
        if isMovedSuccessfully{
            self.incrementMoveCount()
        }
    }
    
    private func incrementMoveCount()
    {
        self.clickAmount = self.clickAmount + 1
    }
}
