//
//  Beer.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import Foundation

struct Beer: Decodable {
    let id: Int
    let name: String
    let tagline: String
    let firstBrewed: String
    let description: String
    let image: String
    let abv: Double
    let ibu: Int
    let targetFg: Int
    let targetOg: Int
    let ebc: Int
    let srm: Int
    let ph: Double
    let attenuationLevel: Int
    let volume: Volume
    let boilVolume: Volume
    let method: BrewingMethod
    let ingredients: Ingredients
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: String
}

struct Volume: Decodable {
    let value: Double
    let unit: String
}

struct BrewingMethod: Decodable {
    let mashTemp: [MashTemperature]
    let fermentation: FermentationTemperature
    let twist: String
}

struct MashTemperature: Decodable {
    let temp: Temperature
    let duration: Int
}

struct FermentationTemperature: Decodable {
    let temp: Temperature
}

struct Temperature: Decodable {
    let value: Double
    let unit: String
}

struct Ingredients: Decodable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String
}

struct Malt: Decodable {
    let name: String
    let amount: Amount
}

struct Hop: Decodable {
    let name: String
    let amount: Amount
    let add: String
    let attribute: String
}

struct Amount: Decodable {
    let value: Double
    let unit: String
}
