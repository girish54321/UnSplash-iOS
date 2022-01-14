//
//  SearchImageController.swift
//  UnSplash App
//
//  Created by Girish Parate on 29/08/21.
//

import UIKit
import PaginatedTableView
import Alamofire

class SearchImageController: UIViewController, UISearchResultsUpdating ,UISearchBarDelegate, UISearchControllerDelegate{
  
    @IBOutlet weak var searchImageList: UICollectionView!
    var newPhotos:[HomeImage] = []
    var pageNumber : Int = 0
    var isPageRefreshing : Bool = false
    var resultSearchController = UISearchBar()
    let searchController = UISearchController()
    // MARK: Search query
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // Search View
        searchController.searchResultsUpdater = self;
        resultSearchController.delegate = self
        resultSearchController.showsScopeBar = true
    
        // Fix On Search clieck
        searchController.searchResultsUpdater = self
           searchController.searchBar.delegate = self
        
        searchController.automaticallyShowsSearchResultsController = false
        searchController.showsSearchResultsController = false
        searchController.delegate = self
        searchController.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        setUpImageList()
        getHotPhotos(page: pageNumber)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Hey Seach")
    }
    
    // MARK: On end
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.searchImageList.contentOffset.y >= (self.searchImageList.contentSize.height - self.searchImageList.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                pageNumber = pageNumber + 1
                getHotPhotos(page: pageNumber)
            }
        }
    }
    
    
    func didDismissSearchController(_ searchController: UISearchController) {
        // When Search is removed
        newPhotos.removeAll()
        searchImageList.reloadData()
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
}

// MARK: - On Tap
extension SearchImageController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = newPhotos[indexPath.item]
        goToImageInfo(imageData: item)
    }
}

// MARK: - Alamofire API CAll
extension SearchImageController {
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
            self.searchImageList.reloadData()
            self.view.removeBluerLoader()
            self.isPageRefreshing = false
        }
    }
}
