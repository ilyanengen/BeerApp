//
//  BeerListItemView.swift
//  BeerApp
//
//  Created by Илья Билтуев on 01.02.2025.
//

import SwiftUI

struct BeerListItemView: View {
    var beer: Beer
    
    var body: some View {
        Text(beer.name)
            .frame(maxWidth: .infinity, minHeight: 200)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    BeerListItemView(beer: Beer.test)
}
