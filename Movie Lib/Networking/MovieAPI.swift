//
//  MovieAPI.swift
//  Movie Lib
//
//  Created by Eren on 28.08.2021.
//

import Foundation

private let BASE = "https://api.themoviedb.org/3"

private let API_KEY = "84bbdb74695eebaca6977ab9ee54593e"

private let LANGUAGE = "en-US"

final class MovieAPI {
    
    private enum Endpoint: String {
        
        //https://api.themoviedb.org/3/search/movie?api_key=<<api_key>>&language=en-US&page=1&include_adult=false
        
        case searchMovie = "/search/movie"
        
        var url: URL { URL(string: BASE + self.rawValue)! }
        
    }
    
    static let shared = MovieAPI()
    
    private init() {}
    
    func getMovies(_ query: String?, page: Int = 1, includeAdult: Bool = false, _ completion: @escaping MovieResponseClosure, _ failure: @escaping NetworkErrorClosure) {
        
        let url = MovieAPI.Endpoint.searchMovie.url
        
        var parameters: [String: Any] = requiredParameters()

        parameters["query"] = query ?? ""
        parameters["page"] = page
        parameters["include_adult"] = includeAdult
        
        NetworkManager.shared.request(url, parameters: parameters, responseType: MoviesResponseModel.self, completion, failure)
        
    }
    
}

typealias NetworkErrorClosure = (Error?) -> ()
typealias MovieResponseClosure = (MoviesResponseModel) -> ()

private extension MovieAPI {
    
    func requiredParameters() -> [String: Any] {
        return [
            "api_key": API_KEY,
            "language": LANGUAGE
        ]
    }
    
}
