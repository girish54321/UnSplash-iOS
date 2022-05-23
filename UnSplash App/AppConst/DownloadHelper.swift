//
//  DownloadHelper.swift
//  UnSplash App
//
//  Created by Girish Parate on 18/10/21.
//

import Foundation
import UIKit

struct DownloadHelper {
    static func saveImage(urlString:String, fileName:String,vc: UIViewController) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "\(UUID().uuidString).png"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("successfully saved!")
                vc.view.removeBluerLoader()
                UIHelper.loadLocalImages()
                UIHelper().showAlertAction(title: "Image Saved", message: "You can see your new image on Saved Tab", vc: vc, actionClosure: {
                    print("Ok Taped")
                })
            } catch {
                print("could not be saved")
            }
        }
    }
}


