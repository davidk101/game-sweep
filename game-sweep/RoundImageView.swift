//
//  RoundImageView.swift
//  game-sweep
//
//  Created by David Kumar on 4/24/21.
//

import UIKit

class RoundImageView: UIImageView{
    
    override func awakeFromNib() {
        
        setupView()
    }
    
    func setupView(){
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
        
    }
}
