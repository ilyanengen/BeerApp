//
//  BeerService.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import Foundation

protocol BeerServiceProtocol {
    func getBeers(page: Int) async throws -> [Beer]
    func getBeer(id: Int) async throws -> Beer?
}

final class BeerService: BeerServiceProtocol {
    private let apiManager: APIRequestManagerProtocol
    
    init(apiManager: APIRequestManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func getBeers(page: Int) async throws -> [Beer] {
        let beers: [Beer] = try await apiManager.perform(GetBeersPageRequest(page: page))
        return beers
    }
    
    func getBeer(id: Int) async throws -> Beer? {
        try await apiManager.perform(GetBeerRequest(id: id))
    }
}

struct GetBeersPageRequest: APIRequest {
    let bodyParams: (any Codable)? = nil
    let path: String = "beers"
    let method: APIRequestMethod = .get
    let headers: [String : String]? = nil
    let urlParams: [String : Any]?
    
    init(page: Int) {
        self.urlParams = ["page": page]
    }
}

struct GetBeerRequest: APIRequest {
    let bodyParams: (any Codable)? = nil
    let path: String
    let method: APIRequestMethod = .get
    let headers: [String : String]? = nil
    let urlParams: [String : Any]? = nil
    
    init(id: Int) {
        self.path = "beers/\(id)"
    }
}

struct GetBeerImageRequest: APIRequest {
    let bodyParams: (any Codable)? = nil
    let path: String
    let method: APIRequestMethod = .get
    let headers: [String : String]? = nil
    let urlParams: [String : Any]? = nil
    
    init(id: Int) {
        self.path = String(format: "images/%03d.png", id)
    }
}
