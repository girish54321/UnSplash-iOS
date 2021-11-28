//
//  Alert.swift
//  UnSplash App
//
//  Created by Girish Parate on 18/10/21.
//

import Foundation
import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String,onOkPress: UIAlertAction?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if(onOkPress != nil){
            alert.addAction(onOkPress!)
        }else           {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }
        
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    static func showIncompleteFormAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Ugly Alert Code", message: "You should really refactor this",onOkPress: nil)
    }
    static func showInvalidEmailAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Invalid Email", message: "Please use a correct email",onOkPress: nil)
    }
    
    static func showUnableToRetrieveDataAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Unable to Retrieve Data", message: "Network Error",onOkPress: nil)
    }
    static func showDonlodDoneAlert(on vc: UIViewController) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                vc.dismiss(animated: true, completion: nil)
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
                
            }
        })
        showBasicAlert(on: vc, with: "Saved", message: "Image saved.",onOkPress: alertAction)
    }
    
}
