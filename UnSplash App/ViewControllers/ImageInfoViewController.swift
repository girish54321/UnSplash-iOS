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
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            print("Error!")
            
        } else {
            UIHelper().showAlertAction(title: "Image Saved", message: "Image is saved to you camera rool you can check now.", vc: self, actionClosure: {
                print("Ok Taped")
            })
        }
    }
    
    func saveToStorage() {
        
        //        var imageData : UIImage!;
        //        do {
        //            let imageUrl = try Data(contentsOf: localImageUrl)
        //            imageData =  UIImage(data: imageUrl)
        //        } catch {
        //            print("Error loading image : \(error)")
        //        }
        //        UIImageWriteToSavedPhotosAlbum(imageData, self, #selector(saveCompleted), nil)
        
        
        //        let activityController = UIActivityViewController(activityItems: [imageData!,], applicationActivities: nil)
        //        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
        //            if completed {
        ////                UIHelper().showAlertAction(title: "Image Saved", message: "", actionClosure: {
        ////                    print("done")
        ////                })
        //                UIHelper().showAlertAction(title: "Image Saved", message: "Image is saved to you phone you can check now.", vc: self, actionClosure: {
        //                    print("Ok Taped")
        //                })
        //                print("completed")
        //            } else {
        //                print("canceled")
        //            }
        //        }
        //        present(activityController, animated: true) {
        //            print("presented")
        //        }
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
    
    func showDownloadOption(pathType:imagePathType) {
        var imageURLLocal: String!
        var actionsButtons :[UIAlertAction] = []
        
        var urlList :[DownlodClass] = []
        let url1 = DownlodClass(title: "Small", subTitle: "Smallest size", url: selectedImage.urls?.small ?? "", size: "1MB+")
        let url2 = DownlodClass(title: "Regular", subTitle: "For mobile wallpaper", url: selectedImage.urls?.regular ?? "", size: "3MB+")
        let url3 = DownlodClass(title: "Full", subTitle: "For Desktop", url: selectedImage.urls?.full ?? "", size: "6MB+")
        let url4 = DownlodClass(title: "Raw", subTitle: "Original file", url: selectedImage.urls?.raw ?? "", size: "10MB+")
        urlList = [url1,url2,url3,url4]
        
        
        for urls in urlList {
            let urlButton = UIHelper().makeUIAlertButton(title: urls.title, style: UIAlertAction.Style.default, actionFunction: {
                imageURLLocal = urls.url
                
                if(pathType == imagePathType.appStorage){
                    DownloadHelper.saveImage(urlString: imageURLLocal, fileName: "", vc: self)
                }
                if(pathType == imagePathType.phoneStorage){
                    let imageData : UIImage = self.createUIImage(url: imageURLLocal)
                    
                    let activityController = UIActivityViewController(activityItems: [imageData,], applicationActivities: nil)
                    activityController.completionWithItemsHandler = { (nil, completed, _, error) in
                        if completed {
                            UIHelper().showAlertAction(title: "Image Saved", message: "Image is saved to you phone you can check now.", vc: self, actionClosure: {
                                print("Ok Taped")
                            })
                            print("completed")
                        } else {
                            print("canceled")
                        }
                    }
                    self.present(activityController, animated: true) {
                        print("presented")
                    }
                }
                if(pathType == imagePathType.cameraRoll){
                    let imageData : UIImage = self.createUIImage(url: imageURLLocal)
                    UIImageWriteToSavedPhotosAlbum(imageData, self, #selector(self.saveCompleted), nil)
                }
            })
            actionsButtons.append(urlButton)
        }
        
        UIHelper().showBootmSheet(title: selectedImage.description, message: "Select where to save image", vc: self, actionsList: actionsButtons)
    }
    func askWhereToSave() {
        let cameraButton = UIHelper().makeUIAlertButton(title: "Camera Roll", style: UIAlertAction.Style.default, actionFunction: {
            self.showDownloadOption(pathType: imagePathType.cameraRoll)
        })
        let appStorageButton = UIHelper().makeUIAlertButton(title: "App Storage", style: UIAlertAction.Style.default, actionFunction: {
            self.showDownloadOption(pathType: imagePathType.appStorage)
        })
        let phoneStorageButton = UIHelper().makeUIAlertButton(title: "Phone Storge", style: UIAlertAction.Style.default, actionFunction: { [self] in
            self.showDownloadOption(pathType: imagePathType.phoneStorage)
        })
        UIHelper().showBootmSheet(title: selectedImage.description, message: "Select where to save image", vc: self, actionsList: [cameraButton,appStorageButton,phoneStorageButton])
    }
    
    @IBAction func downloadButtonOnClick(_ sender: Any) {
        if(localFile){
            saveToStorage()
        } else {
            askWhereToSave()
        }
    }
}




