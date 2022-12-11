//
//  UIAlertController+.swift
//  HR-Checkin
//
//  Created by Ho Si Tuan on 21/03/2022.
//

import Foundation
import UIKit

extension UIAlertController {
    class func show(title: String, message: String, okButton: String = "OK", iconImage: String? = nil, _ complete: (() -> Void)? = nil)  {
        executeBlockOnMainIfNeeded {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: okButton, style: .default) { action in
                complete?()
            }
            
            alertController.addAction(action)
            visibleViewController()?.present(alertController, animated: true)
        }
    }
}
