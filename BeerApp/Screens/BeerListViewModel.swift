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
    
    var isInitialLoading: Bool = false
    
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
    
    var errorMessage: String = ""
    
    private let beerService: BeerServiceProtocol
    
    init(beerService: BeerServiceProtocol) {
        self.beerService = beerService
    }
    
    @MainActor
    func initialLoad() async {
        do {
            isInitialLoading = true
            errorMessage = ""
            let fetchedBeers = try await beerService.getBeers(page: page)
            isInitialLoading = false
            if !fetchedBeers.isEmpty {
                beers = fetchedBeers
                lastFetchedBeerId = beers.last?.id
                lastFetchedPage = page
            }
        } catch {
            isInitialLoading = false
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
    }
    
    @MainActor
    func fetchMore() async {
        do {
            page += 1
            errorMessage = ""
            let fetchedBeers = try await beerService.getBeers(page: page)
            if fetchedBeers.isEmpty {
                page = lastFetchedPage
            } else {
                beers.appendUniqueItems(contentsOf: fetchedBeers)
                lastFetchedBeerId = beers.last?.id
                lastFetchedPage = page
            }
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
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
