//
//  PZMenuVC.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/7/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import UIKit

class PZMenuVC: PZBaseViewController {
    @IBOutlet weak var buttonStartPuzzle: UIButton!
    @IBOutlet weak var imagePuzzlePreview: UIImageView!
    @IBOutlet var buttonsDivisionLevels: [UIButton]!
    @IBOutlet var buttonsForImageSources: [UIButton]!
    @IBOutlet var buttonsForShuffleLevels: [UIButton]!
    
    var selectedDivisionLevel: Int = 3
    var selectedShuffleLevel: ShuffleLevel = ShuffleLevel.NORMAL
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init()
    {
        super.init(nibName: PZMenuVC.className() , bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Parzlet"
        self.configureViews()
    }
    
    private func configureViews()
    {
        self.buttonsForImageSources.forEach {
            $0.setCornerRadius(radius: 5)
        }
        self.buttonsDivisionLevels.forEach {
            $0.setCornerRadius(radius: 5)
        }
        self.buttonsForShuffleLevels.forEach{
            $0.setCornerRadius(radius: 5)
        }
        
        self.imagePuzzlePreview.setCornerRadius(radius: 10)
        self.imagePuzzlePreview.drawBorder(
            color: UIColor.black,
            borderWidth: 2
        )
        
        self.buttonStartPuzzle.setCornerRadius(radius: 5)
    }
    
    @IBAction func actionStartPuzzle(_ sender: UIButton) {
        let selectedImage = UIImage(named: "sero")!
        let puzzleVC = PZPuzzleVC(
            imageForPuzzle: selectedImage,
            divisionLevel: self.selectedDivisionLevel,
            shuffleLevel: self.selectedShuffleLevel
        )
        puzzleVC.pushTo(navigationController: self.navigationController)
    }
    
    @IBAction func setDivisionLevel(_ sender: UIButton)
    {
        self.buttonsDivisionLevels.forEach{ $0.backgroundColor = UIColor.black }
        sender.backgroundColor = UIColor.red
        if let clickedDivisionLevel = Int((sender.titleLabel?.text)!)
        {
            self.selectedDivisionLevel = clickedDivisionLevel
        }
    }
    
    @IBAction func setShuffleLevel(_ sender: UIButton)
    {
        self.buttonsForShuffleLevels.forEach{ $0.backgroundColor = UIColor.orange }
        sender.backgroundColor = UIColor.red
        let shuffleLevelTag = sender.tag
        self.selectedShuffleLevel =  ShuffleLevel(rawValue: shuffleLevelTag)!
    }
}
