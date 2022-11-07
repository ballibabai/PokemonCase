//
//  DetailCollectionViewCell.swift
//  PokeCase
//
//  Created by İbrahim Ballıbaba on 5.11.2022.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pokeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
    }

}
