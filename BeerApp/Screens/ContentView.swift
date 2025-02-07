//
//  ContentView.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(DependencyContainer.self) private var dependencyContainer
    
    var body: some View {
        BeerListView(viewModel: BeerListViewModel(beerService: dependencyContainer.beerService))
    }
}

#Preview {
    ContentView()
        .environment(DependencyContainer())
}
