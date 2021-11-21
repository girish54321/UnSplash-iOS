//
//  UIHelpers.swift
//  UnSplash App
//
//  Created by Girish Parate on 16/11/21.
//

import Foundation
import UIKit

struct UIHelper {

    func configureContextMenu(index: Int) -> UIContextMenuConfiguration{
            let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
                
                let edit = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                    print("edit button clicked")
                }
                
                let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                    print("edit button clicked")
                }
//                let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil,attributes: .destructive, state: .off) { (_) in
//                    print("delete button clicked")
//                }
                return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [edit,share])
            }
            return context
        }
}
