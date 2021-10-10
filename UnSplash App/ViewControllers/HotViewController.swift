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
    
    @IBOutlet weak var imageList: UICollectionView!
    var newPhotos:[HomeImage] = []
    var pageNumber : Int = 1
    var isPageRefreshing : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hot"
        setUpImageList()
    }
    
    // MARK: On end
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.imageList.contentOffset.y >= (self.imageList.contentSize.height - self.imageList.bounds.size.height)) {
               if !isPageRefreshing {
                   isPageRefreshing = true
                   pageNumber = pageNumber + 1
                   print("on end API")
                   getHotPhotos(page: pageNumber)
               }
           }
    }
    
    private func setUpImageList() {
        imageList.register(UICollectionViewCell.self,forCellWithReuseIdentifier: "cell")
        imageList.delegate = self
        imageList.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        imageList.setCollectionViewLayout(layout, animated: true)
       }
    
    func goToImageInfo(imageData:HomeImage) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageInfoViewController") as? ImageInfoViewController {
            viewController.imageInfo = imageData
               if let navigator = navigationController {
                   navigator.pushViewController(viewController, animated: true)
               }
           }
        }
}

//MARK : ListView code
extension HotViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hotImageItem", for: indexPath as IndexPath) as! ImageItem
        let item = newPhotos[indexPath.row]
        cell.setimages(item: item,isFile:false)
        return cell
    }
}

// MARK: - On Tap
extension HotViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("item at \(indexPath.section)/\(indexPath.item) tapped")
      let item = newPhotos[indexPath.item]
      goToImageInfo(imageData: item)
  }
}

extension HotViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                  layout collectionViewLayout: UICollectionViewLayout,
                  insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    func collectionView(_ collectionView: UICollectionView,
                   layout collectionViewLayout: UICollectionViewLayout,
                   sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
    
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
    
        return CGSize(width: widthPerItem - 8, height: 240)
    }
}

// MARK: - Alamofire API CAll
extension HotViewController {
    func getHotPhotos(page:Int) {
    let parameters: [String: Any] = [
            "client_id" : "jRBzm2zUw2eoIPSHZxLvY_hnSh0P8J91P2THDay4y8w",
             "order_by": "popular",
             "page":String(page),
             "per_page":"20"
        ]
      AF.request(AppConst.baseurl+AppConst.photoUrl,method: .get,parameters: parameters).validate().responseDecodable(of: [HomeImage].self) { (response) in
      guard let data = response.value else {
        print(response)
        print("Error")
          self.isPageRefreshing = false
        return
      }
        self.newPhotos.append(contentsOf: data)
        self.imageList.reloadData()
        self.isPageRefreshing = false
    }
  }
}
