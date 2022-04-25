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
    
    let blur_hash = "LLA,?u%MD*IU~pxuIUIU-;t7RjNF"
    
    override func awakeFromNib() {
        imageviewItem.makeRounded()
    }
    func setimages(item :HomeImage,isFile :Bool){
        let height = item.height! / 120
        let width = item.width! / 120
        let hash = item.blur_hash ?? blur_hash
        let size = CGSize(width: CGFloat(width), height: CGFloat(height))
        imageviewItem.sd_setImage(with: URL(string: item.urls?.small ?? "Defult URL"), placeholderImage: UIImage.init(blurHash: hash, size: size))
    }
    
    func setimagesForSearch(item :Result,isFile :Bool){
        let height = item.height! / 120
        let width = item.width! / 120
        let hash = item.blur_hash ?? blur_hash
        let size = CGSize(width: CGFloat(width), height: CGFloat(height))
        imageviewItem.sd_setImage(with: URL(string: item.urls?.small ?? "Defult URL"), placeholderImage: UIImage.init(blurHash: hash, size: size))
    }
    
    func setLocalImage(url:URL){
        imageviewItem.sd_setImage(with: url)
    }
}
