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
    @State private var showErrorAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                if viewModel.beerListItems.isEmpty {
                    if viewModel.isInitialLoading {
                        loadingIndicator
                    } else {
                        emptyStateView
                    }
                } else {
                    beerGridView
                }
            }
            .background(.backgroundMain)
            .navigationTitle("Beer Catalog")
            .scrollPosition(id: $currentScrollBeerItemId, anchor: .bottomTrailing)
            .searchable(text: $viewModel.searchText, isPresented: $viewModel.isSearchInProgress, prompt: "Type beer name")
            .task {
                await viewModel.initialLoad()
            }
            .onChange(of: currentScrollBeerItemId) { _, newValue in
                guard !viewModel.isSearchInProgress else { return }
                if newValue == viewModel.lastFetchedBeerId {
                    Task {
                        await viewModel.fetchMore()
                    }
                }
            }
            .onChange(of: viewModel.errorMessage) { _, newValue in
                if !newValue.isEmpty {
                    showErrorAlert = true
                }
            }
            .alert("Error", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) {
                    showErrorAlert = false
                }
            } message: {
                Text(viewModel.errorMessage)
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
    
    @ViewBuilder
    private var emptyStateView: some View {
        if viewModel.isSearchInProgress {
            ContentUnavailableView(label: {
                Label("No search results", systemImage: "magnifyingglass")
            }, description: {
                Text("Try other terms")
            })
            .containerRelativeFrame(.vertical) { length, _ in
                length
            }
            
        } else {
            
            ContentUnavailableView(label: {
                Label("Oops, no beer today", systemImage: "mug")
            }, description: {
                Text("Information about beer types will appear here")
            }, actions: {
                Button(action: {
                    Task {
                        await viewModel.initialLoad()
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
    
    private var loadingIndicator: some View {
        ZStack {
            Color.black.opacity(.zero)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(1.5)
                .containerRelativeFrame(.vertical) { length, _ in
                    length / 1.2
                }
        }
    }
}

//#Preview {
//    BeerListView()
//}
