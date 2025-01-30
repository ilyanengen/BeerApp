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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
