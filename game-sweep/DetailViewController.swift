//
//  DetailViewController.swift
//  game-sweep
//
//  Created by David Kumar on 4/23/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var eventTitle: UILabel!
    
    private let unlikedImage = UIImage(named: "heartBlank")
    private let likedImage = UIImage(named: "heartRed")
    private var isLiked = false
    private let unlikedScale: CGFloat = 0.7
    private let likedScale: CGFloat = 1.3
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    public func flipLikedState(){
        
        isLiked = !isLiked
        animate()
    }
    
    private func animate(){
        
        UIView.animate(withDuration: 0.1, animations: {
          let newImage = self.isLiked ? self.likedImage : self.unlikedImage
          let newScale = self.isLiked ? self.likedScale : self.unlikedScale
            self.heartButton.transform = self.heartButton.transform.scaledBy(x: newScale, y: newScale)
            self.heartButton.setImage(newImage, for: .normal)
        }, completion: { _ in
          UIView.animate(withDuration: 0.1, animations: {
            self.heartButton.transform = CGAffineTransform.identity
          })
        })
    }
    
    
    


}
