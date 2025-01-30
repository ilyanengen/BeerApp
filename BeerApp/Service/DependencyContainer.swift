//
//  DependencyContainer.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import Foundation

@Observable
final class DependencyContainer {
    let beerService: BeerServiceProtocol
    let apiManager: APIRequestManagerProtocol
    
    init() {
        let requestBuilder = APIRequestBuilder()
        let networkClient = NetworkClient()
        let apiManager = APIRequestManager(networkClient: networkClient, requestBuilder: requestBuilder)
        self.beerService = BeerService(apiManager: apiManager)
        self.apiManager = apiManager
    }
}
