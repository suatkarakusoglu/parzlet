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
    init(imageForPuzzle: UIImage, divisionLevel: Int)
    {
        self.imageForPuzzle = imageForPuzzle
        self.divisionLevel = divisionLevel
        super.init(nibName: PZPuzzleVC.className() , bundle: nil)
    }
    
    @IBOutlet weak var viewPuzzleGameContainer: UIView!
    var imageForPuzzle: UIImage
    var divisionLevel: Int
    var gameView: PZGameView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Puzzle (\(divisionLevel)x\(divisionLevel))"
        let realImage = UIImage(named: "sero")!

        let gameViewFrame = CGRect(
            x: 0,
            y: 0,
            width: self.viewPuzzleGameContainer.frame.size.width,
            height: self.viewPuzzleGameContainer.frame.size.height
        )
        self.gameView = PZGameView(
            frame: gameViewFrame,
            imageToShow: realImage ,
            divisionLevel: 15
        )
        self.viewPuzzleGameContainer.addSubview(self.gameView!);
    }
    @IBAction func actionShufflePuzzle(_ sender: UIButton) {
        self.gameView?.shuffleGameBox(randomMovementAmount: 3)
    }
}
