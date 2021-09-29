//
//  TopicImageItem.swift
//  UnSplash App
//
//  Created by Girish Parate on 29/09/21.
//

import Foundation

import UIKit
import SDWebImage

class TopicImageItem: UICollectionViewCell {
    @IBOutlet weak var topicImage: UIImageView!
    @IBOutlet weak var topicTitle: UITextView!
    
    func setTopicData(item : HomeImage){
        topicImage.sd_setImage(with: URL(string: item.urls?.thumb ?? "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__480.jpg"))
    }
}
