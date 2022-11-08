//
//  DetailVC.swift
//  PokeCase
//
//  Created by İbrahim Ballıbaba on 5.11.2022.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {
    
    //MARK: - UI Elements
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet weak var hpLabel: UIStackView!
    @IBOutlet weak var attackLabel: UIStackView!
    @IBOutlet weak var defenseLabel: UIStackView!
    @IBOutlet weak var specialAttackLabel: UIStackView!
    @IBOutlet weak var specialDefenceLabel: UIStackView!
    @IBOutlet weak var hpValueLabel: UILabel!
    @IBOutlet weak var attackValueLabel: UILabel!
    @IBOutlet weak var defenseValueLabel: UILabel!
    @IBOutlet weak var specialAttackValueLabel: UILabel!
    @IBOutlet weak var specialDefenseValueLabel: UILabel!
    
    
    //MARK: - Properties
    private let getPokemonVM = GetPokemonViewModel()
    var poke: Pokemon?
    var stringPokes = [String]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPokemonVM.getPokemonVMDelegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hpValueLabel.text = "0"
        attackValueLabel.text = "0"
        defenseValueLabel.text = "0"
        specialAttackValueLabel.text = "0"
        specialDefenseValueLabel.text = "0"
    }

    
    override func viewDidAppear(_ animated: Bool) {
        guard let poke = poke else {

            let alert = UIAlertController(title: "Error", message: "Wrong something", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(okButton)
            present(alert, animated: true)
            return
        }

        hpValueLabel.text = String((poke.stats[0].baseStat))
        attackValueLabel.text = String((poke.stats[1].baseStat))
        defenseValueLabel.text = String((poke.stats[2].baseStat))
        specialAttackValueLabel.text = String((poke.stats[3].baseStat))
        specialDefenseValueLabel.text = String((poke.stats[4].baseStat))
    }
    
    //MARK: - Functions
    func changePokemon(_ urlString: String){
        getPokemonVM.didViewLoad(urlString)
    }
}

//MARK: - Extensions
private extension DetailVC {
    func setupUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
    }
    
    func registerCell(){
        collectionView.register(.init(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailCollectionViewCell")
    }
}

extension DetailVC: UICollectionViewDelegate{
    
}

extension DetailVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stringPokes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as! DetailCollectionViewCell
       
       let resourcess = ImageResource(downloadURL: URL(string: stringPokes[indexPath.row])!, cacheKey: stringPokes[indexPath.row]) //caching
       //let url = URL(string: stringPokes[indexPath.row])
       cell.pokeImageView.kf.setImage(with: resourcess)
        return cell
    }
}

extension DetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: (collectionView.frame.width - 30) / 3, height: collectionView.frame.height / 2)
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
      }
}

extension DetailVC: GetPokemonVMProtocol{
    func stringUrl(_ stringUrl: [String]) {
        self.stringPokes = stringUrl
    }
    func getPokeArray(_ poke: Pokemon) {
        self.poke = poke
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
