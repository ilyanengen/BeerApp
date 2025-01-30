//
//  BeerService.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import Foundation

protocol BeerServiceProtocol {
    func getBeers() async throws -> [Beer]
    func getBeer(id: String) async throws -> Beer?
}

final class BeerService: BeerServiceProtocol {
    private let apiManager: APIRequestManagerProtocol
    
    init(apiManager: APIRequestManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func getBeers() async throws -> [Beer] {
        []
    }
    
    func getBeer(id: String) async throws -> Beer? {
        return nil
    }
}
