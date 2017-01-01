//
//  ViewController.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/1/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewGameBoard: UIView!
    
    var gameBoard: [[GameBox]] = [[]]
    
    let rowLevel = 5
    let colLevel = 5
    
    private func generateGameBoxPoints(rowAmount: Int, colAmount: Int) -> [GameBoxPoint]
    {
        var gameBoxPoints: [GameBoxPoint] = [GameBoxPoint]();
        for i in 0..<rowAmount{
            for j in 0..<colAmount{
                gameBoxPoints.append(GameBoxPoint(x: i, y: j))
            }
        }
        return gameBoxPoints
    }
    @IBAction func actionShuffleGame(_ sender: UIButton) {
        self.shuffleGameBox()
        self.drawGameBoard()
    }
    
    func shuffleGameBox()
    {
        var generatedGameBoxPoints = self.generateGameBoxPoints(rowAmount: rowLevel, colAmount: colLevel)
        
        for _ in 1...100
        {
            let randomIndex1 = generatedGameBoxPoints.randomIndex()
            let randomPoint1 = generatedGameBoxPoints[randomIndex1]
            
            let randomIndex2 = generatedGameBoxPoints.randomIndex()
            let randomPoint2 = generatedGameBoxPoints[randomIndex2]
            
            let candidate1 = self.gameBoard[randomPoint1.x][randomPoint1.y];
            let candidate2 = self.gameBoard[randomPoint2.x][randomPoint2.y];
            
            let tempCurrentPoint = candidate1.currentPoint
            candidate1.currentPoint = candidate2.currentPoint
            candidate2.currentPoint = tempCurrentPoint
            
            self.gameBoard[randomPoint1.x][randomPoint1.y] = candidate2
            self.gameBoard[randomPoint2.x][randomPoint2.y] = candidate1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realImage = UIImage(named: "sero")!
        let imageOfGame = realImage.smaller(maxWidth: self.viewGameBoard.frame.width)!

        var gameBoxItems: [[GameBox]] = [[GameBox]]()

        let imageOfGameSize = imageOfGame.size
        let gameBoxWidth = imageOfGameSize.width / CGFloat(colLevel)
        let gameBoxHeight = imageOfGameSize.height / CGFloat(rowLevel)
        
        for i in 0..<rowLevel{
            gameBoxItems.append([GameBox]())
            for j in 0..<colLevel{
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
                    gameSizeLevel: rowLevel
                )
                
                if i == rowLevel - 1 && j == colLevel - 1 {
                    createdGameBox.isEmpty = true
                }
                
                if i == rowLevel - 1 && j == 0 {
                    createdGameBox.isEmpty = true
                }
                
                gameBoxItems[i].append(createdGameBox)
            }
        }
        //self.shuffleGameBox()
        self.gameBoard = gameBoxItems;
        self.drawGameBoard()
    }

    func drawGameBoard()
    {
        self.viewGameBoard.subviews.forEach({ $0.removeFromSuperview() })
        
        let viewGameBoardFrame = self.viewGameBoard.frame
        let gameBoardWidth = viewGameBoardFrame.width
        let gameBoardHeight = viewGameBoardFrame.height
        
        let rowCount = self.gameBoard.count
        let gameBoxHeight = gameBoardHeight / CGFloat(rowCount)
        
        for gameBoxRows in self.gameBoard{
            for gameBoxItem in gameBoxRows{
                let gameBoxWidth = gameBoardWidth / CGFloat(self.rowLevel)
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
                    currentImageView.image = UIImage(named: "emptyBox")!
                }else{
                    currentImageView.image = imageToDraw
                    
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
                    currentImageView.addGestureRecognizer(tapGesture)
                    self.addDirectionSwipeGestures(imageSwiped: currentImageView)
                }
                currentImageView.drawBorder(
                    color: UIColor.green,
                    borderWidth: 0.5)
                self.viewGameBoard.addSubview(currentImageView)
            }
        }
    }
    
    func tapped(_ sender: UITapGestureRecognizer)
    {
        guard let gameBoxImageView = sender.view as? GameBoxImageView else { return }
        guard let gameBoxToMove = gameBoxImageView.gameBox else { return }
        
        let movedUp = self.moveUp(gameBox: gameBoxToMove)
        if movedUp { return }
        let movedDown = self.moveDown(gameBox: gameBoxToMove)
        if movedDown { return }
        let movedLeft = self.moveLeft(gameBox: gameBoxToMove)
        if movedLeft { return }
        let movedRight = self.moveRight(gameBox: gameBoxToMove)
        if movedRight { return }
    }
    
    private func addDirectionSwipeGestures(imageSwiped: UIImageView)
    {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        imageSwiped.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        imageSwiped.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        imageSwiped.addGestureRecognizer(swipeUp)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        imageSwiped.addGestureRecognizer(swipeLeft)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                if let gameBoxImageView = gesture.view as? GameBoxImageView
                {
                    if let activeGameBox = gameBoxImageView.gameBox
                    {
                        self.moveRight(gameBox: activeGameBox)
                    }
                }
            case UISwipeGestureRecognizerDirection.down:
                if let gameBoxImageView = gesture.view as? GameBoxImageView
                {
                    if let activeGameBox = gameBoxImageView.gameBox
                    {
                        self.moveDown(gameBox: activeGameBox)
                    }
                }
            case UISwipeGestureRecognizerDirection.left:
                if let gameBoxImageView = gesture.view as? GameBoxImageView
                {
                    if let activeGameBox = gameBoxImageView.gameBox
                    {
                        self.moveLeft(gameBox: activeGameBox)
                    }
                }
            case UISwipeGestureRecognizerDirection.up:
                if let gameBoxImageView = gesture.view as? GameBoxImageView
                {
                    if let activeGameBox = gameBoxImageView.gameBox
                    {
                        self.moveUp(gameBox: activeGameBox)
                    }
                }
            default:
                break
            }
        }
    }
    
    private func moveLeft(gameBox: GameBox) -> Bool
    {
        guard let nextDestinationBoxPoint = gameBox.getLeftBoxPoint() else {
            debugPrint("No left")
            return false
        };
        
        let nextDestinationBox = self.gameBoard[nextDestinationBoxPoint.x][nextDestinationBoxPoint.y]
        
        guard nextDestinationBox.isEmpty else { debugPrint("Left destination full!")
            return false };
     
        // Change place of boxes in gameBoard
        self.gameBoard[nextDestinationBoxPoint.x][nextDestinationBoxPoint.y] = gameBox
        self.gameBoard[gameBox.currentPoint.x][gameBox.currentPoint.y] = nextDestinationBox

        nextDestinationBox.goRightBox()
        gameBox.goLeftBox()
        
        self.drawGameBoard()
        
        return true
    }
    
    private func moveRight(gameBox: GameBox) -> Bool
    {
        guard let nextDestinationBoxPoint = gameBox.getRightBoxPoint() else {
            debugPrint("No right")
            return false
        };
        
        let nextDestinationBox = self.gameBoard[nextDestinationBoxPoint.x][nextDestinationBoxPoint.y]
        
        guard nextDestinationBox.isEmpty else { debugPrint("Right destination full!")
            return false };
        
        // Change place of boxes in gameBoard
        self.gameBoard[nextDestinationBoxPoint.x][nextDestinationBoxPoint.y] = gameBox
        self.gameBoard[gameBox.currentPoint.x][gameBox.currentPoint.y] = nextDestinationBox
        
        nextDestinationBox.goLeftBox()
        gameBox.goRightBox()
        
        self.drawGameBoard()
        
        return true
    }
    
    private func moveUp(gameBox: GameBox) -> Bool
    {
        guard let nextDestinationBoxPoint = gameBox.getUpBoxPoint() else {
            debugPrint("No up")
            return false
        };
        
        let nextDestinationBox = self.gameBoard[nextDestinationBoxPoint.x][nextDestinationBoxPoint.y]
        
        guard nextDestinationBox.isEmpty else { debugPrint("Up destination full!")
            return false };
        
        // Change place of boxes in gameBoard
        self.gameBoard[nextDestinationBoxPoint.x][nextDestinationBoxPoint.y] = gameBox
        self.gameBoard[gameBox.currentPoint.x][gameBox.currentPoint.y] = nextDestinationBox
        
        nextDestinationBox.goDownBox()
        gameBox.goUpBox()
        
        self.drawGameBoard()
        return true
    }
    
    private func moveDown(gameBox: GameBox) -> Bool
    {
        guard let nextDestinationBoxPoint = gameBox.getDownBoxPoint() else {
            debugPrint("No down")
            return false
        };
        
        let nextDestinationBox = self.gameBoard[nextDestinationBoxPoint.x][nextDestinationBoxPoint.y]
        
        guard nextDestinationBox.isEmpty else { debugPrint("Down destination full!")
            return false };
        
        // Change place of boxes in gameBoard
        self.gameBoard[nextDestinationBoxPoint.x][nextDestinationBoxPoint.y] = gameBox
        self.gameBoard[gameBox.currentPoint.x][gameBox.currentPoint.y] = nextDestinationBox
        
        nextDestinationBox.goUpBox()
        gameBox.goDownBox()
        
        self.drawGameBoard()
        return true
    }
}

