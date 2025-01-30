//
//  APIRequestManager.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import Foundation

protocol APIRequestManagerProtocol {
    func perform<T: Decodable>(_ request: APIRequest) async throws -> T
    func performNoResultRequest(_ request: APIRequest) async throws
}

extension APIRequestManagerProtocol {
    func perform<T: Decodable>(_ request: APIRequest) async throws -> T {
        try await perform(request)
    }
}

final class APIRequestManager: APIRequestManagerProtocol {
    private let networkClient: NetworkClientProtocol
    private let requestBuilder: APIRequestBuilderProtocol
    
    init(networkClient: NetworkClientProtocol, requestBuilder: APIRequestBuilderProtocol) {
        self.networkClient = networkClient
        self.requestBuilder = requestBuilder
    }
    
    func perform<T: Decodable>(_ request: APIRequest) async throws -> T {
        let urlRequest = try requestBuilder.createRequest(with: request)
        let (data, response) = try await networkClient.load(using: urlRequest)
        return try handleResponse(data: data, response: response)
    }
    
    func performNoResultRequest(_ request: APIRequest) async throws {
        let urlRequest = try requestBuilder.createRequest(with: request)
        let (_, response) = try await networkClient.load(using: urlRequest)
        let final = try validateNetworkResponse(response)
        try validateResponseCode(final)
    }
    
    private func handleResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        print("\n===> APIRequestManager.handleResponse. \ndata: \(String(describing: String(data: data, encoding: .utf8))), \nresponse: \(response)")
        let response = try validateNetworkResponse(response)
        try validateResponseCode(response)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(T.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: \(context.debugDescription)")
            throw APIError.undefinedError(text: "Data corrupted: \(context.debugDescription)")
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found: \(context.debugDescription)")
            print("codingPath:", context.codingPath)
            throw APIError.undefinedError(text: "Key '\(key)' not found: \(context.debugDescription)")
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found: \(context.debugDescription)")
            print("codingPath:", context.codingPath)
            throw APIError.undefinedError(text: "Value '\(value)' not found: \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch: \(context.debugDescription)")
            print("codingPath:", context.codingPath)
            throw APIError.undefinedError(text: "Type '\(type)' mismatch: \(context.debugDescription)")
        } catch {
            print("Error: \(error.localizedDescription)")
            throw APIError.decodeError(error: error)
        }
    }
    
    private func validateNetworkResponse(_ response: URLResponse) throws -> HTTPURLResponse {
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidHTTPResponse
        }
        return response
    }
    
    private func validateResponseCode(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200...299:
            break
        case 400...499:
            throw APIError.clientError(statusCode: response.statusCode)
        default:
            throw APIError.serverError(statusCode: response.statusCode)
        }
    }
}

enum APIError: Error {
    case undefinedError(text: String)
    case serverError(statusCode: Int)
    case clientError(statusCode: Int)
    case decodeError(error: Error)
    
    var errorDescription: String {
        switch self {
        case .undefinedError(let text):
            return "UndefinedError: \(text)"
        case .serverError(let statusCode):
            return "ServerError: \(statusCode)"
        case .clientError(let statusCode):
            return "ClientError: \(statusCode)"
        case .decodeError(let error):
            return "DecodeError: \(error.localizedDescription)"
        }
    }
}
