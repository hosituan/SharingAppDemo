//
//  RESTAPIService.swift
//  StarCheckIn
//
//  Created by Tuan Si Ho (3406) on 27/11/2022.
//

import Foundation
import Alamofire

struct NotificationData: Codable {
    var title: String?
    var content: String?
    
}
struct FetchNotiRequest: Requestable {
    var path: String = ""
    
    var httpMethod: HTTPMethod = .get
    
    typealias Response = [NotificationData]
    var fullPath: String {
        return "https://seahorse-app-lu4aq.ondigitalocean.app/notiList"
    }
    
}
class RESTAPIService {
    static func fetchNotifcation(completionHandler: @escaping ([NotificationData]?) -> Void) {
        AF.sendRequest(FetchNotiRequest()) { response in
            completionHandler(response.value)
        }
    }
}
