//
//  String+.swift
//  HR-Checkin
//
//  Created by Ho Si Tuan on 21/03/2022.
//

import Foundation
extension String {
    func trimmed() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func trimmedAndLowercased() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).lowercased()
    }
    
    func isValidEmail() -> Bool {
        let laxString = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let emailTest : NSPredicate = NSPredicate(format:"SELF MATCHES %@", laxString)
        return emailTest.evaluate(with: self)
    }
     
    func isValidPassword() -> Bool {
        return count >= 8
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension String {
    func toArray() -> [Double] {
        var vector: [Double] = []
        let array = self.components(separatedBy: ",")
        for item in array {
            if let value = Double(item) {
                vector.append(value)
            }
        }
        return vector
    }
    
    func toIdAndName() -> (String?, String?) {
        let array = self.components(separatedBy: "~~")
        if array.count == 2 {
            return (array[0], array[1])
        } else {
            return (nil, nil)
        }
    }
}

struct Strings {
    static let commonError = "Something went wrong. Please try again later!"
}


extension String {
    func toDate() -> Date? {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter.date(from: self)
    }
}

