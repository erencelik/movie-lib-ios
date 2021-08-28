//
//  MoviesResponseModel.swift
//  Movie Lib
//
//  Created by Eren on 28.08.2021.
//

import ObjectMapper

struct MoviesResponseModel: Mappable {
    
    var movies: [Movie]?
    
    var page: Int?
    
    var totalResults: Int?
    
    var totalPages: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        page <- map["page"]
        movies <- map["results"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
    }
    
}
