//
//  BeerListViewModel.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import Foundation

@Observable
final class BeerListViewModel {
    private let beerService: BeerServiceProtocol
    
    init(beerService: BeerServiceProtocol) {
        self.beerService = beerService
    }
    
    func fetchBeerListItems() async {
        do {
            let beers = try await beerService.getBeers(page: 1)
            print("BEERS: \(beers)")
        } catch {
            print(error.localizedDescription)
        }
    }
}
