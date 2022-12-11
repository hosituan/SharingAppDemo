//
//  UITableView+.swift
//  HR-Checkin
//
//  Created by Ho Si Tuan on 13/03/2022.
//

import Foundation
import UIKit
extension UITableView {
    func registerCells(_ cellIdentifiers: AnyClass...) {
        for classIdentifier in cellIdentifiers {
            self.register(classIdentifier, forCellReuseIdentifier: String(describing: classIdentifier))
        }
    }
}
