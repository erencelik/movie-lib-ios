//
//  MoviesViewController.swift
//  Movie Lib
//
//  Created by Eren on 28.08.2021.
//

import UIKit

final class MoviesViewController: UIViewController {

    @IBOutlet private weak var movieSearchBar: UISearchBar!
    @IBOutlet private weak var moviesCollectionView: UICollectionView!
    @IBOutlet private weak var moviesEmptyView: UIView!
    @IBOutlet private weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    private let viewModel = MoviesViewModel()
    
    private let collectionViewPadding: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

private extension MoviesViewController {
    
    func setup() {
        viewModel.delegate = self
        viewModel.fetchMovies()
    }
    
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movie-cell", for: indexPath)
        
        if let cell = cell as? MovieCollectionViewCell {
            cell.movie = viewModel.movie(for: indexPath.item)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let movieDetailUrl = viewModel.movie(for: indexPath.item)?.movieDetailUrl else {
            return
        }
        
        if UIApplication.shared.canOpenURL(movieDetailUrl) {
            UIApplication.shared.open(movieDetailUrl)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionViewPadding, left: collectionViewPadding, bottom: collectionViewPadding, right: collectionViewPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - (collectionViewPadding * 3)) / 2
        return CGSize(width: width, height: width * 1.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewPadding
    }
    
}

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchMovies(searchBar)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchMovies(searchBar)
    }
    
    private func searchMovies(_ searchBar: UISearchBar) {
        
        guard let query = searchBar.text, !query.isEmpty else {
            return
        }
        
        viewModel.searchMovies(query: query)
        
    }
    
}

extension MoviesViewController: MoviesViewModelDelegate {
    
    func moviesDidStartLoading(query: String?) {
        loadingActivityIndicator.startAnimating()
        moviesEmptyView.isHidden = true
    }
    
    func moviesDidFinishLoading(movies: [Movie], query: String?) {
        
        loadingActivityIndicator.stopAnimating()
        moviesCollectionView.reloadData()
        
        moviesEmptyView.isHidden = !movies.isEmpty
        moviesCollectionView.isHidden = movies.isEmpty
        
    }
    
    func moviesDidFailLoading(query: String?, error: Error?) {
        loadingActivityIndicator.stopAnimating()
    }
    
}

