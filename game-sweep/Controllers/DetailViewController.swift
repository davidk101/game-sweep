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
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    private let unlikedImage = UIImage(named: "heartBlank")
    private let likedImage = UIImage(named: "heartRed")
    private var isLiked = false
    private let unlikedScale: CGFloat = 0.7
    private let likedScale: CGFloat = 1.3
    
    var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observer = NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "cellData"), object: nil, queue: .main, using: { (notification) in
            
            guard let object = notification.object as? [String: String] else{
                
                return
            }
            
            guard let titleString = object["titleString"] else{
                
                return
            }
            
            guard let locationString = object["locationString"] else{
                
                return
            }
            
            guard let timeString = object["timeString"] else{
                
                return
            }
            
            guard let imageURLString = object["imageURLString"] else{
                
                return
            }
            
            /*DispatchQueue.main.async{
                
                self.setLabels(titleString: titleString, locationString: locationString, timeString: timeString, imageURLString: imageURLString)
            }*/
    
            self.eventTitle.text = titleString
            
        })
    }
    
    private func setLabels(titleString: String, locationString: String, timeString: String, imageURLString: String){
        
        
        DispatchQueue.main.async {
            
            self.time.text = timeString
            self.location.text = locationString
            self.eventTitle.text = titleString
                    
            if let imageURL = URL(string: imageURLString){
                
                DispatchQueue.global().async {
                    
                    let data = try? Data(contentsOf: imageURL)
                    
                    if let data = data{
                        
                        let image = UIImage(data: data)
                        
                        DispatchQueue.main.async {
                            
                            self.imgView.image = image
                        }
                    }
                }
            }
        }
        
    }
    
    public func flipLikedState(){
        
        isLiked = !isLiked
        animate()
    }
    
    @IBAction func buttonToggled(_ sender: Any) {
        
        flipLikedState()
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
