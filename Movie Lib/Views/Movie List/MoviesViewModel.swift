//
//  MoviesViewModel.swift
//  Movie Lib
//
//  Created by Eren on 28.08.2021.
//

import Foundation

protocol MoviesViewModelDelegate: AnyObject {
    func moviesDidStartLoading(query: String?)
    func moviesDidFinishLoading(movies: [Movie], query: String?)
    func moviesDidFailLoading(query: String?, error: Error?)
}

class MoviesViewModel {
    
    weak var delegate: MoviesViewModelDelegate?
    
    private(set) var movies: [Movie] = []
    
    private(set) var hasOngoingRequest = false
    
    func movie(for index: Int) -> Movie? {
        
        guard index >= 0, index < movies.count else {
            return nil
        }
        
        return movies[index]
        
    }
    
    func fetchMovies() {
        getMovies("Hey")
    }
    
    func searchMovies(query: String) {
        getMovies(query)
    }
    
}

private extension MoviesViewModel {
    
    func getMovies(_ query: String?) {
        
        guard !hasOngoingRequest else {
            return
        }
        
        hasOngoingRequest = true
        
        delegate?.moviesDidStartLoading(query: query)
        
        MovieAPI.shared.getMovies(query) { response in
            
            self.movies = response.movies ?? []
            
            self.hasOngoingRequest = false
            
            DispatchQueue.main.async {
                self.delegate?.moviesDidFinishLoading(movies: self.movies, query: query)
            }
            
        } _: { error in
            
            print(error?.localizedDescription ?? "?")
            
            DispatchQueue.main.async {
                self.delegate?.moviesDidFailLoading(query: query, error: error)
            }
            
        }
        
    }
    
}
