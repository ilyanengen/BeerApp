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
        ScrollView {
            VStack(alignment: .leading, spacing: .zero) {
                mainInfoView
                descriptionView
            }
        }
        .background(.backgroundMain)
        .toolbarBackground(.backgroundMain, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var mainInfoView: some View {
        HStack(spacing: 60) {
            WebImageView(url: beer.imageURL)
                .scaledToFit()
                .frame(height: 274)
                .padding(.leading, 60)
            
            VStack(alignment: .leading, spacing: .zero) {
                Text(beer.name)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.textPrimary)
                    .padding(.bottom, 4)
                
                Text(beer.tagline)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.textSecondary)
                    .padding(.bottom, 16)
                
                if let abv = beer.abv?.formattedValue() {
                    beerInfoLabel(title: "Alcohol content:", value: "\(abv) %")
                }
                
                if let ibu = beer.ibu?.formattedValue() {
                    beerInfoLabel(title: "Bitterness level:", value: ibu)
                }
                
                if let srm = beer.srm?.formattedValue() {
                    beerInfoLabel(title: "Color measurement:", value: srm)
                }
                
                if let ph = beer.ph?.formattedValue() {
                    beerInfoLabel(title: "Acidity level", value: ph)
                }
            }
            .padding(.trailing, 20)
        }
        .padding(.top, 22)
        .padding(.bottom, 32)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func beerInfoLabel(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.textSecondary)
            Text(value)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.textPrimary)
        }
    }
    
    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description")
                .foregroundStyle(.textPrimary)
                .font(.system(size: 18, weight: .bold))
            
            Text(beer.description)
                .foregroundStyle(.textPrimary)
                .font(.system(size: 14, weight: .regular))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(.backgroundItem)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 16)
    }
}

#Preview {
    BeerDetailView(beer: Beer.test)
}
