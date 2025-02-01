//
//  BeerListViewModel.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import Foundation

@Observable
final class BeerListViewModel {
    var beerListItems: [Beer] {
        if isSearchInProgress {
            searchResults
        } else {
            beers
        }
    }
    
    private var beers: [Beer] = []
    
    // Search locally
    var searchText: String = "" {
        didSet {
            updateSearchResults()
        }
    }
    var isSearchInProgress: Bool = false
    var searchResults: [Beer] = []
    
    // Pagination
    var lastFetchedBeerId: Int?
    private var page: Int = 1
    private var lastFetchedPage: Int = 1
    
    private let beerService: BeerServiceProtocol
    
    init(beerService: BeerServiceProtocol) {
        self.beerService = beerService
    }
    
    @MainActor
    func fetchMore() async {
        page += 1
        await fetchBeerListItems()
    }
    
    @MainActor
    func fetchBeerListItems() async {
        do {
            let fetchedBeers = try await beerService.getBeers(page: page)
            if fetchedBeers.isEmpty {
                page = lastFetchedPage
            } else {
                beers.appendUniqueItems(contentsOf: fetchedBeers)
                lastFetchedBeerId = beers.last?.id
                lastFetchedPage = page
            }
        } catch {
            print(error.localizedDescription) // TODO: handle error
        }
    }
    
    private func updateSearchResults() {
        if searchText.isEmpty {
            searchResults.removeAll()
        } else {
            let searchText = searchText.lowercased()
            self.searchResults = beers.filter { $0.name.lowercased().contains(searchText) }
        }
    }
}
