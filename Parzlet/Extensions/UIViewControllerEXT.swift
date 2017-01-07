//
//  ExtensionUIViewController.swift
//  N11
//
//  Created by Suat Karakusoglu on 3/17/16.
//  Copyright © 2016 N11.com. All rights reserved.
//

import UIKit

extension UIViewController
{
    class func spawnFromNib<T:UIViewController>(nibName: String? = nil) -> T?
    {
        let implicitNibNameToSpawn = "\(T.self)"
        let nibNameToSpawn = nibName ?? implicitNibNameToSpawn
        let spawnedViewController = T(nibName:nibNameToSpawn,bundle: nil)
        return spawnedViewController
    }

    func pushTo(navigationController: UINavigationController?, shouldAnimate:Bool = true)
    {
        if let navigationController = navigationController
        {
            navigationController.pushViewController(self, animated: shouldAnimate)
        }
    }
    
    func presentUpon(controller: UIViewController?,shouldAnimate: Bool = true, completion:(() -> Void)? = nil)
    {
        if let controller = controller {
            controller.present(self, animated: true, completion: completion)
        }
    }
}
