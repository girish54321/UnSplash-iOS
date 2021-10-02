//
//  TopicImagesViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 02/10/21.
//

import UIKit
import SDWebImage

class TopicImagesViewController: UIViewController {

    @IBOutlet weak var TopicImages: UICollectionView!
    var topicData: TopicResponseElement!
    var itemsArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set CollectionView Delegate & DataSource
        TopicImages.delegate = self
        TopicImages.dataSource = self
        
        // Set CollectionView Flow Layout for Header and Items
        let flowLayout = CollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.numberOfItemsPerRow = 3
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        flowLayout.minimumLineSpacing = 1.0
        flowLayout.minimumInteritemSpacing = 1.0
        TopicImages.collectionViewLayout = flowLayout
        
        // Load Demo Data to CollectionView Cells
        loadData()
        
        // Register Header
        TopicImages.register(StretchyCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
    }
    
    func loadData() {
        for _ in 0...53 {
            // Add random color in the array
            itemsArray.append(getRandomColor())
        }
        self.TopicImages.reloadData()
    }
    
    func getRandomColor() -> UIColor {
        // Generate between 0 to 1
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Make sure the top constraint of the CollectionView is equal to Superview and not Safe Area
        
        // Hide the navigation bar completely
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        // Make the Navigation Bar background transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.tintColor = .white

        // Remove 'Back' text and Title from Navigation Bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Name", style: .plain, target: nil, action: nil)
        self.title = topicData.title
    }
}

extension TopicImagesViewController: UICollectionViewDataSource {
    // Set Header in CollectionView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as? StretchyCollectionHeaderView {
            // Add Image to the Header
            headerView.imageView.sd_setImage(with: URL(string: topicData.coverPhoto?.urls?.small ?? "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__480.jpg"))
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicsImageItem", for: indexPath)
        cell.backgroundColor = itemsArray[indexPath.row]
        return cell
    }
}

extension TopicImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.TopicImages.frame.size.width, height: 250)
    }
}

