//
//  Array+Extension.swift
//  BeerApp
//
//  Created by Илья Билтуев on 01.02.2025.
//

import Foundation

extension Array where Element: Identifiable {
    mutating func appendUniqueItems<S>(contentsOf newElements: S) where Element == S.Element, S : Sequence {
        for newElement in newElements {
            if !self.contains(where: { $0.id == newElement.id }) {
                self.append(newElement)
            }
        }
    }
}
