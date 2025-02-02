//
//  BeerAppTests.swift
//  BeerAppTests
//
//  Created by Илья Билтуев on 30.01.2025.
//

import XCTest
@testable import BeerApp

final class BeerAppTests: XCTestCase {

    @MainActor
    func testInitialFetchData() async throws {
        let mockBeerService = MockBeerService()
        let sut = BeerListViewModel(beerService: mockBeerService)
        sut.isSearchInProgress = false
        await sut.fetchInitialData()
        XCTAssertEqual(sut.beerListItems, [Beer.test, Beer.test1])
    }
    
    @MainActor
    func testInitialFetchError() async throws {
        let mockBeerService = MockBeerService()
        mockBeerService.shouldReturnError = true
        let sut = BeerListViewModel(beerService: mockBeerService)
        sut.isSearchInProgress = false
        await sut.fetchInitialData()
        XCTAssertEqual(sut.beerListItems, [])
        XCTAssertFalse(sut.errorMessage.isEmpty)
    }
    
    // Add search error test
}
