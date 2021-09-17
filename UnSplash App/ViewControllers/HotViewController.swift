//
//  HotViewController.swift
//  UnSplash App
//
//  Created by Apple on 16/09/21.
//

import UIKit
import PaginatedTableView

class HotViewController: UIViewController {

    @IBOutlet weak var HotImagesList: PaginatedTableView!
    var apiTask: URLSessionDataTask!
    var newPhotos:[HomeResponseElement] = []
    var pageNumber : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hot"
        HotImagesList.paginatedDelegate = self
        HotImagesList.paginatedDataSource = self
        
        // More settings
        HotImagesList.enablePullToRefresh = true
        HotImagesList.pullToRefreshTitle = NSAttributedString(string: "Pull to Refresh")
        HotImagesList.loadData(refresh: true)
        
        loadHotImages(number: pageNumber)
    }
    
    func loadHotImages(number:Int) {
        print("page number")
        print(number)
        apiTask?.cancel()
       let exampleDict: [String: Any] = [
               "client_id" : "jRBzm2zUw2eoIPSHZxLvY_hnSh0P8J91P2THDay4y8w",
                "order_by": "popular",
                "page":String(number),
                "per_page":"20"
        
           ]
       
       let parmas = ImageAPIController().HomeImages(params: exampleDict)
       
       apiTask = HomeViewController.sharedWebClient.load(resource: parmas) {[weak self] response in
           
        guard self != nil else { return }
           DispatchQueue.main.async {
            if let image = response.value {
                print(image[0].blurHash)
                self?.newPhotos = image
//                self?.newPhotos.append(contentsOf: image)
                self?.HotImagesList.reloadData()
                self?.HotImagesList.loadData(refresh:false)
               } else if let error = response.error {
                debugPrint(error)
                self!.view.makeToast(error.localizedDescription)
               }
           }
       }
    }
    
}


//
// MARK: Paginated Delegate - Where magic happens
//
extension HotViewController: PaginatedTableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func loadMore(_ pageNum: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
        // Call your api here
        // Send true in onSuccess in case new data exists, sending false will disable pagination
        pageNumber = pageNumber + 1
        loadHotImages(number: pageNumber)
        print("LOAD MOEW DATA")
    }
}

//
// MARK: Paginated Data Source
//
extension HotViewController: PaginatedTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
//            fatalError("The dequeued cell is not an instance of TableViewCell.")
//        }
//        cell.label.text = "Cell Number: \(self.list[indexPath.row])"
//        return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let item = newPhotos[indexPath.row]
        cell.setImageCell(item: item)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }
}

//
// MARK: Enable swipe in paginatedTableView
//
extension HotViewController {
    // For Swipe Actions
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    // To enable swipe, make sure you overide this method
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        if self.newPhotos[indexPath.row].id % 3 == 0 {
//            return .delete
//        } else {
//            return .none
//        }
        return .none
    }
}

//extension HotViewController: PaginatedTableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return newPhotos.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
//        let item = newPhotos[indexPath.row]
//        cell.setImageCell(item: item)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//            if indexPath.row == newPhotos.count - 1 {
//                // we are at last cell load more content
//               print("load moew")
////                pageNumber = pageNumber + 1
////                loadHotImages(number:pageNumber)
//            }
//        }
//
//}
