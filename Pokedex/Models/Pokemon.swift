//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ignacio Muñoz Repetto on 2024-06-19.
//

import Foundation

struct Pokemons: Decodable {
    let count : Int
    let results : [PokemonCard]
}

struct PokemonCard : Identifiable, Decodable {
    var id: String { url }
    let name : String
    let url : String
}

struct Pokemon : Identifiable, Decodable {
    let id: Int
    let name : String
    let base_experience : Int
    let height : Int
    let is_default : Bool
    let order : Int
    let weight : Int
    
    let sprites : Sprites
    
    struct Sprites : Decodable {
        let back_default : String
        let front_default : String
    }
    
    let cries : Cries
    
    struct Cries : Decodable {
        let latest : String
        let legacy : String
    }
    
    let types : [Types]
    
    struct Types : Decodable {
        let slot : Int
        
        let type : PokemonType
        
        struct PokemonType : Decodable {
            let name : String
            let url : String
        }
    }
    

}
