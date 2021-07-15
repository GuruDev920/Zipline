//
//  ApiRequest.swift
//  Zipline
//
//  Created by Sun on 2021/7/15.
//

import Foundation
import Alamofire
import SwiftyJSON
import Reachability

class ApiRequest: NSObject {
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    
    class func requestGet(URL: String, params: [String: String], completion:@escaping (_ result: JSON?, _ error: String?)->Void) {
        let reachable = try! Reachability()
        if reachable.connection != .unavailable {
            let urlComp = NSURLComponents(string: URL)
            var items = [URLQueryItem]()
            for (key,value) in params {
                items.append(URLQueryItem(name: key, value: value))
            }
            items = items.filter{!$0.name.isEmpty}
            if !items.isEmpty {
                urlComp!.queryItems = items
            }
            
            let session = URLSession.shared
            var request = URLRequest(url: urlComp!.url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 120)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(ShareData.api_key)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            let httpTask = session.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if data != nil {
                    guard let result = try? JSON(data: data!) else {
                        completion(nil, "Error format data")
                        return
                    }
                    completion(result, nil)
                } else {
                    completion(nil, "Error data.")
                }
            }
                
            httpTask.resume()
            
        } else {
            completion(nil, "Network not found")
        }
    }
}
