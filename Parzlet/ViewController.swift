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
        self.shuffleGameBox(gameToShuffle: self.gameBoard)
        self.drawGameBoard()
    }
    
    func shuffleGameBox(gameToShuffle: [[GameBox]])
    {
        var generatedGameBoxPoints = self.generateGameBoxPoints(rowAmount: rowLevel, colAmount: colLevel)
        // TODOX: Take out right part
        
        gameToShuffle.forEach { (gameBoxRow: [GameBox]) in
            gameBoxRow.forEach({ (gameBox: GameBox) in
                let randomIndex = generatedGameBoxPoints.randomIndex()
                let randomPoint = generatedGameBoxPoints[randomIndex]
                generatedGameBoxPoints.remove(at: randomIndex)
                gameBox.currentPoint = randomPoint
            })
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
        //self.shuffleGameBox(gameToShuffle: gameBoxItems)
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

        
        for rowIndex in 0..<rowCount
        {
            let columnCount = self.gameBoard[rowIndex].count

            for columnIndex in 0..<columnCount
            {
                let gameBoxWidth = gameBoardWidth / CGFloat(columnCount)
                let currentGameBox = self.gameBoard[rowIndex][columnIndex]
                let imageToDraw = currentGameBox.image
                
                let xOffset = CGFloat(currentGameBox.currentPoint.y) * gameBoxWidth
                let yOffset = CGFloat(currentGameBox.currentPoint.x) * gameBoxHeight
                
                let frameToDrawImage = CGRect(
                    x: xOffset,
                    y: yOffset,
                    width: gameBoxWidth,
                    height: gameBoxHeight
                )
                let currentImageView = GameBoxImageView(frame: frameToDrawImage)
                currentImageView.gameBox = currentGameBox
                currentImageView.isUserInteractionEnabled = true
                if currentGameBox.isEmpty {
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
        if let gameBoxImageView = sender.view as? GameBoxImageView
        {
        }
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
                }
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                if let gameBoxImageView = gesture.view as? GameBoxImageView
                {
                    if let activeGameBox = gameBoxImageView.gameBox
                    {
                        self.moveLeft(gameBox: activeGameBox)
                    }
                }
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    enum MoveDirection: String {
        case LEFT
        case RIGHT
        case UP
        case DOWN
    }
    
    private func moveGameBox(boxToMove: GameBox, direction: MoveDirection)
    {
        switch direction {
        case .LEFT:
            self.moveLeft(gameBox: boxToMove)
        default:
            debugPrint("Handle \(direction.rawValue) case")
        }
        //TODOX: UPDATE SCREEN
        self.drawGameBoard()
        //TODO: Check if finished
        
    }
    
    private func moveLeft(gameBox: GameBox)
    {
        guard let nextDestinationBoxPoint = gameBox.getLeftBoxPoint() else {
            debugPrint("No left")
            return
        };
        
        let nextDestinationBox = self.gameBoard[nextDestinationBoxPoint.x][nextDestinationBoxPoint.y]
        guard nextDestinationBox.isEmpty else { debugPrint("Left destination full!")
            return };
     
        
        nextDestinationBox.goRightBox()
        gameBox.goLeftBox()
        self.drawGameBoard()
    }
    
    private func moveRight(gameBox: GameBox)
    {
    }
    
    private func moveUp(gameBox: GameBox)
    {
    }
    
    private func moveDown(gameBox: GameBox)
    {
    }
}

