//
//  WebImageView.swift
//  BeerApp
//
//  Created by Илья Билтуев on 01.02.2025.
//

import SDWebImageSwiftUI
import SwiftUI

struct WebImageView: View {
    var url: URL?
    
    var body: some View {
        WebImage(url: url)
            .resizable()
    }
}

#Preview {
    WebImageView(url: URL(string: "https://punkapi.online/v3/images/003.png")!)
        .scaledToFit()
        .frame(width: 100, height: 180)
        .background(.gray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
}
