//
//  PokeResult.swift
//  PokeCase
//
//  Created by İbrahim Ballıbaba on 5.11.2022.
//

import Foundation

struct Pokemons: Decodable{
    let count: Int
    let next: String
    let results: [AllPokemons]
}

struct AllPokemons: Decodable{
    var name: String
    var url: String
}
