//
//  ViewController.swift
//  game-sweep
//
//  Created by David Kumar on 4/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    final let url = URL(string: "https://api.seatgeek.com/2/events?client_id=" + CLIENT_ID)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJson()
    }
    
    func downloadJson(){
        
        guard let downloadURL = url else{
            return
        }
        
        URLSession.shared.dataTask(with: downloadURL){data, urlReponse, error in
            
            guard let data = data, error == nil, urlReponse != nil else{
                
                print("network error")
                return
            }
            
            do{
                
                let decoder = JSONDecoder()
                let events = try decoder.decode(Events.self, from: data)
                print(events.events[0].id)
            }
            catch{
                
                print("error parsing JSON")
            }
                                                       
        }.resume()
    }
    
   
    
    


}

