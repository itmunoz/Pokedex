//
//  ContentView.swift
//  Pokedex
//
//  Created by Ignacio Muñoz Repetto on 2024-06-18.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: Network
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Pokedex")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading) {
                    ForEach(network.pokemons) { pokemon in
                        NavigationLink(destination: PokemonDetailView(url: pokemon.url)) {
                            PokemonStack(pokemon: pokemon)
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                network.getPokemons()
            }
        }
    }
}

struct PokemonStack: View {
    var pokemon: PokemonCard

    var body: some View {
        HStack(alignment:.top) {
            VStack(alignment: .leading) {
                Text(pokemon.name.capitalized)
                    .bold()
            }
        }
        .frame(width: 300, alignment: .leading)
        .padding()
        .background(Color(#colorLiteral(red: 0.6667672396, green: 0.7527905703, blue: 1, alpha: 0.2662717301)))
        .cornerRadius(20)
    }
}

struct PokemonDetailView: View {
    @EnvironmentObject var network: Network
    var url: String

    var pokemon: Pokemon? {
        network.pokemon
    }

    var body: some View {
        VStack {
            Text((pokemon?.name.capitalized ?? "MissingNo"))
                .font(.title)
                .bold()
            if let imageUrl = URL(string: pokemon?.sprites.front_default ?? "") {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 400, height: 400)
            } else {
                Text("No image available")
            }
        }
        .onAppear {
            network.getPokemon(pokemonUrl: url)
        }
    }
}

#Preview {
    ContentView().environmentObject(Network())
}
