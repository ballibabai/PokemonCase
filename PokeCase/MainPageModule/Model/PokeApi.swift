//
//  PokeApi.swift
//  PokeCase
//
//  Created by İbrahim Ballıbaba on 4.11.2022.
//

import Foundation
import Alamofire

protocol PokeApiProtocol: AnyObject {
    func getPokemon(_ isSuccess: Bool)
}

final class PokeApi {
    weak var pokeApiDelegate: PokeApiProtocol?
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    var allPokes = [AllPokemons]()
    var nextPokes: String?
    
    //Alamofire
    func getAllPoke(){
        AF.request(baseURL).response {[weak self] response in
            guard let self = self else {return}
            
            guard let data = response.data else { return }
            do {
                let pokemon = try JSONDecoder().decode(Pokemons.self, from: data)
                print(pokemon.next)
                self.nextPokes = pokemon.next
                self.allPokes = pokemon.results
                self.pokeApiDelegate?.getPokemon(true)
                //print("\(self.allPokes)")
                print("success api")
            } catch {
                print("Error api")
                self.pokeApiDelegate?.getPokemon(false)
                return
            }
        }
    }
    
    func deneme(_ stringDe: URL){
        AF.request(stringDe).response {[weak self] response in
            guard let self = self else {return}
            
            guard let data = response.data else { return }
            do {
                let pokemon = try JSONDecoder().decode(Pokemons.self, from: data)
                print(pokemon.next)
                self.nextPokes = pokemon.next
                self.allPokes.append(contentsOf: pokemon.results)
                self.pokeApiDelegate?.getPokemon(true)
                //print("\(self.allPokes)")
                print("success api")
            } catch {
                print("Error api")
                self.pokeApiDelegate?.getPokemon(false)
                return
            }
        }
    }
}
