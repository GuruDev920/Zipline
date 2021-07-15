//
//  Services.swift
//  Zipline
//
//  Created by Sun on 2021/7/15.
//

import Foundation
import SwiftyJSON

class Services: NSObject {
    static func getUrl() -> String {
        let baseURL = "https://api.themoviedb.org/3/movie"
        return baseURL
    }
    
    class func get_top_movies(page: Int, completion : @escaping (_ result: JSON?, _ error: String?)->Void ) {
        let url = "\(getUrl())/top_rated"
        let language = Locale.current.languageCode?.lowercased() ?? "en"
        let region = Locale.current.regionCode?.uppercased() ?? "US"
        let params = ["api_key": ShareData.api_key, "language": language, "region": region, "page": "\(page)"] as [String : String]
        ApiRequest.requestGet(URL: url, params: params) {(result, error) in
            completion(result, error)
        }
    }
}
