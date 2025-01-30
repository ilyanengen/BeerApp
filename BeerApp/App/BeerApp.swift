//
//  BeerAppApp.swift
//  BeerApp
//
//  Created by Илья Билтуев on 30.01.2025.
//

import SwiftUI

@main
struct BeerApp: App {
    @State private var dependencyContainer = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dependencyContainer)
        }
    }
}
