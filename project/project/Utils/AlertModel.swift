//
//  AlertModel.swift
//  project
//
//  Created by Mohammad Bitar on 9/26/20.
//

import Foundation
import UIKit

struct Alert {
    
    static func showSuccess(on vc: UIViewController, with message: String) {
        handleAlert(on: vc, with: "Success", message: message)
    }
    
    static func showError(on vc: UIViewController, with message: String) {
        handleAlert(on: vc, with: "Error", message: message)
    }
    
    static func showWarning(on vc: UIViewController, with message: String) {
        handleAlert(on: vc, with: "Warning", message: message)
    }
    
    fileprivate static func handleAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}
