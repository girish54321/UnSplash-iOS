//
//  GridViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 18/09/21.
//

import UIKit

class GridViewController: UIViewController {

    @IBOutlet weak var gridCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
         /// 1
         gridCollectionView.register(UICollectionViewCell.self,forCellWithReuseIdentifier: "cell")

         /// 2
         gridCollectionView.delegate = self
         gridCollectionView.dataSource = self

         /// 3
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         /// 4
         layout.minimumLineSpacing = 8
         /// 5
         layout.minimumInteritemSpacing = 4

         /// 6
         gridCollectionView.setCollectionViewLayout(layout, animated: true)
       }
}


extension GridViewController: UICollectionViewDataSource {
    /// 1
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    /// 2
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageItem", for: indexPath as IndexPath) as! ImageItem
  //        cell.photo = newPhotos[indexPath.item]
        return cell
    }
}

extension GridViewController: UICollectionViewDelegateFlowLayout {
    /// 1
    func collectionView(_ collectionView: UICollectionView,
                  layout collectionViewLayout: UICollectionViewLayout,
                  insetForSectionAt section: Int) -> UIEdgeInsets {
        /// 2
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }

    /// 3
    func collectionView(_ collectionView: UICollectionView,
                   layout collectionViewLayout: UICollectionViewLayout,
                   sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// 4
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        /// 5
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        /// 6
        return CGSize(width: widthPerItem - 8, height: 240)
    }
}

