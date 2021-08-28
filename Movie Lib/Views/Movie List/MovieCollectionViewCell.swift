//
//  MovieCollectionViewCell.swift
//  Movie Lib
//
//  Created by Eren on 28.08.2021.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var watchedButton: UIButton!
    @IBOutlet private weak var topShadowGradient: UIView!
    
    private let shadowGradientColors: [UIColor] = [
        UIColor.black,
        UIColor.black.withAlphaComponent(0)
    ]
    
    var movie: Movie? {
        didSet {
            reload()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.kf.cancelDownloadTask()
    }
    
}

private extension MovieCollectionViewCell {
    
    func setup() {
        self.topShadowGradient.addGradientBackground(colors: shadowGradientColors,
                                                     startPoint: CGPoint(x: 0.5, y: 0),
                                                     endPoint: CGPoint(x: 0.5, y: 1))
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.label.withAlphaComponent(0.25).cgColor
    }
    
    func reload() {
        
        guard let movie = self.movie else {
            return
        }
        
        coverImageView.kf.setImage(with: movie.coverUrl)
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.formattedReleaseDate
        watchedButton.setTitle(movie.watched ? "Watched" : "Not watched", for: .normal)
        watchedButton.backgroundColor = movie.watched ? UIColor.green : UIColor.red
        watchedButton.setTitleColor(movie.watched ? UIColor.black : UIColor.white, for: .normal)
        
    }
    
    @IBAction func watchedButtonAction(_ sender: UIButton) {
        movie?.watched.toggle()
        reload()
    }
    
}
