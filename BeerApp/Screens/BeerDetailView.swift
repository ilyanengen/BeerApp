//
//  BeerDetailView.swift
//  BeerApp
//
//  Created by Илья Билтуев on 01.02.2025.
//

import SwiftUI

struct BeerDetailView: View {
    var beer: Beer
    
    var body: some View {
        Text("BeerDetailView.\nBeer: \(beer.name)")
    }
}

#Preview {
    BeerDetailView(beer: Beer.test)
}
