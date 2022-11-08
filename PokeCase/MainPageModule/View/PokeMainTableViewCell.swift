//
//  PokeMainTableViewCell.swift
//  PokeCase
//
//  Created by İbrahim Ballıbaba on 4.11.2022.
//

import UIKit
import FirebaseRemoteConfig

class PokeMainTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    let remoteConfig = RemoteConfig.remoteConfig()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
        pokeNameLabel.textColor = .white
        fetchValue()
    }
    
    func fetchValue(){
        updateView(updateView: false)
        
        self.remoteConfig.fetch(withExpirationDuration: 0) { status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate(completion: { _, error in
                    guard error == nil else{
                        return
                    }
                    let value = self.remoteConfig.configValue(forKey: "shows_new_ui").boolValue
                    print("Fetched: \(value)")
                    DispatchQueue.main.async {
                        self.updateView(updateView: value)
                    }
                })
            }else{
                print("wrong something")
            }
        }
    }
    
    func updateView(updateView: Bool){
        if updateView{
            containerView.backgroundColor = .blue
        }else{
            containerView.backgroundColor = .orange
        }
    }
}
