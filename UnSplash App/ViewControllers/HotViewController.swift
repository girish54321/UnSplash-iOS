//
//  HotViewController.swift
//  UnSplash App
//
//  Created by Apple on 16/09/21.
//

import UIKit
import PaginatedTableView
import Alamofire

class HotViewController: UIViewController {

    @IBOutlet weak var HotImagesList: PaginatedTableView!
    var apiTask: URLSessionDataTask!
    var newPhotos:[HomeImage] = []
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
        
//        let parameters = ["category": "Movies", "genre": "Action"]
//        AF.request("https://httpbin.org/get",parameters: parameters).responseJSON {
//            response in
//            debugPrint(response)
//            let data  = response.data!
//            print(data)
//        }
        
        fetchFilms()
        
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
       
//       let parmas = ImageAPIController().HomeImages(params: exampleDict)
//
//       apiTask = HomeViewController.sharedWebClient.load(resource: parmas) {[weak self] response in
//
//        guard self != nil else { return }
//           DispatchQueue.main.async {
//            if let image = response.value {
//                self?.newPhotos = image
//                self?.HotImagesList.reloadData()
//                self?.HotImagesList.loadData(refresh:false)
//               } else if let error = response.error {
//                debugPrint(error)
//                self!.view.makeToast(error.localizedDescription)
//               }
//           }
//       }
//    }
    
}
}


// MARK: - Alamofire API CAll
extension HotViewController {
  func fetchFilms() {
    print("Get data")
    let parameters: [String: Any] = [
            "client_id" : "jRBzm2zUw2eoIPSHZxLvY_hnSh0P8J91P2THDay4y8w",
             "order_by": "popular",
             "page":String(1),
             "per_page":"20"
        ]
    AF.request("https://api.unsplash.com/photos",method: .get,parameters: parameters).validate().responseDecodable(of: [HomeImage].self) { (response) in
      guard let data = response.value else {
        print(response)
        print("Error")
        return
      }
        print("Got The data")
        print(data[0].blurHash)
        self.newPhotos = data
        self.HotImagesList.reloadData()
    }
  }
  
//  func searchStarships(for name: String) {
//    let url = "https://swapi.dev/api/starships"
//    let parameters: [String: String] = ["search": name]
//    AF.request(url, parameters: parameters).validate()
//      .responseDecodable(of: Starships.self) { response in
//        guard let starships = response.value else { return }
//        self.items = starships.all
//        self.tableView.reloadData()
//    }
//  }
}


//
// MARK: Paginated Delegate - Where magic happens
//
extension HotViewController: PaginatedTableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func loadMore(_ pageNum: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
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
        return .none
    }
}
