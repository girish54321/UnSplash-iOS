//
//  SearchImageCollectionViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 16/01/22.
//

import UIKit
import PaginatedTableView
import Alamofire

private let reuseIdentifier = "Cell"

class SearchImageCollectionViewController: UICollectionViewController, UISearchResultsUpdating ,UISearchBarDelegate, UISearchControllerDelegate,UICollectionViewDelegateFlowLayout {
    
    var newPhotos:[Result] = []
    var pageNumber : Int = 0
    var isPageRefreshing : Bool = false
    var resultSearchController = UISearchBar()
    let searchController = UISearchController()
    var searchText : String = ""
    
    @IBOutlet weak var searchImage: UIImageView!
    // MARK: Search query
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return;
        }
        self.searchText = text
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
        searchController.searchBar.delegate = self
        
        searchController.automaticallyShowsSearchResultsController = false
        searchController.showsSearchResultsController = false
        searchController.delegate = self
        searchController.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        setUpImageList()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSearchPhotos(page: pageNumber)
        newPhotos.removeAll()
        self.collectionView.reloadData()
        pageNumber = 0
        // searchImage.isHidden = true
    }
    
    // MARK: On end
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)) {
            if  !isPageRefreshing && self.searchText != ""  {
                isPageRefreshing = true
                pageNumber = pageNumber + 1
                getSearchPhotos(page: pageNumber)
            }
        }
    }
    
    
    func didDismissSearchController(_ searchController: UISearchController) {
        // When Search is removed
        newPhotos.removeAll()
        self.collectionView.reloadData()
        pageNumber = 0
//        searchImage.isHidden = false
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
        self.collectionView.register(UICollectionViewCell.self,forCellWithReuseIdentifier: "cell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPhotos.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchImageItem", for: indexPath as IndexPath) as! ImageItem
        let item = newPhotos[indexPath.row]
        cell.setimagesForSearch(item: item,isFile:false)
        return cell
    }
    
    // MARK: For Size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width: widthPerItem - 8, height: 240)
    }
    // MARK: For Size
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = newPhotos[indexPath.item]
//        goToImageInfo(imageData: item)
    }
}



// MARK: - Alamofire API CAll
extension SearchImageCollectionViewController {
    func getSearchPhotos(page:Int) {
        if(newPhotos.isEmpty){
            self.view.showBlurLoader()
        }
        
        let parameters: [String: Any] = [
            "client_id" : AppConst.clinetid,
            "query": searchText,
            "page":String(page),
            "per_page":"30"
        ]
        AF.request(AppConst.baseurl+AppConst.search,method: .get,parameters: parameters).validate().responseDecodable(of: SearchImageResponse.self) { (response) in
            print(response)
            guard let data = response.value else {
                print("Error")
                print(response)
                self.view.removeBluerLoader()
                self.isPageRefreshing = false
                return
            }
            self.newPhotos.append(contentsOf: data.results!)
            self.collectionView.reloadData()
            self.view.removeBluerLoader()
            self.isPageRefreshing = false
        }
    }
}

