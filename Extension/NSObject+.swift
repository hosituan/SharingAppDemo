//
//  NSObject+.swift
//  HR-Checkin
//
//  Created by Ho Si Tuan on 14/03/2022.
//

import Foundation

protocol ClassName {
    static var className: String { get }
}
extension NSObject: ClassName {
    static var className: String {
        return String(describing: self)
    }
}
