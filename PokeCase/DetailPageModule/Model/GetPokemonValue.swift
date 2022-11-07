//
//  GetPokemonValue.swift
//  PokeCase
//
//  Created by İbrahim Ballıbaba on 5.11.2022.
//

import Foundation
import Alamofire

protocol PokeDetailProtocol: AnyObject {
    func getJustPokemon(_ isSuccess: Bool)
}

final class GetPokemonValue {
    weak var getPokemonDelegate: PokeDetailProtocol?
    var pokemon: Pokemon?
  //  var photoString: String?
   // var versions: PokemonEntity?
    //with alamofire
    func getVersionsPoke(_ urlString: String){
            let baseURL = URL(string: urlString)
            let requestURL = baseURL!
            print(requestURL)
            let request = URLRequest(url: requestURL)
            AF.request(request).response {response in
               // guard let self = self else {return}
                
                print(response)
                guard let data = response.data else { return }
                do {
                    print(data)
                    let versionsArray = try JSONDecoder().decode(Pokemon.self, from: data)
                    print(versionsArray)
                    self.pokemon = versionsArray
                    self.getPokemonDelegate?.getJustPokemon(true)
                    print("Success DetailApi")
                } catch {
                    print("Error PokemonApissss")
                    self.getPokemonDelegate?.getJustPokemon(false)
                    return
            }
        }
    }
    
    
    func holdPhotos() -> [String]{
        var stringPhotos = [String]()

        let img0 = pokemon?.sprites.frontDefault
        let img1 = pokemon?.sprites.backShiny
        let img2 = pokemon?.sprites.backDefault
        let img3 = pokemon?.sprites.frontShiny
        let img4 = pokemon?.sprites.versions?.generationIi.crystal.frontDefault
        let img5 = pokemon?.sprites.versions?.generationIi.crystal.frontShiny
        let img6 = pokemon?.sprites.versions?.generationIi.crystal.backDefault

        stringPhotos.append(img0!)
        stringPhotos.append(img1!)
        stringPhotos.append(img2!)
        stringPhotos.append(img3!)
        stringPhotos.append(img4!)
        stringPhotos.append(img5!)
        stringPhotos.append(img6!)

        
        return stringPhotos
        self.getPokemonDelegate?.getJustPokemon(true)
    }
}
