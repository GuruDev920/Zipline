//
//  Movie.swift
//  Zipline
//
//  Created by Sun on 2021/7/15.
//

import Foundation
import SwiftyJSON

class Movie: Codable {
    var id = Int()
    var adult = Bool()
    var backdrop_path = String()
    var genre_ids = [String]()
    var original_language = String()
    var original_title = String()
    var overview = String()
    var popularity = Double()
    var poster_path = String()
    var release_date = String()
    var title = String()
    var video = Bool()
    var vote_average = Double()
    var vote_count = Int()
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.adult = json["adult"].boolValue
        self.backdrop_path = json["backdrop_path"].stringValue
        for item in json["genre_ids"].arrayValue {
            self.genre_ids.append(item.stringValue)
        }
        self.original_language = json["original_language"].stringValue
        self.original_title = json["original_title"].stringValue
        self.overview = json["overview"].stringValue
        self.popularity = json["popularity"].doubleValue
        self.poster_path = json["poster_path"].stringValue
        self.release_date = json["release_date"].stringValue
        self.title = json["title"].stringValue
        self.video = json["video"].boolValue
        self.vote_average = json["vote_average"].doubleValue
        self.vote_count = json["vote_count"].intValue
    }
}
