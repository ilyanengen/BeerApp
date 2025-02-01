//
//  BeerListView.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import SwiftUI

struct BeerListView: View {
    @State var viewModel: BeerListViewModel
    @State private var currentScrollBeerItemId: Int?
    
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.beers) { beer in
                        NavigationLink {
                            BeerDetailView(beer: beer)
                        } label: {
                            BeerListItemView(beer: beer)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .scrollTargetLayout()
            }
            .scrollPosition(id: $currentScrollBeerItemId, anchor: .bottomTrailing)
            .onChange(of: currentScrollBeerItemId) { _, newValue in
                if newValue == viewModel.lastFetchedBeerId {
                    print("FETCH NEXT PAGE")
                }
            }
            .task {
                await viewModel.fetchBeerListItems()
            }
        }

    }
}

//#Preview {
//    BeerListView()
//}
