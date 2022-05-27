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
    static func configureContextMenu(index: Int,onDelete: @escaping (_ index:Int) -> Void) -> UIContextMenuConfiguration{
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            let edit = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in onDelete(index)
            }
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
            }
            return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [edit,share])
        }
        return context
    }
    
    func showAlertAction(title: String, message: String,vc: UIViewController, actionClosure: @escaping () -> Void){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in actionClosure()}))
        DispatchQueue.main.async { vc.present(alertController, animated: true) }
    }
    
    func showBootmSheet(title: String, message: String,vc: UIViewController,actionsList: [UIAlertAction]){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for actions in actionsList {
            alertController.addAction(actions)
        }
        
        let cancelButton = makeUIAlertButton(title: "Cancel", style: UIAlertAction.Style.cancel, actionFunction: {
            print("Cancel taped")
        })
        
        alertController.addAction(cancelButton)
        alertController.view.tintColor = .purple
        DispatchQueue.main.async { vc.present(alertController, animated: true) }
    }
    
    func makeUIAlertButton(title: String, style:UIAlertAction.Style ,actionFunction: @escaping () -> Void) -> UIAlertAction {
        let actionButton = UIAlertAction(title: title, style: style, handler: {(action: UIAlertAction!) in actionFunction()})
        return actionButton
    }
    
    static func showSearchButton(action: Selector ,navigationItem:UINavigationItem){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .done,
            target: self,
            action: action
        )
    }
    
    static func loadLocalImages(){
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl!, includingPropertiesForKeys: nil)
            let myCustomViewController: SavedViewController = SavedViewController(nibName: nil, bundle: nil)
            if(myCustomViewController.savedImages != nil){
                myCustomViewController.savedImages.removeAll()
                myCustomViewController.savedImages = directoryContents
                if(myCustomViewController.savedImageList != nil){
                    myCustomViewController.savedImageList.reloadData()
                }
            }
        } catch {
            print(error)
            
        }
        
    }
}

extension UIImageView {
    func makeRounded() {
        self.layer.cornerRadius = 6.0
        self.clipsToBounds = true
    }
}
