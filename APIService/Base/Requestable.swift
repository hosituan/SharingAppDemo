//
//  Requestable.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import Alamofire

protocol Requestable {
    associatedtype Response: Decodable
    var path: String { get }
    var httpBody: [String: Any]? { get }
    var queryParams: [String: Any]? { get }
    var httpMethod: HTTPMethod { get }
    var fullPath: String { get }
}

extension Requestable {
    var httpBody: [String: Any]? {
        get { return nil }
    }
    var queryParams: [String: Any]? {
        get { return nil }
    }
    var fullPath: String {
        get {
            var originPath = "" //Config.baseUrl + path + "?"
            let params = queryParams ?? [:]
            for key in params.keys {
                if let value = params[key] {
                    var q = value
                    if value is String {
                        q = (value as? String)?.trimmed().replacingOccurrences(of: " ", with: "%20") as? String ?? ""
                        originPath += "\(key)=\(q)&"
                    } else {
                        originPath += "\(key)=\(q)&"
                    }
                    
                }
            }
            return originPath
            
        }
    }
}

public enum Result<T, E> {
    case success(T)
    case failed(E)
    
    public var value: T? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }
    
    public var error: E? {
        switch self {
        case .failed(let error):
            return error
        default:
            return nil
        }
    }
}
