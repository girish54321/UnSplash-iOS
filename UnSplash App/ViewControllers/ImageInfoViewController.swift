//
//  ImageInfoViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 28/09/21.
//

import UIKit

class ImageInfoViewController: UIViewController {
    
    var imageInfo:HomeImage! 
    @IBOutlet weak var infoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(imageInfo != nil){
            updateView();
        }
    }
    
    func updateView() {
        infoImageView.sd_setImage(with: URL(string: imageInfo.urls?.regular ??  "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__480.jpg"))
    }
    
}
