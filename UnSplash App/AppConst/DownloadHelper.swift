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
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL //userDomainMask
            let pdfNameFromUrl = "\(UUID().uuidString).png"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("successfully saved!")
                vc.view.removeBluerLoader()
                FileReader().loadLocalImages()
                UIHelper().showAlertAction(title: "Image Saved", message: "You can see your new image on Saved Tab", vc: vc, actionClosure: {
                    print("Ok Taped")
                })
            } catch {
                print("could not be saved")
            }
        }
    }
    
    func createUIImage(url: String) -> UIImage {
        var imageData : UIImage!;
        do {
            let imageUrl = try Data(contentsOf: URL(string: url)!)
            imageData =  UIImage(data: imageUrl)
        } catch {
            print("Error loading image : \(error)")
        }
        return imageData
    }
    
    func shareImage (imageData: [UIImage], vc: UIViewController) {
        let activityController = UIActivityViewController(activityItems: imageData, applicationActivities: nil)
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                UIHelper().showAlertAction(title: "Image Saved", message: "Image is saved to you phone you can check now.", vc: vc, actionClosure: {
                    print("Ok Taped")
                })
                print("completed")
            } else {
                print("canceled")
            }
        }
        vc.present(activityController, animated: true) {
            print("presented")
        }
    }
    
}


