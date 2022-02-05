//
//  DownloadHelper.swift
//  UnSplash App
//
//  Created by Girish Parate on 18/10/21.
//

import Foundation
import UIKit

struct DownloadHelper {
    static func savePdf(urlString:String, fileName:String,vc: UIViewController) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "\(UUID().uuidString).png"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
                vc.view.removeBluerLoader()
                UIHelper.loadLocalImages()
                Alert.showDonlodDoneAlert(on: vc)
                print(actualPath)
            } catch {
                print("Pdf could not be saved")
            }
        }
    }
}


