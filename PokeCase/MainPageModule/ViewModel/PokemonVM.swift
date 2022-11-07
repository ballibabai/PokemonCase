//
//  PokemonVM.swift
//  PokeCase
//
//  Created by İbrahim Ballıbaba on 4.11.2022.
//

import Foundation

protocol PokemonViewModelProtocol: AnyObject {
    func getAllPokes(_ poke: [AllPokemons])
}

final class PokemonViewModel {
    weak var pokemonVMDelegate: PokemonViewModelProtocol?
    private let pokeApi = PokeApi()
    
    init(){
        pokeApi.pokeApiDelegate = self
    }
    
    func deneme2(_ nextString: URL){
        pokeApi.deneme(nextString)
    }
    
    func didViewLoad(){
        pokeApi.getAllPoke()
    }
}

extension PokemonViewModel: PokeApiProtocol {
    func getPokemon(_ isSuccess: Bool) {
        if isSuccess{
            let poke = pokeApi.allPokes
            pokemonVMDelegate?.getAllPokes(poke)
            print("SucessVM")
        }else{
            print("Error PokemonViewModel")
        }
    }
}
