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
    
    let imageDownloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .fifo,
        maximumActiveDownloads: 4,
        imageCache: AutoPurgingImageCache()
    )

    
    override func viewDidLoad() {
        super.viewDidLoad()
            updateView();
//        self.saveButton.set(true, animated:true)
            hideDwonlodButton()
        
       

    }
    
    func hideDwonlodButton(){
        if(localFile){
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "square.and.arrow.up"),
                style: .done,
                target: self,
                action: #selector(downlodButtonOnClick)
            )
        }
    }
    
    func updateView() {
        if(localFile){
            print("local")
            infoImageView.sd_setImage(with: localImageUrl)
        }else{
            print("form net")
            infoImageView?.sd_setImage(with: URL(string: imageInfo.urls?.regular ??  "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__480.jpg"))
        }
    }
    
    func shareImage() {
        // image to share
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
                print("cancled")
            }
        }
        present(activityController, animated: true) {
            print("presented")
        }
//        let activityController = UIActivityViewController(activityItems: ["stringWithLink"], applicationActivities: nil)
//
//        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
//            if completed {
//                print("completed")
//            } else {
//                print("cancled")
//            }
//        }
//        present(activityController, animated: true) {
//            print("presented")
//        }
//        guard let url = Bundle.main.url(forResource: "img", withExtension: "pdf") else { return }
//        guard let url = localImageUrl else {return}
//        let controller = UIDocumentInteractionController(url: url)
//        controller.delegate = self
//        controller.presentPreview(animated: true)
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    @IBAction func downlodButtonOnClick(_ sender: Any) {
        print("stat")
        if(localFile){
            shareImage()
        }else{
        let url =  imageInfo.urls?.regular ??  "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__480.jpg"
        savePdf(urlString: url, fileName: "yos")
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
                print("pdf successfully saved!")
                print(actualPath)
            } catch {
                print("Pdf could not be saved")
            }
        }
    }

   


