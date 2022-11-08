//
//  PokeMainVC.swift
//  PokeCase
//
//  Created by İbrahim Ballıbaba on 4.11.2022.
//

import UIKit
import Firebase

class PokeMainVC: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    private let pokemonVM = PokemonViewModel()
    var allPoke = [AllPokemons]()
    var perPage = 20
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonVM.didViewLoad()
        pokemonVM.pokemonVMDelegate = self
        setupUI()
    }
    
    //MARK: - Functions
}

//MARK: - Extensions
private extension PokeMainVC {
    func setupUI(){
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
    }
    
    func registerCell(){
        tableView.register(.init(nibName: "PokeMainTableViewCell", bundle: nil), forCellReuseIdentifier: "PokeMainTableViewCell")
    }
}
extension PokeMainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        Analytics.logEvent("Clicked Something", parameters: nil)
        let destinDetail = DetailVC(nibName: "DetailVC", bundle: nil)
        let destin = allPoke[indexPath.row].url
        destinDetail.changePokemon(destin)
        self.navigationController?.pushViewController(destinDetail, animated: true)

       // print(destin)
    }
}
extension PokeMainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPoke.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeMainTableViewCell") as! PokeMainTableViewCell
    
        cell.pokeNameLabel.text = allPoke[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == allPoke.count - 1 {
            if allPoke.count % perPage == 0 {
                perPage += 20
                let strPage = String(perPage)
                let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=\(strPage)&limit=20")!
                 //moreData()
                pokemonVM.deneme2(url)
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
}

extension PokeMainVC: PokemonViewModelProtocol {
    func getAllPokes(_ poke: [AllPokemons]) {
        self.allPoke = poke
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
