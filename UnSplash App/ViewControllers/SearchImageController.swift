//
//  ViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 29/08/21.
//

import UIKit
import PaginatedTableView
import Alamofire

class SearchImageController: UIViewController, UISearchResultsUpdating{
  
    @IBOutlet weak var searchImageList: UICollectionView!
    var newPhotos:[HomeImage] = []
    var pageNumber : Int = 0
    var isPageRefreshing : Bool = false
    var resultSearchController = UISearchBar()
    let searchController = UISearchController()
    // MARK: Search query
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else{
            return;
        }
        print(text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        searchController.searchResultsUpdater = self;
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchImageList.register(StretchyCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerViews")
        setUpImageList()
    }
    
    // MARK: On end
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.searchImageList.contentOffset.y >= (self.searchImageList.contentSize.height - self.searchImageList.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                pageNumber = pageNumber + 1
                print("on end API")
//                getHotPhotos(page: pageNumber)
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
        searchImageList.register(UICollectionViewCell.self,forCellWithReuseIdentifier: "cell")
        searchImageList.delegate = self
        searchImageList.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        searchImageList.setCollectionViewLayout(layout, animated: true)
    }
    
}

//MARK: ListView code
extension SearchImageController: UICollectionViewDataSource {
    
    // Set Header in CollectionView
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerViews", for: indexPath) as? StretchyCollectionHeaderView {
////             Add Image to the Header
//            headerView.imageView.sd_setImage(with: URL(string:"https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__480.jpg"))
//            return headerView
//        }
//        return UICollectionReusableView()
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchImageItem", for: indexPath as IndexPath) as! ImageItem
        let item = newPhotos[indexPath.row]
        cell.setimages(item: item,isFile:false)
        return cell
    }
}


extension SearchImageController: UICollectionViewDelegateFlowLayout {
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 200, height: 250) // for image herder toolbar
//    }
}

// MARK: - On Tap
extension SearchImageController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item at \(indexPath.section)/\(indexPath.item) tapped")
        let item = newPhotos[indexPath.item]
        goToImageInfo(imageData: item)
    }
    // MARK: - Contex menu
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        UIHelper().configureContextMenu(index: indexPath.row)
    }
}

// MARK: - Alamofire API CAll
extension SearchImageController {
    func getHotPhotos(page:Int) {
        if(newPhotos.isEmpty){
            self.view.showBlurLoader()
        }
        
        let parameters: [String: Any] = [
            "client_id" : "jRBzm2zUw2eoIPSHZxLvY_hnSh0P8J91P2THDay4y8w",
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
            self.searchImageList.reloadData()
            self.view.removeBluerLoader()
            self.isPageRefreshing = false
        }
    }
}
