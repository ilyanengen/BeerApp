//
//  NetworkClient.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidHTTPResponse
    case networkFailure(error: Error)
}

protocol NetworkClientProtocol {
    func load(using request: URLRequest) async throws -> (Data, URLResponse)
}

final class NetworkClient: NetworkClientProtocol {
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func load(using request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await urlSession.data(for: request)
        } catch {
            throw NetworkError.networkFailure(error: error)
        }
    }
}
