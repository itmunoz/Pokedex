//
//  Network.swift
//  Pokedex
//
//  Created by Ignacio Muñoz Repetto on 2024-06-19.
//

import SwiftUI

class Network: ObservableObject {
    @Published var pokemon: Pokemon?
    @Published var pokemons: [PokemonCard] = []
    
    func getPokemon(pokemonUrl: String) {
        guard let url = URL(string: pokemonUrl) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }

            DispatchQueue.main.async {
                do {
                    let decodedPokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    self.pokemon = decodedPokemon
                } catch let error {
                    print("Error decoding: ", error)
                }
            }
        }
        dataTask.resume()
    }
    
    
    func getPokemons() {
       guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=100000") else { fatalError("Missing URL") }

       let urlRequest = URLRequest(url: url)

       let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
           if let error = error {
               print("Request error: ", error)
               return
           }

           guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
           guard let data = data else { return }

           DispatchQueue.main.async {
               do {
                   let response = try JSONDecoder().decode(Pokemons.self, from: data)
                   self.pokemons = response.results
               } catch let error {
                   print("Error decoding: ", error)
               }
           }
       }
       
       dataTask.resume()
   }
}
