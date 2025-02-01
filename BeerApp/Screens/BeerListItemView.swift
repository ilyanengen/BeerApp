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
        VStack(spacing: 10) {
            WebImageView(url: beer.imageURL)
                .scaledToFit()
                .padding(.top, 10)
                .padding(.horizontal, 10)
            
            Text(beer.name)
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: 180)
        .background(.gray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    BeerListItemView(beer: Beer.test)
}
