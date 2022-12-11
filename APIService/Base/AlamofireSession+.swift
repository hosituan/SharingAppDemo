//
//  AlamofireSesson+.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import Alamofire

extension Session {
    func sendRequest<T: Requestable>(_ request: T, completionHandler: @escaping (Result<T.Response, Error>) -> Void) {
        print("Send request to: \(request.fullPath)")
        print("Body: \(request.httpBody ?? [:])")
        AF.request(request.fullPath, method: request.httpMethod, parameters: request.httpBody)
            .responseJSON { json in
                print(json)
            }
            .responseDecodable(of: T.Response.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data))
                case .failure(let error):
                    print(error)
                    completionHandler(.failed(error))
                }
            }

    }
}

extension Error {
    func unknowError() -> String {
        return ""//Strings.unknown
    }
}
