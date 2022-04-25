//
//  TopicImagesCollectionViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 05/03/22.
//

import UIKit
import SDWebImage
import Alamofire
import CHTCollectionViewWaterfallLayout

class TopicImagesCollectionViewController: UICollectionViewController, CHTCollectionViewDelegateWaterfallLayout{

    var topicData: TopicResponseElement!
    var itemsArray = [UIColor]()
    var pageNumber : Int = 0
    var isPageRefreshing : Bool = false
    var newPhotos:[HomeImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set CollectionView Delegate & DataSource
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        setUpList()
    }
    
    // MARK: On end
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                pageNumber = pageNumber + 1
                getPhotos(page: pageNumber)
            }
        }
    }
    
    private func setUpList() {
        //MARK: CHTCollectionViewWaterfallLayout Start
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        layout.sectionInset = UIEdgeInsets(top: 1.0, left: 8.0, bottom: 0,  right: 8.0)
        //MARK: CHTCollectionViewWaterfallLayout End
        collectionView.collectionViewLayout = layout
        // Register Header
        collectionView.register(StretchyCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // Remove 'Back' text and Title from Navigation Bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Name", style: .plain, target: nil, action: nil)
        self.title = topicData.title
    }
    
    func goToImageInfo(imageData:HomeImage) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageInfoViewController") as? ImageInfoViewController {
            let data: SelectedImageClass = SelectedImageClass(description: imageData.description ?? "NA", urls: imageData.urls!)
            SelectedImageSingleton.selectedSelectedImage.selectedImage = data
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    
    // MARK: collectionView
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = newPhotos[indexPath.item]
        goToImageInfo(imageData: item)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as? StretchyCollectionHeaderView {
            // Add Image to the Header
            headerView.imageView.sd_setImage(with: URL(string: topicData.coverPhoto?.urls?.small ?? "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__480.jpg"))
            return headerView
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicsImageItem", for: indexPath as IndexPath) as! ImageItem
        let item = newPhotos[indexPath.row]
        cell.setimages(item: item,isFile:false)
        return cell
    }
    
    // MARK: List Item coustom Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = newPhotos[indexPath.row]
        let h = item.height!  //view.frame.size.width / 2
        return CGSize(width: CGFloat(item.width!), height: CGFloat(h))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: 250) // for image herder toolbar
    }
    // MARK: collectionView
    
}

// MARK: - Alamofire API CAll
extension TopicImagesCollectionViewController {
    func getPhotos(page:Int) {
        if(newPhotos.isEmpty){
            self.view.showBlurLoader()
        }
        let parameters: [String: Any] = [
            "client_id" : AppConst.clinetid,
            "page":String(page),
            "per_page":"20"
        ]
        AF.request("https://api.unsplash.com/topics/"+self.topicData.id!+"/photos",method: .get,parameters: parameters).validate().responseDecodable(of:[HomeImage].self) { (response) in
            guard let data = response.value else {
                self.view.removeBluerLoader()
                self.isPageRefreshing = false
                return
            }
            self.newPhotos.append(contentsOf: data)
            self.view.removeBluerLoader()
            self.collectionView.reloadData()
            self.isPageRefreshing = false
        }
    }
}


