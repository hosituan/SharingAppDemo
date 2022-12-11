//
//  Array+.swift
//  HR-Checkin
//
//  Created by HoSiTuan on 21/03/2022.
//

import Foundation

extension Array where Element == Double {
    func toString() -> String {
        var string = ""
        for item in self {
            string += "\(item),"
        }
        return string
    }
}
