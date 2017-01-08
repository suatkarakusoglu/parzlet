//
//  PZPuzzleVC.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/7/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import UIKit

class PZPuzzleVC: PZBaseViewController {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(imageForPuzzle: UIImage, divisionLevel: Int, shuffleLevel: ShuffleLevel)
    {
        self.imageForPuzzle = imageForPuzzle
        self.divisionLevel = divisionLevel
        self.shuffleLevel = shuffleLevel
        super.init(nibName: PZPuzzleVC.className() , bundle: nil)
    }
    
    @IBOutlet weak var viewPuzzleGameContainer: UIView!
    @IBOutlet weak var imageViewOriginal: UIImageView!
    var imageForPuzzle: UIImage
    var divisionLevel: Int
    var shuffleLevel: ShuffleLevel
    var gameView: PZGameView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Puzzle (\(divisionLevel)x\(divisionLevel))"
        let gameViewFrame = CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width,
            height: ScreenSize.width
        )
        self.gameView = PZGameView(
            frame: gameViewFrame,
            imageToShow: self.imageForPuzzle,
            divisionLevel: self.divisionLevel
        )
        self.viewPuzzleGameContainer.addSubview(self.gameView!);
        self.gameView?.shuffleGameBox(
            randomMovementAmount: self.shuffleLevel.getLevelShuffleAmount())
        self.imageViewOriginal.image = self.imageForPuzzle
    }
}
