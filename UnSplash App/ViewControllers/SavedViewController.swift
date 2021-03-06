//
//  SavedViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 10/10/21.
//

import UIKit

class SavedViewController: UIViewController {
    
    @IBOutlet weak var savedImageList: UICollectionView!
    var savedImages :[URL] = []
    private let refreshControl = UIRefreshControl()
    let fileManager = FileManager.default
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageList()
        loadSavedImages()
    }
    
    @objc func loadSavedImages(){        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            savedImages.removeAll()
            savedImages = directoryContents
            savedImageList.reloadData()
            stopRefresher()
        } catch {
            print(error)
            stopRefresher()
        }
    }
    
    func stopRefresher() {
        refreshControl.endRefreshing()
    }
    
    private func setUpImageList() {
        savedImageList.register(UICollectionViewCell.self,forCellWithReuseIdentifier: "cell")
        savedImageList.delegate = self
        savedImageList.dataSource = self
        refreshControl.addTarget(self, action: #selector(loadSavedImages), for: .valueChanged)
        savedImageList.alwaysBounceVertical = true
        savedImageList.refreshControl = refreshControl
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        savedImageList.setCollectionViewLayout(layout, animated: true)
    }
    
    func goToImageInfo(imageData:URL) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageInfoViewController") as? ImageInfoViewController {
            viewController.localFile = true
            viewController.localImageUrl = imageData
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func deleteFile(index:Int) {
        do {
            try FileManager.default.removeItem(at: self.savedImages[index])
            let directoryContents = try FileManager.default.contentsOfDirectory(at: self.documentsUrl, includingPropertiesForKeys: nil)
            self.savedImages.removeAll()
            self.savedImages = directoryContents
            self.savedImageList.reloadData()
        } catch let error {
            print(error)
        }
    }
}


//MARK : ListView code
extension SavedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedImageItem", for: indexPath as IndexPath) as! ImageItem
        let item = savedImages[indexPath.row]
        cell.setLocalImage(url: item)
        return cell
    }
}


// MARK: - On Tap
extension SavedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = savedImages[indexPath.item]
        goToImageInfo(imageData: item)
    }
    // MARK: - Contex menu
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        UIHelper.configureContextMenu(index: indexPath.row,onDelete: deleteFile)
    }
}

extension SavedViewController: UICollectionViewDelegateFlowLayout {
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
