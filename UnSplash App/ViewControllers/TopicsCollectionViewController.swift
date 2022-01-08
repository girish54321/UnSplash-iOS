//
//  TopicsCollectionViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 08/01/22.
//

import UIKit
import Alamofire

class TopicsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var topicsData:[TopicResponseElement] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getTopicsPhotos(page: 1)
        setUpTopicsList()
    }
    
    func goToTopicImages(imageData:TopicResponseElement) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopicImagesViewController") as? TopicImagesViewController {
            viewController.topicData = imageData
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    private func setUpTopicsList() {
        collectionView.register(UICollectionViewCell.self,forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicsData.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicImageItem", for: indexPath as IndexPath) as! TopicImageItem
        let item = topicsData[indexPath.row]
        cell.setTopicData(item: item)
        return cell
    }
    
    //  For Size
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
    //  For Size
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item at \(indexPath.section)/\(indexPath.item) tapped")
        let item = topicsData[indexPath.item]
        goToTopicImages(imageData: item)
    }
}

// MARK: - Alamofire API CAll
extension TopicsCollectionViewController {
    func getTopicsPhotos(page:Int) {
        if(topicsData.isEmpty){
            self.view.showBlurLoader()
        }
        let parameters: [String: Any] = [
            "client_id" : AppConst.clinetid,
            "per_page" : 50
        ]
        AF.request(AppConst.baseurl+AppConst.topics,method: .get,parameters: parameters).validate().responseDecodable(of: [TopicResponseElement].self) { (response) in
            guard let data = response.value else {
                print(response)
                print("Topic Error")
                return
            }
            self.topicsData.append(contentsOf: data)
            self.view.removeBluerLoader()
            self.collectionView.reloadData()
        }
    }
}
