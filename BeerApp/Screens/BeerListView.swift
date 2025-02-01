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
                // TODO: handle states
                if viewModel.beerListItems.isEmpty {
                    emptyStateView
                } else {
                    beerGridView
                }
            }
            .background(.backgroundMain)
            .navigationTitle("Beer Catalog")
            .scrollPosition(id: $currentScrollBeerItemId, anchor: .bottomTrailing)
            .searchable(text: $viewModel.searchText, isPresented: $viewModel.isSearchInProgress, prompt: "Type beer name")
            .task {
                await viewModel.fetchBeerListItems()
            }
            .onChange(of: currentScrollBeerItemId) { _, newValue in
                guard !viewModel.isSearchInProgress else { return }
                if newValue == viewModel.lastFetchedBeerId {
                    Task {
                        await viewModel.fetchMore()
                    }
                }
            }
        }
    }
    
    private var beerGridView: some View {
        let columns = [GridItem(.adaptive(minimum: 150), spacing: 16)]
        
        return LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.beerListItems) { beer in
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
