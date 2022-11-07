//
//  GetPokemonViewModel.swift
//  PokeCase
//
//  Created by İbrahim Ballıbaba on 5.11.2022.
//

import Foundation

protocol GetPokemonVMProtocol: AnyObject {
    func getPokeArray(_ poke: Pokemon)
    func stringUrl(_ stringUrl: [String])
}

final class GetPokemonViewModel {
    weak var getPokemonVMDelegate: GetPokemonVMProtocol?
    private let getPokeValue = GetPokemonValue()
    
    init(){
        getPokeValue.getPokemonDelegate = self
    }
    
    func didViewLoad(_ urlString: String){
        getPokeValue.getVersionsPoke(urlString)
    }
}

extension GetPokemonViewModel: PokeDetailProtocol {
    func getJustPokemon(_ isSuccess: Bool) {
        if isSuccess{
            let stringPoke = getPokeValue.holdPhotos()
            let poke = getPokeValue.pokemon!
            getPokemonVMDelegate?.getPokeArray(poke)
            getPokemonVMDelegate?.stringUrl(stringPoke)
            print("success detailVM")
        }else{
            print("error detailVM")
        }
    }
}
