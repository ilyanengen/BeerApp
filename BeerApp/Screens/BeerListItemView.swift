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
        VStack(spacing: 16) {
            WebImageView(url: beer.imageURL)
                .scaledToFit()
            
            Text(beer.name)
                .font(.system(size: 16))
                .multilineTextAlignment(.center)
                .lineLimit(2, reservesSpace: true)
                .foregroundStyle(.black)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity, maxHeight: 230)
        .background(.backgroundItem)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    VStack {
        BeerListItemView(beer: Beer.test)
            .frame(width: 160)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray)
}
