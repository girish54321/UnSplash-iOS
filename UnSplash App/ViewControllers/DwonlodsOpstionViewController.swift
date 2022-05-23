//
//  DwonlodsOpstionViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 10/10/21.
//

import UIKit

class DownloadsOptionsViewController: UIViewController {
    
    var op :[DownlodClass] = []
    @IBOutlet weak var downloadList: UITableView!
    
    var url: Urls!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadList.delegate = self
        downloadList.dataSource = self
        CreateArrayOfurls()
    }
    
    func CreateArrayOfurls() {
        let url1 = DownlodClass(title: "Small", subTitle: "Smallest size", url: url.small ?? "", size: "1MB+")
        let url2 = DownlodClass(title: "Regular", subTitle: "For mobile wallpaper", url: url.regular ?? "", size: "3MB+")
        let url3 = DownlodClass(title: "Full", subTitle: "For Desktop", url: url.full ?? "", size: "6MB+")
        let url4 = DownlodClass(title: "Raw", subTitle: "Original file", url: url.raw ?? "", size: "10MB+")
        op = [url1,url2,url3,url4]
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
        if error != nil {
            print("Error is very bad")
            //            errorsHandler?(error)
        } else {
            print("All good")
            //            successHandler?()
            UIHelper().showAlertAction(title: "Image Saved", message: "Image is saved to you phone you can check now.", vc: self, actionClosure: {
                print("Ok Taped")
            })
        }
    }
    
}

extension DownloadsOptionsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return op.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = op[indexPath.row]
        
        
        //        self.view.showBlurLoader()
        //        DownloadHelper.saveImage(urlString: video.url, fileName: "", vc: self)
        //        var imageData : UIImage!;
        //        do {
        //            let imageUrl = try Data(contentsOf: URL(string: video.url)!)
        //            imageData =  UIImage(data: imageUrl)
        //        } catch {
        //            print("Error loading image : \(error)")
        //        }
        //        UIImageWriteToSavedPhotosAlbum(imageData, self, #selector(saveCompleted), nil)
        
        //        let activityController = UIActivityViewController(activityItems: [imageData!,], applicationActivities: nil)
        //        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
        //            if completed {
                        UIHelper().showAlertAction(title: "Image Saved", message: "Image is saved to you phone you can check now.", vc: self, actionClosure: {
                            print("Ok Taped")
                        })
        //                print("completed")
        //            } else {
        //                print("canceled")
        //            }
        //        }
        //        present(activityController, animated: true) {
        //            print("presented")
        //        }
        // 1
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = op[indexPath.row]
        let cell = downloadList.dequeueReusableCell(withIdentifier: "DwonlodCell") as! DwonlodCell
        cell.updateTitle(item: video)
        return cell
    }
    
}
