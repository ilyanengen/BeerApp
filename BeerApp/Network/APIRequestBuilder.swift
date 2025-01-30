//
//  APIRequestBuilder.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import Foundation

protocol APIRequestBuilderProtocol {
    func createRequest(with apiRequest: APIRequest) throws -> URLRequest
}

final class APIRequestBuilder: APIRequestBuilderProtocol {
    private let host = URL(string: Constants.API.host)!

    func createRequest(with apiRequest: APIRequest) throws -> URLRequest {
        let url = host.appendingPathComponent(apiRequest.path)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRequest.method.rawValue
        urlRequest.allHTTPHeaderFields = apiRequest.headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw URLError(.badURL)
        }
        components.queryItems = apiRequest.urlParams?.compactMap {
            URLQueryItem(name: $0, value: "\($1)")
        }
        urlRequest.url = components.url
        
        if let bodyParams = apiRequest.bodyParams {
            urlRequest.httpBody = try JSONEncoder().encode(bodyParams)
        }
        
        return urlRequest
    }
}
