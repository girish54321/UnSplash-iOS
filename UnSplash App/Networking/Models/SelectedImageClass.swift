//
//  SelectedImageClass.swift
//  UnSplash App
//
//  Created by Girish Parate on 22/01/22.
//

import Foundation

struct SelectedImageClass {
    var description: String
    var urls: Urls?
}

class SelectedImageSingleton {
    static let selectedSelectedImage = SelectedImageSingleton()
    var selectedImage : SelectedImageClass!
    private init() {
    }
}
