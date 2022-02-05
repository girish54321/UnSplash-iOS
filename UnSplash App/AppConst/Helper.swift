//
//  Helper.swift
//  UnSplash App
//
//  Created by Girish Parate on 28/09/21.
//

import UIKit

class Helper {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    func goToImageInfo(imageData:HomeImage) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageInfoViewController") as? ImageInfoViewController {
            viewController.imageInfo = imageData
               if let navigator = navigationController {
                   navigator.pushViewController(viewController, animated: true)
               }
           }
        }
}
