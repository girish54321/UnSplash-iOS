//
//  MyCollectionReusableView.swift
//  UnSplash App
//
//  Created by Girish Parate on 01/01/22.
//

import UIKit

class MyTopCollectionReusableView: UICollectionReusableView {
    static let id = "MyTopCollectionReusableView"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "09"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}


class MyBootomCollectionReusableView: UICollectionReusableView {
    static let id = "MyBootomCollectionReusableView"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "09"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}
