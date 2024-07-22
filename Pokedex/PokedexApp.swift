//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Ignacio Muñoz Repetto on 2024-06-18.
//

import SwiftUI

@main
struct PokedexApp: App {
    var network = Network()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(network)
        }
    }
}
