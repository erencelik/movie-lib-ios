//
//  Date+Extension.swift
//  Movie Lib
//
//  Created by Eren on 28.08.2021.
//

import Foundation

extension Date {
    
    static func formatted(dateString: String, inputFormat: String = "yyyy-MM-dd", outputFormat: String = "MMM dd, yyyy") -> String {
        
        // 2017-11-23
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat

        // Nov 23, 2017
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat

        guard let date = inputFormatter.date(from: dateString) else {
            return dateString
        }
        
        return outputFormatter.string(from: date)
        
    }
    
}
