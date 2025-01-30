//
//  BeerListView.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import SwiftUI

struct BeerListView: View {
    @State var viewModel: BeerListViewModel
    
    var body: some View {
        Text("BeerListView")
            .task {
                await viewModel.fetchBeerListItems()
            }
    }
}

//#Preview {
//    BeerListView()
//}
