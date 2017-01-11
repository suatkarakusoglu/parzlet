//
//  PZMenuVC.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/7/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import UIKit

class PZMenuVC: PZBaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var buttonStartPuzzle: UIButton!
    @IBOutlet weak var imagePuzzlePreview: UIImageView!
    @IBOutlet var buttonsDivisionLevels: [UIButton]!
    @IBOutlet var buttonsForImageSources: [UIButton]!
    @IBOutlet var buttonsForShuffleLevels: [UIButton]!
    
    var selectedDivisionLevel: Int = 3
    var selectedShuffleLevel: ShuffleLevel = ShuffleLevel.NORMAL
    var selectedImage: UIImage?
    
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
        let defaultImage = UIImage(named: "sero")!
        //TODOX: Get default image randomly
        let puzzleVC = PZPuzzleVC(
            imageForPuzzle: self.selectedImage ?? defaultImage,
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
    
    @IBAction func actionTookFromCamera(_ sender: UIButton) {
        if PermissionManager.isCameraPermissionDenied()
        {
            "Permission is denied for camera".logMe()
            return
        }
        self.createImagePickerVC(fromSource: .camera).presentUpon(controller: self)
    }
    
    @IBAction func actionSelectImageFromPhotoGallery(_ sender: UIButton) {
        if PermissionManager.isPhotoLibraryPermissionDenied()
        {
            "Permission is denied for photo library".logMe()
            return
        }
        self.createImagePickerVC(fromSource: .photoLibrary).presentUpon(controller: self)
    }
    
    @IBAction func actionSelectFromOurGallery(_ sender: UIButton) {
        "Select from our gallery".logMe()
    }
    
    private func createImagePickerVC(fromSource sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController
    {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = sourceType
        imagePickerVC.delegate = self
        return imagePickerVC
    }
}

extension PZMenuVC
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var imageTaken: UIImage? = nil
        if let image = info["UIImagePickerControllerEditedImage"] as? UIImage {
            imageTaken = image
        }
        else if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imageTaken = image
        }
        
        self.selectedImage = imageTaken
        self.imagePuzzlePreview.image = self.selectedImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
