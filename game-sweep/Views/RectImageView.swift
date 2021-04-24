//
//  RectImageView.swift
//  game-sweep
//
//  Created by David Kumar on 4/24/21.
//

import UIKit

class RectImageView: UIImageView{
    
    override func awakeFromNib() {
        
        setupView()
    }
    
    func setupView(){
        
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 3
        
        
    }
}
