//
//  ImageInfoViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 28/09/21.
//

import UIKit
import Alamofire
import AlamofireImage
import SDDownloadManager
import FittedSheets

class ImageInfoViewController: UIViewController, URLSessionDelegate, UIDocumentInteractionControllerDelegate {
    
    var imageInfo:HomeImage!
    @IBOutlet weak var infoImageView: UIImageView!
    var fileData: NSMutableData = NSMutableData()
    var dataTask: URLSessionDataTask?
    var expectedContentLength = 0
    var progress: Float = 0.0
    var localFile : Bool = false
    var localImageUrl : URL!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView();
        hideDownloadButton();
    }
    
    func hideDownloadButton(){
        if(localFile){
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "square.and.arrow.up"),
                style: .done,
                target: self,
                action: #selector(downloadButtonOnClick)
            )
        }
    }
    
    func updateView() {
        if(localFile){
            self.navigationItem.title = "Download Image"
            infoImageView.sd_setImage(with: localImageUrl)
        }else{
            self.navigationItem.title = imageInfo.description ?? imageInfo.altDescription ?? "Save Image"
            infoImageView?.sd_setImage(with: URL(string: imageInfo.urls?.regular ??  "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__480.jpg"))
        }
    }
    
    func shareImage() {
        var imageData : UIImage!;
        do {
            let imageUrl = try Data(contentsOf: localImageUrl)
            imageData =  UIImage(data: imageUrl)
        } catch {
            print("Error loading image : \(error)")
        }
        let activityController = UIActivityViewController(activityItems: [imageData!,], applicationActivities: nil)
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed")
            } else {
                print("canceled")
            }
        }
        present(activityController, animated: true) {
            print("presented")
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    func showModal() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DownloadsOptionsViewController") as? DownloadsOptionsViewController {
            viewController.url = imageInfo.urls
            if let navigator = navigationController {
                //                   navigator.pushViewController(viewController, animated: true)
                if #available(iOS 15.0, *) {
                    if let sheet = viewController.presentationController as? UISheetPresentationController{
                        sheet.detents = [.medium(), .large()]
                        sheet.prefersGrabberVisible = false
                    }
                    present(viewController, animated: true, completion: nil)
                } else {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
            
        }
    }
    
    @IBAction func downloadButtonOnClick(_ sender: Any) {
        if(localFile){
            shareImage()
        }else{
            _ =  imageInfo.urls?.regular ??  "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__480.jpg"
            showModal()
        }
    }
}

func savePdf(urlString:String, fileName:String) {
    DispatchQueue.main.async {
        let url = URL(string: urlString)
        let pdfData = try? Data.init(contentsOf: url!)
        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        let pdfNameFromUrl = "\(UUID().uuidString).png"
        let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
        do {
            try pdfData?.write(to: actualPath, options: .atomic)
            print(actualPath)
        } catch {
            print("Pdf could not be saved")
        }
    }
}




