//
//  PZPuzzleVC.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/7/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import UIKit

class PZPuzzleVC: PZBaseViewController {

    @IBOutlet weak var viewPuzzleGameContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Puzzle (4x4)"
        let realImage = UIImage(named: "ays")!

        let gameViewFrame = CGRect(
            x: 0,
            y: 0,
            width: self.viewPuzzleGameContainer.frame.size.width,
            height: self.viewPuzzleGameContainer.frame.size.height
        )
        let gameView = PZGameView(
            frame: gameViewFrame,
            imageToShow: realImage ,
            divisionLevel: 4
        )
        self.viewPuzzleGameContainer.addSubview(gameView);
    }
}
