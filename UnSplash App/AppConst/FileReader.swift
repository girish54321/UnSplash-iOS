//
//  FileReader.swift
//  UnSplash App
//
//  Created by Girish Parate on 07/03/23.
//

import Foundation
struct FileReader {
     func loadLocalImages(){
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl!, includingPropertiesForKeys: nil)
            let myCustomViewController = SavedCollectionViewController()
            if(myCustomViewController.savedImages.count > 0){
                myCustomViewController.savedImages.removeAll()
                myCustomViewController.savedImages = directoryContents
            }
        } catch {
            print(error)
        }

    }
}

