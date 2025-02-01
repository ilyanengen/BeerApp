//
//  Beer.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import Foundation

struct Beer: Decodable, Identifiable {
    let id: Int
    let name: String
    let tagline: String
    let firstBrewed: String
    let description: String
    let image: String
    let abv: Double?
    let ibu: Double?
    let targetFg: Double?
    let targetOg: Double?
    let ebc: Double?
    let srm: Double?
    let ph: Double?
    let attenuationLevel: Double?
    let volume: Volume?
    let boilVolume: Volume?
    let method: BrewingMethod?
    let ingredients: Ingredients?
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: String
}

struct Volume: Decodable {
    let value: Double?
    let unit: String
}

struct BrewingMethod: Decodable {
    let mashTemp: [MashTemperature]
    let fermentation: FermentationTemperature
    let twist: String?
}

struct MashTemperature: Decodable {
    let temp: Temperature
    let duration: Int?
}

struct FermentationTemperature: Decodable {
    let temp: Temperature
}

struct Temperature: Decodable {
    let value: Double?
    let unit: String
}

struct Ingredients: Decodable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String?
}

struct Malt: Decodable {
    let name: String
    let amount: Amount
}

struct Hop: Decodable {
    let name: String
    let amount: Amount
    let add: String
    let attribute: String?
}

struct Amount: Decodable {
    let value: Double
    let unit: String
}

extension Beer {
    static let test = Beer(id: 123, name: "Zhigulevskoye", tagline: "Legendary beer from Samara", firstBrewed: "1881", description: "Zhigulevskoye is a brand of Russian beer. The original brewery was founded in Samara in 1881 by Austrian entrepreneur Alfred von Vacano. The original brand was named Viennese Beer, but, according to legend, in 1934 it was renamed Zhigulevskoye Beer to get rid of its bourgeois name. During the Soviet era, at times it was virtually the only beer brand that could be found anywhere in the country. At the peak of its popularity it was made in more than 700 breweries around the country, and it practically became a generic name for beer. Production was regulated by a GOST standard since 1938. Zhigulevskoye had to contain no less than 2.8% alcohol by mass and was allowed to have up to 15% of adjuncts. Since the disintegration of the Soviet Union, beer under the Zhigulyovskoye brand has been produced by multiple breweries in several former Soviet countries. Attempts to register it as a trademark in 2000 were unsuccessful. On May 17, the Appeals Chamber of Rospatent accepted all the objections of the Ryazan JSC Russian Brewing Company and canceled the registration of the Zhigulevskoye trademark.", image: "022.png", abv: 1.0, ibu: 2.0, targetFg: 2.5, targetOg: 2.2, ebc: 3.3, srm: 5.1, ph: 1, attenuationLevel: 1, volume: nil, boilVolume: nil, method: nil, ingredients: nil, foodPairing: [], brewersTips: "Hardcore", contributedBy: "Alfred von Vacano")
}
