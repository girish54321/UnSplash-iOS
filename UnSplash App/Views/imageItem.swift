//
//  imageItem.swift
//  UnSplash App
//
//  Created by Girish Parate on 22/09/21.
//

import Foundation
import UIKit
import SDWebImage

class ImageItem: UICollectionViewCell {
    
    @IBOutlet weak var imageviewItem: UIImageView!
    
    func setimages(item :HomeImage,isFile :Bool){
        imageviewItem.sd_setImage(with: URL(string: item.urls?.small ?? "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__480.jpg"))
    }
    func setLocalImage(url:URL){
        imageviewItem.sd_setImage(with: url)
    }
}
