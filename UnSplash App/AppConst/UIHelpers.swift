//
//  UIHelpers.swift
//  UnSplash App
//
//  Created by Girish Parate on 16/11/21.
//

import Foundation
import UIKit

struct UIHelper {
//    MARK- :Context Menus
    func configureContextMenu(index: Int) -> UIContextMenuConfiguration{
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
            let edit = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                print("edit button clicked")
            }
            
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                print("edit button clicked")
            }
            return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [edit,share])
        }
        return context
    }
    
//    MARK:- Search Button (Tab bar)
    static func showSearchButton(action: Selector ,navigationItem:UINavigationItem){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .done,
            target: self,
            action: action
        )
    }
}

extension UIImageView {

    func makeRounded() {
        self.layer.cornerRadius = 6.0
        self.clipsToBounds = true
    }
}
