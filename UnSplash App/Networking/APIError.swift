//
//  APIError.swift
//  Reqres App
//
//  Created by Girish Parate on 21/08/21.
//

import Foundation
import Toast_Swift
struct APIError {

    func handleError(_ error: WebError<ErrorResponse>,self:UIViewController) {
        print(error)
        switch error {
        case .noInternetConnection:
            self.view.makeToast("The internet connection is lost")
        case .unauthorized:
            self.view.makeToast("Unfortunately something went wrong 2")
        case .other:
            self.view.makeToast("Unfortunately something went wrong 3")
        case .custom(let error):
            self.view.makeToast(error.errors[0])
            break
        }
    }

}
