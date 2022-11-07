//
//  PokeMainTableViewCell.swift
//  PokeCase
//
//  Created by İbrahim Ballıbaba on 4.11.2022.
//

import UIKit

class PokeMainTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.backgroundColor = .purple
        containerView.layer.cornerRadius = 8
        pokeNameLabel.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
