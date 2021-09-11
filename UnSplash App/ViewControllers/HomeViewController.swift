//
//  ViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 29/08/21.
//

import UIKit

class HomeViewController: UICollectionViewController {
    var Oldphotos = Photo.allPhotos()
    static let sharedWebClient = WebClient.init(baseUrl: "https://api.unsplash.com/")
    var newPhotos:[HomeResponseElement] = []
    var apiTask: URLSessionDataTask!
    
    override func viewDidLoad() {
      super.viewDidLoad()
      if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
        layout.delegate = self
      }
        collectionView?.backgroundColor = .systemBackground
      collectionView?.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        loadHomePhotos()
    }
    
    func loadHomePhotos() {
        apiTask?.cancel()
       let exampleDict: [String: Any] = [
               "client_id" : "jRBzm2zUw2eoIPSHZxLvY_hnSh0P8J91P2THDay4y8w",
                "order_by": "latest",
        "per_page":"30"
           ]
       
       let parmas = ImageAPIController().HomeImages(params: exampleDict)
       
       apiTask = HomeViewController.sharedWebClient.load(resource: parmas) {[weak self] response in
           
           guard let controller = self else { return }
           
           DispatchQueue.main.async {
            print("response")
            print(response.value?.count)
            if let image = response.value {
                print(response.value?[0].color)
                self?.newPhotos = image
                self?.collectionView.reloadData()
               } else if let error = response.error {
                   print("we have error")
                print(error.localizedDescription)
                   self!.view.makeToast(error.localizedDescription)
               }
           }
       }
    }
  }


//Do API call



  extension HomeViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return newPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnotatedPhotoCell", for: indexPath as IndexPath) as! AnnotatedPhotoCell
        cell.photo = newPhotos[indexPath.item]
      return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
      return CGSize(width: itemSize, height: itemSize)
    }
  }

  extension HomeViewController: PinterestLayoutDelegate {
    func collectionView(
      _ collectionView: UICollectionView,
      heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
////      return photos[indexPath.item].image.size.height
//        return CGFloat(newPhotos[indexPath.item].height!/30 ?? 100)
        
        let height : Int = newPhotos[indexPath.item].height!
        let width : Int = newPhotos[indexPath.item].width!
        return CGFloat (height/20 )
    }
  }
