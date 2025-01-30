//
//  APIRequest.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import Foundation

protocol APIRequest {
    var path: String { get }
    var method: APIRequestMethod { get }
    var headers: [String: String]? { get }
    var bodyParams: Codable? { get }
    var urlParams: [String: Any]? { get }
}

enum APIRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
