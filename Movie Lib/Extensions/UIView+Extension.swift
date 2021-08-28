//
//  UIView+Extension.swift
//  Movie Lib
//
//  Created by Eren on 28.08.2021.
//

import UIKit

extension UIView {
    
    func addGradientBackground(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}
