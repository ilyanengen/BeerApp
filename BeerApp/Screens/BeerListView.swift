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
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                if viewModel.beers.isEmpty {
                    emptyStateView
                } else {
                    beerGridView
                }
            }
            .background(.backgroundMain)
            .scrollPosition(id: $currentScrollBeerItemId, anchor: .bottomTrailing)
            .onChange(of: currentScrollBeerItemId) { _, newValue in
                if newValue == viewModel.lastFetchedBeerId {
                    Task {
                        await viewModel.fetchMore()
                    }
                }
            }
            .task {
                await viewModel.fetchBeerListItems()
            }
            .navigationTitle("Beer Catalog")
            .searchable(text: $viewModel.searchText, prompt: "Type beer name")
        }
    }
    
    private var beerGridView: some View {
        let columns = [GridItem(.adaptive(minimum: 150), spacing: 16)]
        
        return LazyVGrid(columns: columns, spacing: 16) {
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
    
    private var emptyStateView: some View {
        ContentUnavailableView(label: {
            Label("Oops, no beer today", systemImage: "mug")
        }, description: {
            Text("Information about beer types will appear here")
        }, actions: {
            Button(action: {
                Task {
                    await viewModel.fetchBeerListItems()
                }
            }) {
                Text("Refresh")
            }
        })
        .containerRelativeFrame(.vertical) { length, _ in
            length
        }
    }
}

//#Preview {
//    BeerListView()
//}
