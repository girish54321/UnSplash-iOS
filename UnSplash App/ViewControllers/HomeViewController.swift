//
//  ViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 29/08/21.
//

import UIKit
import PaginatedTableView
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet weak var HomeImageList: UICollectionView!
    var newPhotos:[HomeImage] = []
    var pageNumber : Int = 0
    var isPageRefreshing : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        setUpImageList()
    }
    
    // MARK: On end
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.HomeImageList.contentOffset.y >= (self.HomeImageList.contentSize.height - self.HomeImageList.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                pageNumber = pageNumber + 1
                getHotPhotos(page: pageNumber)
            }
        }
    }
    
    func goToImageInfo(imageData:HomeImage) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageInfoViewController") as? ImageInfoViewController {
            viewController.imageInfo = imageData
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    private func setUpImageList() {
        HomeImageList.register(UICollectionViewCell.self,forCellWithReuseIdentifier: "cell")
        HomeImageList.delegate = self
        HomeImageList.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
    
        HomeImageList.register(MyTopCollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader,
                               withReuseIdentifier: MyTopCollectionReusableView.id)
        
        HomeImageList.register(MyBootomCollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionFooter,
                               withReuseIdentifier: MyBootomCollectionReusableView.id)
        
        HomeImageList.setCollectionViewLayout(layout, animated: true)
    }
    
    func createloader() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spiner = UIActivityIndicatorView()
        spiner.center = footerView.center
        footerView.addSubview(spiner)
        spiner.startAnimating()
        return footerView
    }
    
}

//MARK: ListView code
extension HomeViewController: UICollectionViewDataSource {
    // Set Header in CollectionView
//        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//            if kind == UICollectionView.elementKindSectionHeader {
//                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyTopCollectionReusableView.id, for: indexPath)
//            }
//            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyBootomCollectionReusableView.id, for: indexPath)
//        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeImageItem", for: indexPath as IndexPath) as! ImageItem
        let item = newPhotos[indexPath.row]
        cell.setimages(item: item,isFile:false)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.size.width, height: view.frame.size.width / 2 )
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.size.width, height: view.frame.size.width / 2 )
//    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
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

// MARK: - On Tap
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = newPhotos[indexPath.item]
        goToImageInfo(imageData: item)
    }
}

// MARK: - Alamofire API CAll
extension HomeViewController {
    func getHotPhotos(page:Int) {
        if(newPhotos.isEmpty){
            self.view.showBlurLoader()
        }
        
        let parameters: [String: Any] = [
            "client_id" : AppConst.clinetid,
            "order_by": "latest",
            "page":String(page),
            "per_page":"20"
        ]
        AF.request(AppConst.baseurl+AppConst.photoUrl,method: .get,parameters: parameters).validate().responseDecodable(of: [HomeImage].self) { (response) in
            guard let data = response.value else {
                print("Error")
                self.view.removeBluerLoader()
                self.isPageRefreshing = false
                return
            }
            self.newPhotos.append(contentsOf: data)
            self.HomeImageList.reloadData()
            self.view.removeBluerLoader()
            self.isPageRefreshing = false
        }
    }
}
