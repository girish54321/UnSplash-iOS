//
//  HomeCollectionViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 02/01/22.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import Alamofire

class HomeCollectionViewController: UICollectionViewController, CHTCollectionViewDelegateWaterfallLayout {
    var newPhotos:[HomeImage] = []
    var pageNumber : Int = 0
    var isPageRefreshing : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        setUpImageList()
    }
    
    // MARK: On end Scroll
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                pageNumber = pageNumber + 1
                getHotPhotos(page: pageNumber)
            }
        }
    }
    
    // MARK: On Tap Function
    func goToImageInfo(imageData:HomeImage) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageInfoViewController") as? ImageInfoViewController {
            let data: SelectedImageClass = SelectedImageClass(description: imageData.description ?? "NA", urls: imageData.urls!)
            SelectedImageSingleton.selectedSelectedImage.selectedImage = data
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    //MARK: Setup ListView
    private func setUpImageList() {
        collectionView.register(UICollectionViewCell.self,forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
//        let layout = UICollectionViewFlowLayout()
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
//        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)
    
        collectionView.register(MyTopCollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader,
                               withReuseIdentifier: MyTopCollectionReusableView.id)
        
        collectionView.register(MyBootomCollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionFooter,
                               withReuseIdentifier: MyBootomCollectionReusableView.id)
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    //MARK: List Size
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPhotos.count
    }
    //MARK: ImageItem
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeItem", for: indexPath as IndexPath) as! ImageItem
        let item = newPhotos[indexPath.row]
        cell.setimages(item: item,isFile:false)
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.alpha = 0
//        UIView.animate(withDuration: 0.3,animations: {cell.alpha = 1}, completion: nil)
//    }
    
    // MARK: List Item Size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    
    // MARK: List Item Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = newPhotos[indexPath.row]
        let h = item.height!  //view.frame.size.width / 2
        return CGSize(width: CGFloat(item.width!), height: CGFloat(h))
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        let lay = collectionViewLayout as! UICollectionViewFlowLayout
//
//        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
//
//        return CGSize(width: widthPerItem - 8, height: 240)
//    }
    
   // MARK: On List Tap
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = newPhotos[indexPath.item]
        goToImageInfo(imageData: item)
    }
}

// MARK: - Alamofire API CAll
extension HomeCollectionViewController {
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
            self.collectionView.reloadData()
            self.view.removeBluerLoader()
            self.isPageRefreshing = false
        }
    }
}
