//
//  ViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 29/08/21.
//

import UIKit

class HomeViewController: UICollectionViewController {
    var photos = Photo.allPhotos()
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//      return .lightContent
//    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
      if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
        layout.delegate = self
      }
//      if let patternImage = UIImage(named: "Pattern") {
//        view.backgroundColor = UIColor(patternImage: patternImage)
//      }
        collectionView?.backgroundColor = .systemBackground
      collectionView?.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
  }

  extension HomeViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnotatedPhotoCell", for: indexPath as IndexPath) as! AnnotatedPhotoCell
      cell.photo = photos[indexPath.item]
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
      return photos[indexPath.item].image.size.height
    }
  }
