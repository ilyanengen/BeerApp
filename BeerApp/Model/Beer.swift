//
//  Beer.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import Foundation

struct Beer: Decodable, Identifiable, Equatable {
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
    
    static func == (lhs: Beer, rhs: Beer) -> Bool {
        lhs.id == rhs.id
    }
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
    var imageURL: URL? {
        URL(string: Constants.API.host + "/images/" + image)
    }
}

extension Beer {
    static let test = Beer(
        id: 111,
        name: "Zhigulevskoye",
        tagline: "Legendary beer from Samara",
        firstBrewed: "1881",
        description: "Zhigulevskoye is a brand of Russian beer. The original brewery was founded in Samara in 1881 by Austrian entrepreneur Alfred von Vacano.",
        image: "022.png",
        abv: 1.0,
        ibu: 2.0,
        targetFg: 2.5,
        targetOg: 2.2,
        ebc: 3.3,
        srm: 5.1,
        ph: 1,
        attenuationLevel: 1,
        volume: nil,
        boilVolume: nil,
        method: nil,
        ingredients: nil,
        foodPairing: [],
        brewersTips: "Hardcore",
        contributedBy: "Alfred von Vacano"
    )
    
    static let test1 = Beer(
        id: 222,
        name: "Baltika",
        tagline: "Legendary beer from St. Petersburg",
        firstBrewed: "1978",
        description: "Baltika Brewery is Europe's second-largest brewing company and dominates the Russian beer market with a 38% share. The company operates from its headquarters in St. Petersburg.",
        image: "023.png",
        abv: 2.0,
        ibu: 3.0,
        targetFg: 4.5,
        targetOg: 5.2,
        ebc: 1.3,
        srm: 2.1,
        ph: 2,
        attenuationLevel: 3,
        volume: nil,
        boilVolume: nil,
        method: nil,
        ingredients: nil,
        foodPairing: [],
        brewersTips: "Drink cold",
        contributedBy: "Taimuraz Bolloyev"
    )
    
    static let test2 = Beer(
        id: 333,
        name: "Carslberg",
        tagline: "Probably the best beer in the world.",
        firstBrewed: "1847",
        description: "Carlsberg is a renowned Danish lager beer founded by J.C. Jacobsen in 1847. It originated from Jacobsen's quest to brew high-quality lager using pure yeast, which he famously sourced from Bavaria. Over the years, Carlsberg has become a symbol of Danish brewing excellence, known for its commitment to quality and innovation. The brewery also established the Carlsberg Foundation, promoting scientific research and cultural initiatives. Today, Carlsberg continues to be enjoyed worldwide, with a legacy of over 175 years in brewing history.",
        image: "024.png",
        abv: 2.0,
        ibu: 3.0,
        targetFg: 4.5,
        targetOg: 5.2,
        ebc: 1.3,
        srm: 2.1,
        ph: 2,
        attenuationLevel: 3,
        volume: nil,
        boilVolume: nil,
        method: nil,
        ingredients: nil,
        foodPairing: [],
        brewersTips: "Drink cold",
        contributedBy: "Max Powell"
    )
    
    static let test3 = Beer(
        id: 444,
        name: "Beck's",
        tagline: "Beck's. Life Beckons",
        firstBrewed: "1873",
        description: "Beck's is a German pilsner beer brewed by Brauerei Beck & Co., located in Bremen, Germany. Established in 1873, it is known for its crisp, refreshing taste and high-quality ingredients, following the four essential brewing steps: barley, water, hops, and yeast. Beck's has gained international recognition and is enjoyed worldwide, often associated with its unmistakable German craftsmanship. The beer is marketed with a focus on its heritage and quality, appealing to consumers who appreciate a classic pilsner experience.",
        image: "023.png",
        abv: 2.0,
        ibu: 3.0,
        targetFg: 4.5,
        targetOg: 5.2,
        ebc: 1.3,
        srm: 2.1,
        ph: 2,
        attenuationLevel: 3,
        volume: nil,
        boilVolume: nil,
        method: nil,
        ingredients: nil,
        foodPairing: [],
        brewersTips: "Drink cold",
        contributedBy: "Jordan Henderson"
    )
}
