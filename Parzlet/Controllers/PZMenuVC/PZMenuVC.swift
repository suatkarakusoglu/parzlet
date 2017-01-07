//
//  PZMenuVC.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/7/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import UIKit

class PZMenuVC: PZBaseViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init()
    {
        super.init(nibName: PZMenuVC.className() , bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
