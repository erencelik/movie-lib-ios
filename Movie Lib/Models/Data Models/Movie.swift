//
//  Moview.swift
//  Movie Lib
//
//  Created by Eren on 28.08.2021.
//

import Foundation
import ObjectMapper

final class Movie: Mappable {

    var id: Int?
    var title: String?
    var coverPath: String?
    var releaseDate: String?
    var watched: Bool = false
    
    var formattedReleaseDate: String? {
        
        guard let releaseDate = self.releaseDate else {
            return nil
        }
        
        return Date.formatted(dateString: releaseDate)
        
    }
    
    var coverUrl: URL? {
        
        guard let coverPath = self.coverPath else {
            return nil
        }
        
        return URL(string: "https://image.tmdb.org/t/p/w500\(coverPath)")
        
    }
    
    var movieDetailUrl: URL? {
        
        guard let id = self.id else {
            return nil
        }
        
        return URL(string: "https://www.themoviedb.org/movie/\(id)")
        
    }
    
    init() {}
    
    init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        coverPath <- map["poster_path"]
        releaseDate <- map["release_date"]
    }
    
}
