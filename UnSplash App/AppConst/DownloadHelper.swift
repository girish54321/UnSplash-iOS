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
                Alert.showDonlodDoneAlert(on: vc)
                print(actualPath)
            } catch {
                print("Pdf could not be saved")
            }
        }
    }

    static func deleteImage(){
        let fileManager = FileManager.default
               let documentsUrl =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first! as NSURL
               let documentsPath = documentsUrl.path
               do {
                   if let documentPath = documentsPath
                   {
                       let fileNames = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                       print("all files in cache: \(fileNames)")
                       for fileName in fileNames {

                           if (fileName.hasSuffix(".png"))
                           {
                               let filePathName = "\(documentPath)/\(fileName)"
                               try fileManager.removeItem(atPath: filePathName)
                           }
                       }

                       let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                       print("all files in cache after deleting images: \(files)")
                   }

               } catch {
                   print("Could not clear temp folder: \(error)")
               }
    }
}


