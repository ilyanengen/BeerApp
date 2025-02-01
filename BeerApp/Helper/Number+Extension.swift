//
//  Number+Extension.swift
//  BeerApp
//
//  Created by Илья Билтуев on 01.02.2025.
//

import Foundation

extension Formatter {
    static let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Double {
    func formattedValue() -> String {
        // If the value is a whole number, return it without decimals
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(self))
        }
        
        // Otherwise, format with up to 2 decimal places
        return Formatter.decimalFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
