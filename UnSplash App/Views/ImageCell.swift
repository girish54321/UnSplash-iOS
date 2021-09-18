//
//  ImageCell.swift
//  UnSplash App
//
//  Created by Apple on 16/09/21.
//

import Foundation
import UIKit
import SDWebImage

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    func setImageCell(item:HomeImage) {
        imageItem.sd_setImage(with: URL(string: item.urls?.thumb ?? ""))
        title.text = item.altDescription ?? "NA"
        subTitle.text =  "NA"
    }
}
