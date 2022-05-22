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
 
    @IBOutlet weak var infoImageView: UIImageView!
    var fileData: NSMutableData = NSMutableData()
    var dataTask: URLSessionDataTask?
    var expectedContentLength = 0
    var progress: Float = 0.0
    var localFile : Bool = false
    var localImageUrl : URL!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var selectedImage : SelectedImageClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedImage = SelectedImageSingleton.selectedSelectedImage.selectedImage
        loadImageView();
        hideDownloadButton();
    }
    
    //MARK: Hide Download Button
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
    
    //MARK: Load Image into View
    func loadImageView() {
        if(localFile){
            self.navigationItem.title = "Download Image"
            infoImageView.sd_setImage(with: localImageUrl)
        }else{
            self.navigationItem.title = selectedImage.description
            infoImageView?.sd_setImage(with: URL(string: selectedImage.urls?.regular ??  "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__480.jpg"))
        }
    }
    
    func saveToStorage() {
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
//                UIHelper().showAlertAction(title: "Image Saved", message: "", actionClosure: {
//                    print("done")
//                })
                UIHelper().showAlertAction(title: "Image Saved", message: "Image is saved to you phone you can check now.", vc: self, actionClosure: {
                    print("Ok Taped")
                })
                print("completed")
            } else {
                print("canceled")
            }
        }
        present(activityController, animated: true) {
            print("presented")
        }
    }
    
    func showDownloadOptionModal() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DownloadsOptionsViewController") as? DownloadsOptionsViewController {
            viewController.url = selectedImage.urls
            if let navigator = navigationController {
                if #available(iOS 15.0, *) {
                    if let sheet = viewController.presentationController as? UISheetPresentationController {
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
            saveToStorage()
        } else {
            showDownloadOptionModal()
        }
    }
}




