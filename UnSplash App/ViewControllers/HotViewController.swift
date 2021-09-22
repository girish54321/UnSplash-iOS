//
//  HotViewController.swift
//  UnSplash App
//
//  Created by Apple on 16/09/21.
//

import UIKit
import PaginatedTableView
import Alamofire

class HotViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   @IBOutlet weak var HotImagesList: UITableView!
    var apiTask: URLSessionDataTask!
    var newPhotos:[HomeImage] = []
    var pageNumber : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hot"
        HotImagesList.delegate = self
        HotImagesList.dataSource = self
        getHotPhotos()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newPhotos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let data = newPhotos[indexPath.row]
        cell.setImageCell(item: data)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let friend = friends[indexPath.row]
//        goToInfo(friend: friend)
        print("onTap")
    }
}


// MARK: - Alamofire API CAll
extension HotViewController {
  func getHotPhotos() {
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
        self.newPhotos = data
        self.HotImagesList.reloadData()
    }
  }
}
